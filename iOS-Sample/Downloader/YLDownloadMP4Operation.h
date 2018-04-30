//
//  YLDownloadMP4Operation.h
//  YLDownloadKit
//
//  Created by Eric Yuan on 13-5-19.
//  Copyright (c) 2013年 Eric Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLDownloader.h"

@interface YLDownloadMP4Operation : NSOperation<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, readonly, strong)NSURLRequest* request;
@property (nonatomic, readonly, assign)YLDownloaderOptions options;

- (id)initWithRequest:(NSURLRequest *)request
              options:(YLDownloaderOptions)options
             progress:(YLDownloaderProgressBlock)progressBlock
            completed:(YLDownloaderCompletedBlock)completedBlock
            cancelled:(void (^)())cancelBlock;

@end
