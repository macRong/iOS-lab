//
//  AppDelegate.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/5.
//

#import "AppDelegate.h"
#import "CTViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    CTViewController *naviRootVc = [[CTViewController alloc] init];
    self.window.rootViewController = naviRootVc;
        
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

/**
 1、增加log
 
 */
