//
//  CTDebugCellProtocol.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import <Foundation/Foundation.h>
@class CTDebugCellModel;

NS_ASSUME_NONNULL_BEGIN

@protocol CTDebugCellProtocol <NSObject>

@required

@optional
+ (id<CTDebugCellProtocol>)configReusableCellWithTableView:(UITableView *)tableView;

- (void)bindModel:(id)model;
- (void)cellModel:(CTDebugCellModel *)model;

- (void)callBackAction:(void(^)(id value, BOOL select))action;
@property (nonatomic, copy) void(^actionBlock)(id value);

@end

NS_ASSUME_NONNULL_END
