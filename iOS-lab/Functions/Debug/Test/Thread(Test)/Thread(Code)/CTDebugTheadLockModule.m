//
//  CTDebugTheadLockModule.m
//  iOS-lab
//
//  Created by macRong on 2022/4/1.
//

#import "CTDebugTheadLockModule.h"

@implementation CTDebugTheadLockModule

+ (void)lock_Semaphore
{
    dispatch_semaphore_t semephore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semephore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(semephore);
}

@end
