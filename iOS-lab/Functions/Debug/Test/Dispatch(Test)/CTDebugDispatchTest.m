//
//  CTDebugArrayErgodicTest.m
//  iOS-lab
//
//  Created by macRong on 2022/3/24.
//

#import "CTDebugDispatchTest.h"

@implementation CTDebugDispatchTest

- (CTDebugCellModel *)sectionCellModel
{
    CTDebugCellModel *sectionCellModel = [CTDebugCellModel new];
    sectionCellModel.title = @"遍历";
    sectionCellModel.dataSource = [self actionTest];
    
    return sectionCellModel;
}

- (NSArray *)actionTest
{
    CTDebugCellModel *cellModel = [self createCellModelTitle:@"dispatch遍历 " block:^(id value) {
        [self ergodicCount];
    }];
    
    return @[cellModel];
}

- (void)ergodicCount
{
    unsigned int count = 10;
    dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
        NSLog(@"=====iteration = %zu",iteration);
    });
}

@end
