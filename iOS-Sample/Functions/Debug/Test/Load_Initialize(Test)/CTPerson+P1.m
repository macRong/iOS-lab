//
//  Person+P1.m
//  Enterprise
//
//  Created by macRong on 2021/12/28.
//

#import "CTPerson+P1.h"

@implementation CTPerson (P1)

- (void)run
{
    NSLog(@"--%s--",__PRETTY_FUNCTION__);
}

+ (void)initialize
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
