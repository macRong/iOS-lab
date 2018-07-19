//
//  ViewController.m
//  iOS-Sample
//
//  Created by 荣守振 on 2018/4/15.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "ViewController.h"
//#include "StringCPP.hpp"
#include "StruckDataS.hpp"
#include "CopyClassCpp.hpp"
#include "SignTest.h"
#include "ClassDemo.hpp"
#include "SignRaise.hpp"
#import "NSObject+DLIntrospection.h"
#import <objc/runtime.h>
#import "Son.h"
#include "ReverseNode.hpp"
#include <vector>

@interface ViewController ()

@end


@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSLog(@" %@, %s",NSStringFromClass([self class]), __PRETTY_FUNCTION__);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@" %@, %s",NSStringFromClass([self class]), __PRETTY_FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@" %@, %s",NSStringFromClass([self class]), __PRETTY_FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@" %@, %s",NSStringFromClass([self class]), __PRETTY_FUNCTION__);
}

- (void)versionCompareFirst:(NSString *)first andVersionSecond: (NSString *)second {
    NSArray *versions1 = [first componentsSeparatedByString:@"."];
    NSArray *versions2 = [second componentsSeparatedByString:@"."];
    NSMutableArray *ver1Array = [NSMutableArray arrayWithArray:versions1];
    NSMutableArray *ver2Array = [NSMutableArray arrayWithArray:versions2];
    // 确定最大数组
    NSInteger a = (ver1Array.count> ver2Array.count)?ver1Array.count : ver2Array.count;
    // 补成相同位数数组
    if (ver1Array.count < a) { for(NSInteger j = ver1Array.count; j < a; j++)
    {
        [ver1Array addObject:@"0"];        
    }
    }
    else
    {
        for(NSInteger j = ver2Array.count; j < a; j++)
        {
            [ver2Array addObject:@"0"];
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    SignRaise sign = SignRaise();
//    sign.registerSign();
    

//    SignDemo *dem = new SignDemo();
    
//    Box box1;
//    Box box2;
//
//    box1.width = 3;
//    box1.height = 4;
//
//    box2.width = 5;
//    box2.height = 6;
//
//    double sum1 = box1.getVolume();
//    double sum2 = box2.getVolume();
//
//    Box b = box1 * box2;
//
//    printf("sum1=%f, sum2=%f, b.width=%f,b.height=%f",sum1,sum2,b.width,b.height);

    
}

- (IBAction)finshHookBtn:(id)sender
{
//    ReverseNode *node =new ReverseNode;
//    ListNode *listNode = node-> creatNode(10);
//    vector<int> t = node->printListFromTailToHead(listNode);
//
//    delete  node;
    

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
