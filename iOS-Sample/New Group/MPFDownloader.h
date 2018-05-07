//
//  MPFDownloader.h
//  iOS-Sample
//
//  Created by 荣守振 on 2018/5/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPFloaderCommon.h" // ??

@interface MPFDownloader : NSObject
<
NSURLConnectionDataDelegate,
NSURLConnectionDelegate
>

@property(nonatomic, strong) NSURLConnection       *con;
@property(nonatomic, copy, readonly) MPFProcessHandle    process;
@property(nonatomic, copy, readonly) MPFCompletionHandle completion;
@property(nonatomic, copy, readonly) MPFFailureHandle    failure;

+ (instancetype)downloader;

/**
 *  断点下载(get)
 *
 *  @param  urlString        下载的链接
 *  @param  destinationPath  下载的文件的保存路径
 *  @param  process         进度的回调，会多次调用
 *  @param  completion      下载完成的回调
 *  @param  failure         下载失败的回调
 */
- (void)downloadUrl:(NSString *)urlString
             toPath:(NSString *)destinationPath
            process:(MPFProcessHandle)process
         completion:(MPFCompletionHandle)completion
            failure:(MPFFailureHandle)failure;

/**
 *  断点下载(post)
 *
 *  @param  host            下载的链接
 *  @param  p               post参数
 *  @param  destinationPath 下载的文件的保存路径
 *  @param  process         进度的回调，会多次调用
 *  @param  completion      下载完成的回调
 *  @param  failure         下载失败的回调
 */
- (void)downloadHost:(NSString *)host
               param:(NSString *)p
              toPath:(NSString *)destinationPath
             process:(MPFProcessHandle)process
          completion:(MPFCompletionHandle)completion
             failure:(MPFFailureHandle)failure;

/**取消下载*/
- (void)cancel;

/**获取上一次的下载进度*/
+ (float)lastProgress:(NSString *)url;

/**已下载的大小/文件总大小,如：12.00M/100.00M*/
+ (NSString *)filesSize:(NSString *)url;


@end
