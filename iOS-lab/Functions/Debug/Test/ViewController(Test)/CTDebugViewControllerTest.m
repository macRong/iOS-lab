//
//  CTDebugViewControllerTest.m
//  iOS-lab
//
//  Created by macRong on 2022/6/10.
//

#import "CTDebugViewControllerTest.h"
#import "CTDebugBackViewController.h"

@implementation CTDebugViewControllerTest

- (CTDebugCellModel *)sectionCellModel
{
    CTDebugCellModel *sectionCellModel = [CTDebugCellModel new];
    sectionCellModel.title = @"ViewController";
    sectionCellModel.dataSource = [self actionTest];
    
    return sectionCellModel;
}

- (NSArray *)actionTest
{
    CTDebugCellModel *cellModel = [self createCellModelTitle:@"手势滑动 " block:^(id value) {
        [self ergodicCount];
    }];
    
    return @[cellModel];
}

- (void)ergodicCount
{
    CTDebugBackViewController *vc = [CTDebugBackViewController new];
    UIView *view = [UIView new];
    if ([view isKindOfClass:[UIResponder class]]) {
        NSLog(@"====== UIResponder");
    }
    
    [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
}

@end
