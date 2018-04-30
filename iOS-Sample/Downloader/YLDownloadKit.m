//
//  YLDownloadKit.m
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import "YLDownloadKit.h"

@interface YLDownloadKitCombinedOperation : NSObject

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) void (^cancelBlock)();

@end

@interface YLDownloadKit ()

@property (nonatomic, strong, readwrite)YLDownloadCache* downloadCache;
@property (nonatomic, strong, readwrite)YLDownloader* downloader;
@property (nonatomic, strong)NSMutableArray* failedURLs;
@property (nonatomic, strong)NSMutableArray* runningOperations;

@end

@implementation YLDownloadKit

+ (id)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = self.new;
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        _downloadCache = [self _createCache];
        _downloader = YLDownloader.new;
        _failedURLs = NSMutableArray.new;
        _runningOperations = NSMutableArray.new;
    }
    
    return self;
}

- (YLDownloadCache*)_createCache
{
    return [YLDownloadCache sharedInstance];
}

- (NSString*)_cacheKeyForURL:(NSURL*)url
{
    return [url absoluteString];
}

- (id)downloadWithURL:(NSURL *)url
              options:(YLDownloadKitOptions)options
             progress:(YLDownloaderProgressBlock)progressBlock
            completed:(YLDownloadKitCompletedWithFinishedBlock)completedBlock
{
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString*)url];
    }
    
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }
    
    __block YLDownloadKitCombinedOperation* operation = YLDownloadKitCombinedOperation.new;
    __weak YLDownloadKitCombinedOperation* weakOperation = operation;
    
    BOOL isFailedURL = NO;
    @synchronized(self.failedURLs) {
        isFailedURL = [self.failedURLs containsObject:url];
    }
    
    if (!url || !completedBlock || (!(options & YLDownloadRetryFailed) && isFailedURL)) {
        if (completedBlock) {
            completedBlock(nil, nil, YLDownloaderNoneOption, NO);
            return operation;
        }
    }
    
    @synchronized(self.runningOperations) {
        [self.runningOperations addObject:operation];
    }
    NSString* key = [self _cacheKeyForURL:url];
    [self.downloadCache queryDiskCacheForKey:key done:^(NSData *data) {
        if (operation.isCancelled) {
            return;
        }
        
        if (!data) {
            __block id subOperation = [self.downloader downloadFileWithURL:url
                                                                   options:0
                                                                  progress:progressBlock
                                                                 completed:^(NSString *path, NSData *downloadData, NSError *error, BOOL finished)
                                       {
                                           if (weakOperation.cancelled) {
                                               completedBlock(nil, nil, YLDownloaderNoneOption, finished);
                                           } else if (error) {
                                               completedBlock(nil, error, YLDownloaderNoneOption, finished);
                                               if (error.code != NSURLErrorNotConnectedToInternet) {
                                                   @synchronized(self.failedURLs) {
                                                       [self.failedURLs addObject:url];
                                                   }
                                               }
                                           } else {
                                               if (downloadData && finished) {
                                                   [self.downloadCache storeData:downloadData forKey:key toDisk:YES complete:^{
                                                       completedBlock(downloadData, nil, YLDownloaderNoneOption, finished);
                                                   }];
                                               }

                                           }
                                           if (finished) {
                                               @synchronized(self.runningOperations) {
                                                   [self.runningOperations removeObject:operation];
                                               }
                                           }
                                       }];
            operation.cancelBlock = ^{[subOperation cancel];};
        } else {
            completedBlock(data, nil, 0, YES);
            @synchronized(self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
    }];
    
    return operation;
}

- (void)cancelAll
{
    @synchronized(self.runningOperations) {
        [self.runningOperations makeObjectsPerformSelector:@selector(cancel)];
        [self.runningOperations removeAllObjects];
    }
}

- (BOOL)isRunning{
    return self.runningOperations.count > 0;
}

@end

@implementation YLDownloadKitCombinedOperation
- (void)setCancelBlock:(void (^)())cancelBlock
{
    if (self.isCancelled) {
        if (cancelBlock) {
            cancelBlock();
        }
    } else {
        _cancelBlock = [cancelBlock copy];
    }
}

- (void)cancel
{
    self.cancelled = YES;
    if (self.cancelBlock) {
        self.cancelBlock();
        self.cancelBlock = nil;
    }
}

@end
