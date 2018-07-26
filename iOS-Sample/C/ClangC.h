//
//  ClangC.h
//  iOS-Sample
//
//  Created by macRong on 2018/7/23.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cnum:NSObject

@property (nonatomic,assign) int age;

@end



@interface ClangC : NSObject

@property (nonatomic, strong) Cnum *cnum;


- (void)clangCfun;

@end



