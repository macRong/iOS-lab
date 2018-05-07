//
//  MPFloaderCommon.h
//  iOS-Sample
//
//  Created by 荣守振 on 2018/5/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MPFProcessHandle)(float progress,NSString *sizeString,NSString *speedString);
typedef void (^MPFCompletionHandle)(void);
typedef void (^MPFFailureHandle)(NSError *error);

static NSString *const MPFDownloadTaskDidFinishNotification   = @"MPFDownloadTaskDidFinishNotification";
static NSString *const MPFUploadTaskDidFinishNotification     = @"MPFUploadTaskDidFinishNotification";
static NSString *const MPFInsufficientSystemSpaceNotification = @"MPFInsufficientSystemSpaceNotification";
static NSString *const MPFProgressDidChangeNotificaiton       = @"MPFProgressDidChangeNotificaiton";

static NSString *boundary = @"MPFUploaderBoundary";
static NSString *randomId = @"MPFUploaderRandomId";

static NSInteger kMPFDwonloadMaxTaskCount = 2;
static NSInteger kMPFUploaderMaxTaskCount = 2;

@interface MPFloaderCommon : NSObject



@end
