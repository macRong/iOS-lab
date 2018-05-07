//
//  Cat.m
//  iOS-Sample
//
//  Created by macRong on 2018/5/7.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "Cat.h"
#import "Person.h"

@implementation Cat

// 发送机制
// 编译器的一个
//[person run:@"10"];
//    objc_msgSend(person, 1, @"10");
//
//    Person *person = ((Person * (*)(id, SEL))objc_msgSend)((id)[Person class], @selector(alloc));
//
//    person = ((Person *(*)(id, SEL))objc_msgSend)((id)person, @selector(init));
//
//    ((Person * (*)(id, SEL, NSString *))objc_msgSend)((id)person, @selector(run:), @"1");


// 转发机制
// 1.动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"sel = %@", NSStringFromSelector(sel));
    
    // 判断实现方法
    //    if (sel == @selector(run)) {
    //        // 动态方法添加
    //        class_addMethod(self, sel, (IMP)runNew, "v@:");
    //
    //        return YES;
    //    }
    
    return [super resolveInstanceMethod:sel];
}

void runNew(id self, SEL sel)
{
    NSLog(@"%@ runNew = %@--", self,NSStringFromSelector(sel));
}

// 2.快速消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    //    NSLog(@"sel = %@", NSStringFromSelector(aSelector));
    //    return [Animation new];
    
    return [super forwardingTargetForSelector:aSelector];
}

// 3.标准消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //    NSLog(@"---%@",anInvocation );
    // 拿sel(方法)
    SEL sel = [anInvocation selector];
    // 转发
    Person *anim = [Person new];
    if ([anim respondsToSelector:sel])
    {
        // 调用这个对象
        [anInvocation invokeWithTarget:anim];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}

// 生成方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    
    if ([sel isEqualToString:@"eat"])
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 4.抛出异常
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    NSLog(@"-----%@ 不存在", sel);
}

@end
