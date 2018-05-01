//
//  main.m
//  iOS-Sample
//
//  Created by 荣守振 on 2018/4/15.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void A();

void bb()
{
    return;
}

void aa()
{
    bb();
    
    return;
}


int SumC(int a, int b);
int Summ(int a,int  b,int c,int d,int e,int f,int g,int h,int i);

int Summ(int a,int  b,int c,int d,int e,int f,int g,int h,int i)
{
    return a+b+c+d+e+f+g+h+i;
}

int sumA(int a, int b,int c ,int e,int f)
{
    printf("%d",f);
    return a+b;
}

int main(int argc, char * argv[]) {
    
//    aa();
//    A();
//  int a =  SumC(2,6);
//    int a = Summ(1, 2, 3, 4, 5, 6, 7, 8, 9);
    int a = sumA(2,3,4,5,6);   // ->  0x100bac704 <+0>:  sub    sp, sp, #0x10             ; =0x10

  printf("%d",a);
    return 0;
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
}
