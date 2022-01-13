//
//  Person.m
//  Enterprise
//
//  Created by macRong on 2021/12/28.
//

#import "CTPerson.h"

@implementation CTPerson

- (void)run
{
    NSLog(@"--%s--",__PRETTY_FUNCTION__);
}

+ (void)initialize
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
