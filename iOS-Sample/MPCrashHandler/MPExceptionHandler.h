//
//  MPExceptionHandler.h
//  DumbPatch_Example
//
//  Created by macRong on 2017/11/30.
//  Copyright © 2017年 MPCrashHandler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPExceptionHandler : NSObject

// pre runloop
@property (nonatomic, strong) NSRunLoop *preRunloop;

void Install_MP_UncaughtExceptionHandler(void);

@end
