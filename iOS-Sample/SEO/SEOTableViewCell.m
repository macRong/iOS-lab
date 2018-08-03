//
//  SEOTableViewCell.m
//  iOS-Sample
//
//  Created by macRong on 2018/8/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "SEOTableViewCell.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import <objc/message.h>

id setBeingRemoved(id self, SEL selector, ...);
id willBeRemoved(id self, SEL selector, ...);

@implementation SEOTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadWebData:(NSArray *)arr
{
    NSLog(@"====arr = %@",arr);
    [arr enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:obj]];
                [self.oneWeb loadRequest:request];
            }
                break;
            case 1:
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:obj]];
                [self.twoWeb loadRequest:request];
            }
                break;
            case 2:
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:obj]];
                [self.threeWeb loadRequest:request];
            }
                break;
            case 3:
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:obj]];
                [self.fourWeb loadRequest:request];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 预防报错:WebActionDisablingCALayerDelegate    willBeRemoved
    Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");
    class_addMethod(class, NSSelectorFromString(@"setBeingRemoved"), setBeingRemoved, "v@:");
    class_addMethod(class, NSSelectorFromString(@"willBeRemoved"), willBeRemoved, "v@:");
    class_addMethod(class, NSSelectorFromString(@"removeFromSuperview"), willBeRemoved, "v@:");
}

id setBeingRemoved(id self, SEL selector, ...)
{
    return nil;
}

id willBeRemoved(id self, SEL selector, ...)
{
    return nil;
}

@end
