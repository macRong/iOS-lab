//
//  AsyncDrawLayer.h
//  iOS-Sample
//
//  Created by macRong on 2018/7/20.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AsyncDrawLayer : CALayer

@property (nonatomic, assign, readonly) NSInteger drawsCount;

- (void)increaseCount;

@end
