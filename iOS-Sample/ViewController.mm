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
#include "CopyClassCpp.hpp"

@interface ViewController ()


@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Box box1;
    Box box2;
    
    box1.width = 3;
    box1.height = 4;
    
    box2.width = 5;
    box2.height = 6;
    
    double sum1 = box1.getVolume();
    double sum2 = box2.getVolume();
    
    Box b = box1 * box2;
    
    printf("sum1=%f, sum2=%f, b.width=%f,b.height=%f",sum1,sum2,b.width,b.height);
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
