//
//  CTDebugListViewModel.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

/**
 Debug-viewmodel
 */
#import <Foundation/Foundation.h>
#import "CTDebugCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTDebugListViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray <CTDebugCellModel *>*dataArray;

@end

NS_ASSUME_NONNULL_END
