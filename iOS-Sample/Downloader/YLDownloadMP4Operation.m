//
//  YLDownloadMP4Operation.m
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import "YLDownloadMP4Operation.h"

@interface YLDownloadMP4Operation ()

@property (nonatomic, copy)YLDownloaderProgressBlock progressBlock;
@property (nonatomic, copy)YLDownloaderCompletedBlock completeBlock;
@property (nonatomic, copy)void (^cancelBlock)();

@property (assign, nonatomic, getter = isDownExecuting)BOOL downExecuting;
@property (assign, nonatomic, getter = isDownFinished)BOOL downFinished;
@property (assign, nonatomic)long long expectedSize;
@property (strong, nonatomic)NSMutableData* downloadData;
@property (strong, nonatomic)NSURLConnection* connection;
@property (strong, nonatomic)NSString* cacheFolder;

@end

@implementation YLDownloadMP4Operation


- (id)initWithRequest:(NSURLRequest *)request
              options:(YLDownloaderOptions)options
             progress:(YLDownloaderProgressBlock)progressBlock
            completed:(YLDownloaderCompletedBlock)completedBlock
            cancelled:(void (^)())cancelBlock
{
    if (self = [super init]) {
        _request = request;
        _options = options;
        _progressBlock = [progressBlock copy];
        _completeBlock = [completedBlock copy];
        _downExecuting = NO;
        _downFinished = NO;
        _expectedSize = 0;
    }
    
    return self;
}

- (void)reset
{
    self.cancelBlock = nil;
    self.completeBlock = nil;
    self.progressBlock = nil;
    self.connection = nil;
    self.downloadData = nil;
}

- (void)start
{
    if (self.isCancelled) {
        self.finished = YES;
        [self reset];
        return;
    }
    
    self.executing = YES;
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    
    [self.connection start];
    
    if (self.connection) {
        if (self.progressBlock) {
            self.progressBlock(0, -1);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:YLDownloadStartNotification object:self];
        
        CFRunLoopRun();
    } else {
        if (self.completeBlock) {
            self.completeBlock(nil, nil, [NSError errorWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: @"Connection can't be initialized"}], YES);
        }
    }
}

- (void)cancel
{
    if (self.isFinished) {
        return;
    }
    [super cancel];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    if (self.connection) {
        [self.connection cancel];
        [[NSNotificationCenter defaultCenter] postNotificationName:YLDownloadStopNotification object:self];
        
        if (self.isExecuting) {
            self.executing = NO;
        }
        if (!self.isFinished) {
            self.finished = YES;
        }
    }
    
    [self reset];
}

- (void)done
{
    self.finished = YES;
    self.executing = NO;
    [self reset];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _downFinished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _downFinished = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isConcurrent
{
    return YES;
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (![response respondsToSelector:@selector(statusCode)] || [(NSHTTPURLResponse*)response statusCode] < 400) {
        NSUInteger expected = response.expectedContentLength > 0 ? (NSUInteger)response.expectedContentLength : 0;
        //////////NSLog(@"expect length %d", expected);
        self.expectedSize = expected;
        if (self.progressBlock) {
            self.progressBlock(0, expected);
        }
        
        self.downloadData = [NSMutableData.alloc initWithCapacity:expected];
    } else {
        [self.connection cancel];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:YLDownloadStopNotification object:nil];
        
        if (self.completeBlock) {
            self.completeBlock(nil, nil, [NSError errorWithDomain:NSURLErrorDomain code:[(NSHTTPURLResponse*)response statusCode] userInfo:nil], YES);
        }
        
        [self done];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.downloadData appendData:data];
    
    if ((self.options & YLDownloaderProgressiveDownload) && self.expectedSize > 0 && self.completeBlock) {
        // TODO: some stuff to support progressive download
    }
    
    if (self.progressBlock) {
        self.progressBlock(self.downloadData.length, self.expectedSize);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.connection = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YLDownloadStopNotification object:nil];
    
    YLDownloaderCompletedBlock completionBlock = self.completeBlock;
    
    if (completionBlock) {
        if ([self.downloadData length] == 0) {
            completionBlock(nil, nil, [NSError errorWithDomain:@"YLDownloadErrorDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: @"download data's length is 0"}], YES);
        } else {
            completionBlock(nil, self.downloadData, nil, YES);
        }
        // prevent some spelling mistake.
        self.completionBlock = nil;
        [self done];
    } else {
        [self done];
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    [[NSNotificationCenter defaultCenter] postNotificationName:YLDownloadStopNotification object:self];
    
    if (self.completeBlock) {
        self.completeBlock(nil, nil, error, YES);
    }
    
    [self done];
}
@end
