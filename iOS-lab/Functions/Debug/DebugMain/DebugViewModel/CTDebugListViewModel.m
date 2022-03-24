//
//  CTDebugListViewModel.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import "CTDebugListViewModel.h"
#import "CTDebugBlockTest.h"
#import "CTDebugTheadTest.h"
#import "CTDebugCellModelProtocol.h"
#import "NSBundle+GetAllClassName.h"

@interface CTDebugListViewModel()

@property (nonatomic, strong) NSArray <CTDebugCellModel *>*dataArray;

@end

@implementation CTDebugListViewModel

///数据源
- (NSArray *)cellModels
{
    NSArray *testArray = [self allTestClass];
    return [self processCellModels:testArray];
}

///动态获取所有的Test结尾类
- (NSArray <Class>*)allTestClass
{
    NSMutableArray *resultMarray = @[].mutableCopy;
    
    /// 这里返回的顺序和先后load文件顺序一致，先load编译就先输出
    NSArray <Class>*classes = [NSBundle allOwnClassesInfo];
    for (Class className in classes) {
        if ([NSStringFromClass(className) hasSuffix:@"Test"]) {
            [resultMarray addObject:className];
        }
    }
    
    return resultMarray.copy;
}

- (NSArray *)processCellModels:(NSArray *)testArray
{
    NSMutableArray *resultMarr = @[].mutableCopy;
    [testArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(CTDebugCellModelProtocol)]) { 
            id<CTDebugCellModelProtocol> test = [[obj class] new];
            if ([test respondsToSelector:@selector(sectionCellModel)]) {
                CTDebugCellModel *blockCellModel = [test sectionCellModel];
                if(blockCellModel) [resultMarr addObject:blockCellModel];
            }
        }
    }];
    
    return resultMarr.copy;
}

- (NSArray <CTDebugCellModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [self cellModels];
    }
    
    return _dataArray;
}

@end
