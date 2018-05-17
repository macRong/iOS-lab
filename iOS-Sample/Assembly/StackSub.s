//
//  StackSub.s
//  iOS-Sample
//
//  Created by 荣守振 on 2018/4/30.
//  Copyright © 2018年 macRong. All rights reserved.
//


// 栈平衡
//.text
//.global _StackSample
//_StackSample:
//sub sp, sp, #0x20
//stp x0,x1,[sp,#0x10]
//ldp x1,x0,[sp,#0x10]
//add sp, sp, #0x20
//ret




#真机
//.text
//.global _A,_B,_SumC
//
//_A:
//  mov x0,0xaaaa
//  str x30,[sp, #-0x10]!
//  mov x30, sp
//  bl _B
//  mov x0,0xcccc
//  ldr x30,[sp],#0x10
//  ret
//
//_B:
//  mov x0,0xbbbb
//  ret
//
//
//_SumC:
//   add x0, x0,x1
//   ret
