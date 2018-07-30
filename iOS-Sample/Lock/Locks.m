//
//  Locks.m
//  iOS-Sample
//
//  Created by macRong on 2018/7/26.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "Locks.h"

@implementation Locks

// dispatch_semaphore_t 信号量锁
- (void)creatSemaphore
{
    dispatch_semaphore_t semephore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semephore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(semephore);
}

@end
