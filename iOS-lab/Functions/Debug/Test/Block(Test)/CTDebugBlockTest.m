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
    sectionCellModel.dataSource = [self actionTest];
    
    return sectionCellModel;
}

- (NSArray *)actionTest
{
    ///Block-内存
    CTDebugCellModel *memoryCellModel = [self createCellModelTitle:@"block内存" block:^(id value) {
        [self testBlockMemeory];
    }];
    
    ///Block-内存
    CTDebugCellModel *memoryCellModel2 = [self createCellModelTitle:@"block内存" block:^(id value) {
        NSLog(@"value=%@",value);

    }];
    
    return @[memoryCellModel, memoryCellModel2];
}

- (void)testBlockMemeory
{
   __block NSInteger *num2 = (NSInteger *)malloc(sizeof(NSInteger));
    
    void(^memBlock)(void) = ^{
        *num2 = 3;
    };
        
    memBlock();
    
    NSLog(@"===num= %ld",(long)*num2);
}

@end
