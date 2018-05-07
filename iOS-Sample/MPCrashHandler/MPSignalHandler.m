//
//  MPSignalHandler.m
//  MPCrashReporter
//
//  Created by macRong on 2017/12/4.
//  Copyright © 2017年 MPCrashReporter. All rights reserved.
//

#import "MPSignalHandler.h"
#include <execinfo.h>
#include <pthread.h>

@implementation MPSignalHandler

pthread_t tid;

void *threadfunc(void *parm)
{
    pthread_t             tid = pthread_self();
    int                   rc;
    
    printf("Thread %u entered/n", tid);
    rc = sleep(30); /* 若有信号中断则返回剩余秒数 */
    printf("Thread %u did not get expected results! rc=%d/n", tid, rc);
    return NULL;
}

/** 信号捕获 */
void mp_SignalHandler(int signal)
{
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    
    for (i = 0; i <frames; ++i)
    {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    
    
     sigset_t              mask;
     sigfillset(&mask); /* 将所有信号加入mask信号集 */
      pthread_sigmask(SIG_BLOCK, &mask, NULL);
    
   pthread_t  tid = pthread_self();
    pthread_create(&tid,NULL,threadfunc,NULL);
    
    NSLog(@"✅single✅ = %d, mstr=%@",signal,mstr);
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *userNameDictPath = [path stringByAppendingPathComponent:@"crash.log"];
    BOOL isSuc =  [mstr writeToFile:userNameDictPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"=====isSuc =%d",isSuc);    
}

void Install_MP_SignalHandlerHandler(void)
{
    signal(SIGHUP, mp_SignalHandler);
    signal(SIGINT, mp_SignalHandler);
    signal(SIGQUIT, mp_SignalHandler);
    
    signal(SIGABRT, mp_SignalHandler);
    signal(SIGILL, mp_SignalHandler);
    signal(SIGSEGV, mp_SignalHandler);
    signal(SIGFPE, mp_SignalHandler);
    signal(SIGBUS, mp_SignalHandler);
    signal(SIGPIPE, mp_SignalHandler);
}

@end
