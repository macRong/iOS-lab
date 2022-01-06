//
//  CTDebugListViewModel.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import "CTDebugListViewModel.h"
#import "CTDebugBlockTest.h"
#import "CTDebugCellModelProtocol.h"

@interface CTDebugListViewModel()

@property (nonatomic, strong) NSArray <CTDebugCellModel *>*dataArray;

@end

@implementation CTDebugListViewModel

///数据源
- (NSArray *)cellModels
{
    NSArray *testArray = @[[CTDebugBlockTest class],[CTDebugBlockTest class]];
    
    return [self processCellModels:testArray];
}

- (NSArray *)processCellModels:(NSArray *)testArray
{
    NSMutableArray *resultMarr = @[].mutableCopy;
    [testArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:@protocol(CTDebugCellModelProtocol)]) { 
            id<CTDebugCellModelProtocol> test = [[obj class] new];
            if ([test respondsToSelector:@selector(sectionCellModel)]) {
                CTDebugCellModel *blockCellModel = [test sectionCellModel];
                [resultMarr addObject:blockCellModel];
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
