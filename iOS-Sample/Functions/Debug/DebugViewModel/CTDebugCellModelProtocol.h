//
//  CTDebugCellModelProtocol.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import <Foundation/Foundation.h>
@class CTDebugCellModel;

NS_ASSUME_NONNULL_BEGIN

@protocol CTDebugCellModelProtocol <NSObject>

@optional
//@property (nonatomic, copy) void(^actionBlock)(id value);
//- (void)callBackAction:(void(^)(id value, BOOL select))action;

@required
- (CTDebugCellModel *)sectionCellModel;

@end

NS_ASSUME_NONNULL_END
