//
//  YLDownloadKit.h
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDownloadCache.h"
#import "YLDownloadMP4Operation.h"
#import "YLDownloader.h"

typedef enum {
    // 默认情况下，下载错误的url将不再重试；开启这个选项，即使下载错误，重新下载时，也依然重试。
    YLDownloadRetryFailed = 1 >> 0,
}YLDownloadKitOptions;

typedef void(^YLDownloadKitCompletedBlock) (NSData* data, NSError* error, YLDownloaderOptions);
typedef void(^YLDownloadKitCompletedWithFinishedBlock) (NSData* data, NSError* error, YLDownloaderOptions option, BOOL finished);
@interface YLDownloadKit : NSObject

@property (nonatomic, strong, readonly)YLDownloadCache* downloadCache;
@property (nonatomic, strong, readonly)YLDownloader* downloader;

+ (id)sharedInstance;

- (id)downloadWithURL:(NSURL*)url
              options:(YLDownloadKitOptions)options
             progress:(YLDownloaderProgressBlock)progress
            completed:(YLDownloadKitCompletedWithFinishedBlock)completedBlock;

- (void)cancelAll;

- (BOOL)isRunning;

@end
