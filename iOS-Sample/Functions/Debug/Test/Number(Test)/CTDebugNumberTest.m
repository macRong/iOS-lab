//
//  CTDebugNumberTest.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/14.
//

#import "CTDebugNumberTest.h"

@implementation CTDebugNumberTest

- (CTDebugCellModel *)sectionCellModel
{
    CTDebugCellModel *sectionCellModel = [CTDebugCellModel new];
    sectionCellModel.title = @"NumberTest";
    sectionCellModel.dataSource = [self actionTest];
    
    return sectionCellModel;
}

- (NSArray *)actionTest
{
    CTDebugCellModel *cellModel = [self createCellModelTitle:@"float精度丢失 " block:^(id value) {
        [self numberProcess];
    }];
    
    return @[cellModel];
}

#pragma mark - Test

- (void)numberProcess
{
    // 模拟后端返回数据
    NSString * jsonStr = @"{\"price\":71.49}";
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil]];
    NSLog(@"处理之前：%@", [json[@"price"] stringValue]);
    NSNumber *fl = json[@"price"];
    NSLog(@"===%f", [fl floatValue]);

    // 当我们用浮点类型去接收的时： price = 71.48999999999999
}

@end
