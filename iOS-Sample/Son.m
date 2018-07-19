//
//  Son.m
//  iOS-Sample
//
//  Created by macRong on 2018/7/17.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    
    return self;
}

- (void)run
{
    NSLog(@"==1====== %@",NSStringFromClass([self class]));
    NSLog(@"==2====== %@",NSStringFromClass([super  class]));
}

@end
