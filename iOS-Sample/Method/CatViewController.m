//
//  CatViewController.m
//  iOS-Sample
//
//  Created by macRong on 2018/5/7.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "CatViewController.h"
#import "Cat.h"

@interface CatViewController ()

@end

@implementation CatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    Cat *cat = [Cat new];
    [cat eat];
}

@end
