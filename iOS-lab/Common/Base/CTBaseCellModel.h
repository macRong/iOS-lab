//
//  CTBaseCellModel.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, CTCellModelType) {
    CTCellModelTypeShow, ///纯展示
};

@interface CTBaseCellModel : NSObject

@property (nonatomic, copy) NSString  *cellID;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CTCellModelType cellType;
@property (nonatomic, assign) NSInteger cellModelID; ///cellModelID唯一ID

@property (nonatomic, strong) id dataSource;
@property (nonatomic, strong) id flagDataSource; ///比如：备用的models(可能用不到)

/// --------------------cell Model custom -----------
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *des;
@property (nonatomic, copy) NSString  *placeTitle;
@property (nonatomic, assign) BOOL notEdit; ///是否可编辑 default:NO 可编辑

@end

NS_ASSUME_NONNULL_END
