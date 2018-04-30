//
//  YLDownloader.m
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import "YLDownloader.h"
#import "YLDownloadMP4Operation.h"

NSString* const YLDownloadStartNotification = @"YLDownloadStartNotification";
NSString* const YLDownloadStopNotification = @"YLDownloadStopNotification";

static NSString *const kProgressCallbackKey = @"progress";
static NSString *const kCompletedCallbackKey = @"completed";

@interface YLDownloader ()

@property (nonatomic, strong)NSOperationQueue* downloadQueue;
@property (nonatomic, weak)NSOperation* lastAddedOperation;
@property (nonatomic, strong)NSMutableDictionary* URLCallbacks;
@property (nonatomic, strong)NSMutableDictionary* HTTPHeaders;

@property ( nonatomic) dispatch_queue_t barrierQueue;

@end
@implementation YLDownloader
+ (YLDownloader*)sharedInstance
{
    static dispatch_once_t once;
    static YLDownloader* singleton;
    dispatch_once(&once, ^{singleton = self.new;});
    return singleton;
}

- (id)init
{
    if (self = [super init]) {
        _downloadQueue = NSOperationQueue.new;
        _downloadQueue.maxConcurrentOperationCount = 2;
        _URLCallbacks = NSMutableDictionary.new;
        _HTTPHeaders = NSMutableDictionary.new;
        _barrierQueue = dispatch_queue_create("li.yuan.YLDownloaderBarrierQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

- (void)dealloc
{
    [self.downloadQueue cancelAllOperations];
//    dispatch_release(_barrierQueue);
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    if (value) {
        self.HTTPHeaders[field] = value;
    } else {
        [self.HTTPHeaders removeObjectForKey:field];
    }
}

- (NSString*)valueForHTTPHeaderField:(NSString *)field
{
    return self.HTTPHeaders[field];
}

- (void)setMaxConcurrentDownloads:(NSInteger)maxConcurrentDownloads
{
    _downloadQueue.maxConcurrentOperationCount = maxConcurrentDownloads;
}

- (NSInteger)maxConcurrentDownloads
{
    return _downloadQueue.maxConcurrentOperationCount;
}

- (void)_addProgressCallback:(YLDownloaderProgressBlock)progressBlock
               completeBlock:(YLDownloaderCompletedBlock)completeBlock
                      forURL:(NSURL*)url
              createCallback:(void (^)())createCallback
{
    if (nil == url) {
        if (completeBlock != nil) {
            completeBlock(nil, nil, nil, NO);
        }
        return;
    }
    
    dispatch_barrier_sync(self.barrierQueue, ^{
        BOOL first = NO;
        if (!self.URLCallbacks[url]) {
            self.URLCallbacks[url] = NSMutableArray.new;
            first = YES;
        }
        
        NSMutableArray* callbacksForURL = self.URLCallbacks[url];
        NSMutableDictionary* callbacks = NSMutableDictionary.new;
        if (progressBlock) {
            callbacks[kProgressCallbackKey] = [progressBlock copy];
        }
        if (completeBlock) {
            callbacks[kCompletedCallbackKey] = [completeBlock copy];
        }
        [callbacksForURL addObject:callbacks];
        self.URLCallbacks[url] = callbacksForURL;
        
        if (first) {
            createCallback();
        }
    });
}

- (NSArray *)callbacksForURL:(NSURL *)url
{
    __block NSArray *callbacksForURL;
    dispatch_sync(self.barrierQueue, ^{
        callbacksForURL = self.URLCallbacks[url];
    });
    return callbacksForURL;
}

- (void)removeCallbacksForURL:(NSURL *)url
{
    dispatch_barrier_async(self.barrierQueue, ^{
        [self.URLCallbacks removeObjectForKey:url];
    });
}


- (id)downloadFileWithURL:(NSURL *)url
                  options:(YLDownloaderOptions)options
                 progress:(YLDownloaderProgressBlock)progressBlock
                completed:(YLDownloaderCompletedBlock)completeBlock
{
    __block YLDownloadMP4Operation* operation;
    __weak YLDownloader* weakself = self;
    
    [self _addProgressCallback:progressBlock
                 completeBlock:completeBlock
                        forURL:url
                createCallback:^{
                    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
                    request.HTTPShouldHandleCookies  = NO;
                    request.HTTPShouldUsePipelining = YES;
                    request.allHTTPHeaderFields = weakself.HTTPHeaders;
                    operation = [[YLDownloadMP4Operation alloc] initWithRequest:request
                                                                        options:options
                                                                       progress:^(NSUInteger receivedSize, long long expectedSize)
                                 {
                                     if (!weakself) {
                                         return;
                                     }
                                     YLDownloader* sself = weakself;
                                     NSArray* callBacksForURL = [sself callbacksForURL:url];
                                     for (NSDictionary* callbacks in [callBacksForURL copy]) {
                                         YLDownloaderProgressBlock callBlock = callbacks[kProgressCallbackKey];
                                         if (callBlock) {
                                             callBlock(receivedSize, expectedSize);
                                         }
                                     }
                                 }
                                                                      completed:^(NSString *path, NSData *data, NSError *error, BOOL finished)
                                 {
                                     if (!weakself) {
                                         return;
                                     }
                                     YLDownloader* sself = weakself;
                                     NSArray* callBacksForURL = [sself callbacksForURL:url];
                                     if (finished) {
                                         [sself removeCallbacksForURL:url];
                                     }
                                     for (NSDictionary* callbacks in [callBacksForURL copy]) {
                                         YLDownloaderCompletedBlock callBlock = callbacks[kCompletedCallbackKey];
                                         if (callBlock) {
                                             callBlock(path, data, error, finished);
                                         }
                                     }
                                 }
                                                                      cancelled:^
                                 {
                                     if (!weakself) {
                                         return;
                                     }
                                     YLDownloader* sself = weakself;
                                     [sself callbacksForURL:url];
                                     [sself removeCallbacksForURL:url];
                                 }];
                    [weakself.downloadQueue addOperation:operation];
    }];
    
    return operation;
}

@end
