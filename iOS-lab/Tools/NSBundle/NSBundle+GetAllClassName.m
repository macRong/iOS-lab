//
//  NSBundle+GetAllClassName.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/13.
//

#import "NSBundle+GetAllClassName.h"
#import <objc/runtime.h>
#import <dlfcn.h> /// 动态链接库头文件
#import <mach-o/ldsyms.h> ///内核动态系统库头文件

@implementation NSBundle (GetAllClassName)

///获取当前工程下自己创建的所有类
+ (NSArray <Class> *)allOwnClassesInfo
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    unsigned int classCount;
    const char **classes;
    Dl_info info;
    
    ///_mh_execute_header : mach-o头部的地址
    ///dladdr: 获取app的路径
    dladdr(&_mh_execute_header, &info);
    
    ///拷贝动态库类列表
    classes = objc_copyClassNamesForImage(info.dli_fname, &classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);///创建信号
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t index) { ///遍历
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);///信号加锁
        NSString *className = [NSString stringWithCString:classes[index] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        [resultArray addObject:class];
        dispatch_semaphore_signal(semaphore);///信号释放锁
    });
    
    
    ///释放内存
    free(classes);
    
    return resultArray.mutableCopy;
}

///获取当前工程下所有类（含系统类、cocoPods类）
+ (NSArray <NSString *> *)allClassesInfo
{
    NSMutableArray *resultArray = [NSMutableArray new];
    
    ///获取所有类
    int classCount = objc_getClassList(NULL, 0);
    
    ///分配内存
    Class *classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *classCount);
    
    ///获取所有类
    classCount = objc_getClassList(classes, classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);///创建信号
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t index) { ///遍历
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); ///信号加锁
        Class class = classes[index];
        NSString *className = [[NSString alloc] initWithUTF8String: class_getName(class)];
        [resultArray addObject:className];
        dispatch_semaphore_signal(semaphore);///信号释放锁
    });
    
    ///释放内存
    free(classes);
    
    return resultArray.mutableCopy;
}

@end
