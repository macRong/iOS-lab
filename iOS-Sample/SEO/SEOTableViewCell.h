//
//  SEOTableViewCell.h
//  iOS-Sample
//
//  Created by macRong on 2018/8/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEOTableViewCell : UITableViewCell<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *oneWeb;
@property (weak, nonatomic) IBOutlet UIWebView *twoWeb;
@property (weak, nonatomic) IBOutlet UIWebView *threeWeb;
@property (weak, nonatomic) IBOutlet UIWebView *fourWeb;

- (void)loadWebData:(NSArray *)arr;

@end
