//
//  Person.h
//  iOS-Sample
//
//  Created by macRong on 2018/4/17.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIView *sView;

- (void)eat;


@end
