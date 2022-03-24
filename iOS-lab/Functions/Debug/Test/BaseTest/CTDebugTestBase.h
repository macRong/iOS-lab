//
//  CTDebugBaseTest.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/13.
//

/*
 BaseTest
 */
#import <Foundation/Foundation.h>
#import "CTDebugCellModel.h"
#import "CTDebugCellModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTDebugTestBase : NSObject<CTDebugCellModelProtocol>

- (CTDebugCellModel *)createCellModelTitle:(NSString *)title block:(void(^)(id value))block;

@end

NS_ASSUME_NONNULL_END
