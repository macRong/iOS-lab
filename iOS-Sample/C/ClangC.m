//
//  ClangC.m
//  iOS-Sample
//
//  Created by macRong on 2018/7/23.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "ClangC.h"
#import <objc/message.h>

@implementation Cnum

@end

@implementation ClangC


//static int gnum = 3;
- (void)clangCfun
{

}

@end

/**
 __block用处:
 
 1.在局部基本类型变量和对象在赋值的时候使用
 2.全局和静态变量不用(不截取)
 
 __block修饰后编程了block struct的对象：
     struct __Block_byref_shashaAge_0 {
     void *__isa;
     __Block_byref_shashaAge_0 *__forwarding;
     int __flags;
     int __size;
     int shashaAge;
     };
 
 */

/**
 1.对于基本类型的局部变量截获值
 2.对于局部对象类型连同所有权修饰符一起截取
 3.局部静态变量 是用指针截取
 4. 不截取全局变量，全局静态变量
 */

/**
 1. 使用局部基本类型变量是直接截取值得方式

 - (void)clangCfun
 {
 int gnum = 3;
 int(^ClangBl)(int) = ^int(int num){
 NSLog(@"gnum === %d",gnum);
 return num*gnum;
 };
 
 gnum = 4;
 int m =  ClangBl(2);
 NSLog(@"===== result m=%d",m);
 }

Clang后
 {
     struct __ClangC__clangCfun_block_impl_0 {
     struct __block_impl impl;
     struct __ClangC__clangCfun_block_desc_0* Desc;
     int gnum;
     __ClangC__clangCfun_block_impl_0(void *fp, struct __ClangC__clangCfun_block_desc_0 *desc, int _gnum, int flags=0) : gnum(_gnum) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     static int __ClangC__clangCfun_block_func_0(struct __ClangC__clangCfun_block_impl_0 *__cself, int num) {
     int gnum = __cself->gnum; // bound by copy
 
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_29_2xsgmfp95lv0wpv00dcp2f4r0000gn_T_main_777d6f_mi_0,gnum);
     return num*gnum;
     }
 
     static struct __ClangC__clangCfun_block_desc_0 {
     size_t reserved;
     size_t Block_size;
     } __ClangC__clangCfun_block_desc_0_DATA = { 0, sizeof(struct __ClangC__clangCfun_block_impl_0)};
 
     static void _I_ClangC_clangCfun(ClangC * self, SEL _cmd) {
     int gnum = 3;
     int(*ClangBl)(int) = ((int (*)(int))&__ClangC__clangCfun_block_impl_0((void *)__ClangC__clangCfun_block_func_0, &__ClangC__clangCfun_block_desc_0_DATA, gnum));
 
     gnum = 4;
     int m = ((int (*)(__block_impl *, int))((__block_impl *)ClangBl)->FuncPtr)((__block_impl *)ClangBl, 2);
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_29_2xsgmfp95lv0wpv00dcp2f4r0000gn_T_main_777d6f_mi_1,m);
     }
 }
 */

/**
 2.使用static截获是获取他的指针地址

 - (void)clangCfun
 {
 static int gnum = 3;
 int(^ClangBl)(int) = ^int(int num){
 NSLog(@"gnum === %d",gnum);
 return num*gnum;
 };
 
 gnum = 4;
 int m =  ClangBl(2);
 NSLog(@"===== result m=%d",m);
 }
 
 Clang后:
 {
     struct __ClangC__clangCfun_block_impl_0 {
     struct __block_impl impl;
     struct __ClangC__clangCfun_block_desc_0* Desc;
     int *gnum;
     __ClangC__clangCfun_block_impl_0(void *fp, struct __ClangC__clangCfun_block_desc_0 *desc, int *_gnum, int flags=0) : gnum(_gnum) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
 
     static int __ClangC__clangCfun_block_func_0(struct __ClangC__clangCfun_block_impl_0 *__cself, int num) {
     int *gnum = __cself->gnum; // bound by copy
 
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_29_2xsgmfp95lv0wpv00dcp2f4r0000gn_T_main_f2850d_mi_0,(*gnum));
     return num*(*gnum);
     }
 
     static struct __ClangC__clangCfun_block_desc_0 {
     size_t reserved;
     size_t Block_size;
     } __ClangC__clangCfun_block_desc_0_DATA = { 0, sizeof(struct __ClangC__clangCfun_block_impl_0)};
 
     static void _I_ClangC_clangCfun(ClangC * self, SEL _cmd) {
     static int gnum = 3;
     int(*ClangBl)(int) = ((int (*)(int))&__ClangC__clangCfun_block_impl_0((void *)__ClangC__clangCfun_block_func_0, &__ClangC__clangCfun_block_desc_0_DATA, &gnum));
 
     gnum = 4;
     int m = ((int (*)(__block_impl *, int))((__block_impl *)ClangBl)->FuncPtr)((__block_impl *)ClangBl, 2);
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_29_2xsgmfp95lv0wpv00dcp2f4r0000gn_T_main_f2850d_mi_1,m);
     }
 }
 
 */


/**
 3.全局变量/静态全部变量
 
 int gnum = 3;
 - (void)clangCfun
 {
 int(^ClangBl)(int) = ^int(int num){
 NSLog(@"gnum === %d",gnum);
 return num*gnum;
 };
 
 gnum = 4;
 int m =  ClangBl(2);
 NSLog(@"===== result m=%d",m);
 }
 
 Clang后
 {
     int gnum = 3;
     struct __ClangC__clangCfun_block_impl_0 {
     struct __block_impl impl;
     struct __ClangC__clangCfun_block_desc_0* Desc;
     __ClangC__clangCfun_block_impl_0(void *fp, struct __ClangC__clangCfun_block_desc_0 *desc, int flags=0) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
     }
     };
     static int __ClangC__clangCfun_block_func_0(struct __ClangC__clangCfun_block_impl_0 *__cself, int num) {
 
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_29_2xsgmfp95lv0wpv00dcp2f4r0000gn_T_main_474019_mi_0,gnum);
     return num*gnum;
     }
 
     static struct __ClangC__clangCfun_block_desc_0 {
     size_t reserved;
     size_t Block_size;
     } __ClangC__clangCfun_block_desc_0_DATA = { 0, sizeof(struct __ClangC__clangCfun_block_impl_0)};
 
     static void _I_ClangC_clangCfun(ClangC * self, SEL _cmd) {
     int(*ClangBl)(int) = ((int (*)(int))&__ClangC__clangCfun_block_impl_0((void *)__ClangC__clangCfun_block_func_0, &__ClangC__clangCfun_block_desc_0_DATA));
 
     gnum = 4;
     int m = ((int (*)(__block_impl *, int))((__block_impl *)ClangBl)->FuncPtr)((__block_impl *)ClangBl, 2);
     NSLog((NSString *)&__NSConstantStringImpl__var_folders_29_2xsgmfp95lv0wpv00dcp2f4r0000gn_T_main_474019_mi_1,m);
     }
 }
 */

