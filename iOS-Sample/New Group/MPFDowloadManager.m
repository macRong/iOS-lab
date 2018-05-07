//
//  MPFDowloadManager.m
//  iOS-Sample
//
//  Created by 荣守振 on 2018/5/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "MPFDowloadManager.h"

/**最大同时下载任务数，超过将自动存入排队对列中*/
#define kMPFDwonloadMaxTaskCount 2

@implementation MPFDowloadManager
{
    
    NSMutableDictionary         *_taskDict;
    /**排队对列*/
    NSMutableArray              *_queue;
    /**  后台进程id*/
    UIBackgroundTaskIdentifier  _backgroudTaskId;
}

- (instancetype)init
{
    if (self=[super init])
    {
        _taskDict=[NSMutableDictionary dictionary];
        _queue=[NSMutableArray array];
        _backgroudTaskId=UIBackgroundTaskInvalid;
        //注册系统内存不足的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemSpaceInsufficient:) name:MPFInsufficientSystemSpaceNotification object:nil];
        //注册程序下载完成的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskDidFinishDownloading:) name:MPFDownloadTaskDidFinishNotification object:nil];
        //注册程序即将失去焦点的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskWillResign:) name:UIApplicationWillResignActiveNotification object:nil];
        //注册程序获得焦点的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskDidBecomActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        //注册程序即将被终结的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskWillBeTerminate:) name:UIApplicationWillTerminateNotification object:nil];
        
    }
    return self;
}

- (void)systemSpaceInsufficient:(NSNotification *)sender
{
    NSString *urlString=[sender.userInfo objectForKey:@"urlString"];
    [[MPFDowloadManager shredManager] cancelDownloadTask:urlString];
}

- (void)downloadTaskWillResign:(NSNotification *)sender
{
    if (_taskDict.count>0)
    {
        _backgroudTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            
        }];
    }
}

- (void)downloadTaskDidBecomActive:(NSNotification *)sender
{
    if (_backgroudTaskId!=UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroudTaskId];
        _backgroudTaskId=UIBackgroundTaskInvalid;
    }
}

- (void)downloadTaskWillBeTerminate:(NSNotification *)sender
{
    [[MPFDowloadManager shredManager] cancelAllTasks];
}

- (void)downloadTaskDidFinishDownloading:(NSNotification *)sender
{
    //下载完成后，从任务列表中移除下载任务，若总任务数小于最大同时下载任务数，
    //则从排队对列中取出一个任务，进入下载
    NSString *urlString=[sender.userInfo objectForKey:@"urlString"];
    [_taskDict removeObjectForKey:urlString];
    if (_taskDict.count<kMPFDwonloadMaxTaskCount)
    {
        if (_queue.count>0)
        {
            @synchronized(_queue)
            {
                NSDictionary *first=[_queue objectAtIndex:0];
                
                [self downloadUrl:first[@"urlString"]
                           toPath:first[@"destinationPath"]
                          process:first[@"process"]
                       completion:first[@"completion"]
                          failure:first[@"failure"]];
                //从排队对列中移除一个下载任务
                [_queue removeObjectAtIndex:0];
            }
        }
    }
}

static MPFDowloadManager *mgr=nil;

+ (instancetype)shredManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr=[[MPFDowloadManager alloc]init];
    });
    return mgr;
}

- (void)downloadUrl:(NSString *)urlString toPath:(NSString *)destinationPath process:(MPFProcessHandle)process completion:(MPFCompletionHandle)completion failure:(MPFFailureHandle)failure
{
    //若同时下载的任务数超过最大同时下载任务数，
    //则把下载任务存入对列，在下载完成后，自动进入下载。
    if (_taskDict.count>=kMPFDwonloadMaxTaskCount)
    {
        NSDictionary *dict=@{@"urlString":urlString,
                             @"destinationPath":destinationPath,
                             @"process":process,
                             @"completion":completion,
                             @"failure":failure};
        [_queue addObject:dict];
        
        return;
    }
    
    MPFDownloader *downloader=[MPFDownloader downloader];
    @synchronized (self)
    {
        [_taskDict setObject:downloader forKey:urlString];
    }
    
    [downloader downloadUrl:urlString
                     toPath:destinationPath
                    process:process
                 completion:completion
                    failure:failure];
}

- (void)downloadHost:(NSString *)host
               param:(NSString *)p
              toPath:(NSString *)destinationPath
             process:(MPFProcessHandle)process
          completion:(MPFCompletionHandle)completion
             failure:(MPFFailureHandle)failure
{
    //若同时下载的任务数超过最大同时下载任务数，
    //则把下载任务存入对列，在下载完成后，自动进入下载。
    NSString *tmpUrl = @"";
    if (p != nil)
    {
        tmpUrl=[NSString stringWithFormat:@"%@?%@",host,p];
    }
    else
    {
        tmpUrl = host;
    }
    
    if (_taskDict.count>=kMPFDwonloadMaxTaskCount)
    {
        NSDictionary *dict=@{@"urlString":tmpUrl,
                             @"destinationPath":destinationPath,
                             @"process":process,
                             @"completion":completion,
                             @"failure":failure};
        [_queue addObject:dict];
        
        return;
    }
    
    MPFDownloader *downloader=[MPFDownloader downloader];
    @synchronized (self)
    {
        [_taskDict setObject:downloader forKey:tmpUrl];
    }
    
    [downloader downloadHost:host
                       param:p
                      toPath:destinationPath
                     process:process
                  completion:completion
                     failure:failure];
}

- (void)cancelDownloadTask:(NSString *)url
{
    MPFDownloader *downloader=[_taskDict objectForKey:url];
    [downloader cancel];
    @synchronized (self)
    {
        [_taskDict removeObjectForKey:url];
    }
    
    if (_queue.count>0)
    {
        NSDictionary *first=[_queue objectAtIndex:0];
        
        [self downloadUrl:first[@"urlString"]
                   toPath:first[@"destinationPath"]
                  process:first[@"process"]
               completion:first[@"completion"]
                  failure:first[@"failure"]];
        //从排队对列中移除一个下载任务
        [_queue removeObjectAtIndex:0];
    }
}

- (void)removeForUrl:(NSString *)url file:(NSString *)path
{
    MPFDownloader *downloader=[_taskDict objectForKey:url];
    if (downloader)
    {
        [downloader cancel];
    }
    
    @synchronized (self)
    {
        [_taskDict removeObjectForKey:url];
    }
    NSUserDefaults *usd=[NSUserDefaults standardUserDefaults];
    NSString *totalLebgthKey=[NSString stringWithFormat:@"%@totalLength",url];
    NSString *progressKey=[NSString stringWithFormat:@"%@progress",url];
    [usd removeObjectForKey:totalLebgthKey];
    [usd removeObjectForKey:progressKey];
    [usd synchronize];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL fileExist=[fileManager fileExistsAtPath:path];
    if (fileExist)
    {
        [fileManager removeItemAtPath:path error:nil];
    }
}

- (void)cancelAllTasks
{
    NSMutableArray *keys = [NSMutableArray array];
    @synchronized(_taskDict)
    {
        [_taskDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            MPFDownloader *downloader=obj;
            [downloader cancel];
            [keys addObject:key];
        }];
        
        [_taskDict removeObjectsForKeys:keys];
    }
}

- (float)lastProgress:(NSString *)url
{
    return [MPFDownloader lastProgress:url];
}

- (NSString *)filesSize:(NSString *)url
{
    return [MPFDownloader filesSize:url];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
