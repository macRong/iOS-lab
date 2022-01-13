//
//  CTDebugTheadTest.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/13.
//

#import "CTDebugTheadTest.h"

@implementation CTDebugTheadTest

- (CTDebugCellModel *)sectionCellModel
{
    CTDebugCellModel *sectionCellModel = [CTDebugCellModel new];
    sectionCellModel.title = @"threadTest";
    sectionCellModel.dataSource = [self actionTest];
    
    return sectionCellModel;
}

- (NSArray *)actionTest
{
    ///Block-内存
    CTDebugCellModel *cellModel = [self createCellModelTitle:@"gcd死锁" block:^(id value) {
        NSLog(@"value=%@",value);

    }];
    
    
    return @[cellModel];
}

@end
