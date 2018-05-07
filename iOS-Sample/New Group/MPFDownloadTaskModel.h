//
//  MPFDownloadTaskModel.h
//  iOS-Sample
//
//  Created by 荣守振 on 2018/5/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPFDownloadTaskModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *destinationPath;

+ (instancetype)model;


@end
