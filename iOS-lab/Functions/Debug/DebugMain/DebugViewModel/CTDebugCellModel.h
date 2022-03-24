//
//  CTDebugCellModel.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import "CTBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTDebugCellModel : CTBaseCellModel

@property (nonatomic, copy) void(^actionBlock)(id value);

- (void)callBackAction;

@end

NS_ASSUME_NONNULL_END
