//
//  YLDownloader.h
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    YLDownloaderProgressiveDownload = 1 >> 0,
    YLDownloaderNoneOption = 0
}YLDownloaderOptions;

typedef void(^YLDownloaderProgressBlock)(NSUInteger receivedSize, long long expectedSize);
typedef void(^YLDownloaderCompletedBlock)(NSString* path, NSData *data, NSError *error, BOOL finished);

extern NSString *const YLDownloadStartNotification;
extern NSString *const YLDownloadStopNotification;

@interface YLDownloader : NSObject

@property (assign, nonatomic)NSInteger maxConcurrentDownloads;

+ (YLDownloader*)sharedInstance;

- (void)setValue:(NSString*)value forHTTPHeaderField:(NSString *)field;

- (NSString*)valueForHTTPHeaderField:(NSString*)field;

- (id)downloadFileWithURL:(NSURL*)url
                  options:(YLDownloaderOptions)options
                 progress:(YLDownloaderProgressBlock)progressBlock
                completed:(YLDownloaderCompletedBlock)completeBlock;
@end
