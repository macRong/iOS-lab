//
//  NSObject+CTDebugCurrentVC.m
//  iOS-lab
//
//  Created by macRong on 2022/6/10.
//

#import "NSObject+CTDebugCurrentVC.h"

@implementation NSObject (CTDebugCurrentVC)

- (UIViewController *)getCurrentVC
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    
    while (true) {
        if (topViewController.presentedViewController) {
            
            topViewController = topViewController.presentedViewController;
            
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            
            topViewController = [(UINavigationController *)topViewController topViewController];
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
            
        } else {
            break;
        }
    }

    return topViewController;
}

@end
