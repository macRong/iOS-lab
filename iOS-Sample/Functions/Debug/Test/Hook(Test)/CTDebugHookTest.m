//
//  CTHookTest.m
//  iOS-Sample
//
//  Created by macRong on 2022/3/9.
//

#import "CTDebugHookTest.h"

@implementation CTDebugHookTest

- (CTDebugCellModel *)sectionCellModel
{
    CTDebugCellModel *sectionCellModel = [CTDebugCellModel new];
    sectionCellModel.title = @"hookTest";
    sectionCellModel.dataSource = [self actionTest];
    
    return sectionCellModel;
}

- (NSArray *)actionTest
{
    ///Hook
    CTDebugCellModel *hookCellModel = [self createCellModelTitle:@"fishHook" block:^(id value) {
        NSLog(@"value=%@",value);
    }];
    
    return @[hookCellModel];
}

@end
