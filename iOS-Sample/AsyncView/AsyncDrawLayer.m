//
//  AsyncDrawLayer.m
//  iOS-Sample
//
//  Created by macRong on 2018/7/20.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "AsyncDrawLayer.h"

@implementation AsyncDrawLayer

- (void)increaseCount
{
    _drawsCount += 1;
}

- (void)setNeedsDisplay
{
    [self increaseCount];
    [super setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)r
{
    [self increaseCount];
    [super setNeedsDisplayInRect:r];
}


@end
