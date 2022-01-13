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
        [self circulationThread];
    }];
    
    
    return @[cellModel];
}

#pragma mark - Private

///gcd死锁
- (void)circulationThread
{
    /**
     描述：
     for里面加个断点，看下thread线程，一直都是thread2创建
     */
    dispatch_queue_t testQueue1 = dispatch_queue_create("test1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t testQueue2 = dispatch_queue_create("test2", DISPATCH_QUEUE_CONCURRENT);

    for (int i = 0; i < 100000; i ++) {
        dispatch_async(testQueue1, ^{
            NSLog(@"===1== %@",[NSThread currentThread]);
        });
        
        dispatch_async(testQueue2, ^{
            dispatch_sync(testQueue1, ^{
                NSLog(@"===2== %@",[NSThread currentThread]);
            });
        });
    }
}

@end
