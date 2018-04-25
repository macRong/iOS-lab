//
//  ViewController.m
//  iOS-Sample
//
//  Created by 荣守振 on 2018/4/15.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "ViewController.h"
#include "StringCPP.hpp"
#include "StruckDataS.hpp"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    int a = 10 ,b =20;
//    quoteSomePoint(a,b);
    
//    cinTest();
    
    didload();
    
    
//    NSLog(@"a =%d=%p, b=%d,%p",a,&a,b,&b);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
