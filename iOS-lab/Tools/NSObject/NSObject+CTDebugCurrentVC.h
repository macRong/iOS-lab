//
//  NSObject+CTDebugCurrentVC.h
//  iOS-lab
//
//  Created by macRong on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CTDebugCurrentVC)

- (UIViewController *)getCurrentVC;

@end

NS_ASSUME_NONNULL_END
