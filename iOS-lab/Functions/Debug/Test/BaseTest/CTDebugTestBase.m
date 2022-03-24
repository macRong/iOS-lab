//
//  CTDebugBaseTest.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/13.
//

#import "CTDebugTestBase.h"

@implementation CTDebugTestBase

- (CTDebugCellModel *)sectionCellModel
{
    return nil;
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
