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
#include "ClassDemo.hpp"

@interface ViewController ()


@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    int a = 10 ,b =20;
//    quoteSomePoint(a,b);
    
//    cinTest();
    
//    Person per;
//    per.didload();
    
//    Person pp(10);
    
    Cat cat(12);
//    int aa =cat.foMax(1, 2);
    
//    cat.foMax(2, 3);
    
    
    
    
    
//    NSLog(@"a =%d=%p, b=%d,%p",a,&a,b,&b);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
