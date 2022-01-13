//
//  CTDebugListViewModel.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

/**
 Debug-viewmodel
 
 注意:
 此类数据，是动态获取所有的Test结尾的类名，不用手动加入。
 只需要命名规范就行（如 CTDeugxxxTest, 必须要以Test结尾）
 */
#import <Foundation/Foundation.h>
#import "CTDebugCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTDebugListViewModel : NSObject

///这里返回的顺序和先后load文件顺序一致，先load编译就先输出
@property (nonatomic, strong, readonly) NSArray <CTDebugCellModel *>*dataArray;

@end

NS_ASSUME_NONNULL_END
