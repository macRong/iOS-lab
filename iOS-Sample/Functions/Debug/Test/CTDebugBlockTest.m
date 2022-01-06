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
    CTDebugCellModel *memoryCellModel = [CTDebugCellModel new];
    memoryCellModel.title = @"block内存dffdffdfdfdf";
    memoryCellModel.cellID = @"CTDebugCollectionViewCell";
    memoryCellModel.actionBlock = ^(id  _Nonnull value) {
        NSLog(@"value=%@",value);
    };
    
    
    sectionCellModel.dataSource = @[memoryCellModel];
    
    return sectionCellModel;
}

@end
