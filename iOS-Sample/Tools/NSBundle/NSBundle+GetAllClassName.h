//
//  NSBundle+GetAllClassName.h
//  iOS-Sample
//
//  Created by macRong on 2022/1/13.
//

/**
 获取工程下所有的类名
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (GetAllClassName)

///获取当前工程下自己创建的所有类
+ (NSArray <Class> *)allOwnClassesInfo;

///获取当前工程下所有类（含系统类、cocoPods类）
+ (NSArray <NSString *> *)allClassesInfo;

@end

NS_ASSUME_NONNULL_END
