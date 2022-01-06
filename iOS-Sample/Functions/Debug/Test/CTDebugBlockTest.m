//
//  CTDebugBlockTest.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import "CTDebugBlockTest.h"

@implementation CTDebugBlockTest

- (CTDebugCellModel *)sectionCellModel
{
    CTDebugCellModel *sectionCellModel = [CTDebugCellModel new];
    sectionCellModel.title = @"blockTest";
    
    ///Block-内存
    CTDebugCellModel *memoryCellModel = [self createCellModelTitle:@"block内存" block:^(id value) {
        NSLog(@"value=%@",value);

    }];

    sectionCellModel.dataSource = @[memoryCellModel];
    
    return sectionCellModel;
}

///Tool
- (CTDebugCellModel *)createCellModelTitle:(NSString *)title block:(void(^)(id value))block
{
    CTDebugCellModel *cellModel = [CTDebugCellModel new];
    cellModel.title = title;
    cellModel.cellID = @"CTDebugCollectionViewCell";
    cellModel.actionBlock = block;
    
    return cellModel;
}

@end
