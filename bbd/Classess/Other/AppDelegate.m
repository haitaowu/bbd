//
//  AppDelegate.m
//  bbd
//
//  Created by 韩加宇 on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "AppDelegate.h"
#import "BBDRootTabBarController.h"
#import "BBDRootNavigationController.h"
#import "BBDLoginViewController.h"
#import "BBDGestureViewController.h"
#import <AddressBook/AddressBook.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 登录过
    if ([NSUserDefaults getUserId]) {
        // 是否有手势密码
        if ([NSUserDefaults getIsGesture]) {
            
            BBDGestureViewController *gestureViewController = [[BBDGestureViewController alloc] init];
            gestureViewController.gestureStyle = ValidatePwdModel;
            gestureViewController.otherButton.hidden = NO;
            gestureViewController.block = ^(){
                
                CATransition *animation = [CATransition animation];
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = @"reveal";
                animation.duration = 0.3;
                animation.subtype =kCATransitionFromRight;
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController.view removeFromSuperview];
                [UIApplication sharedApplication].keyWindow.rootViewController = [[BBDRootTabBarController alloc] init];
            };
            self.window.rootViewController = gestureViewController;
        }else {

            self.window.rootViewController = [[BBDRootTabBarController alloc] init];
        }
    }else{
        BBDRootNavigationController *nav = [[BBDRootNavigationController alloc] initWithRootViewController:[[BBDLoginViewController alloc] init]];
        self.window.rootViewController = nav;
    }    
    
    [self.window makeKeyAndVisible];
    
    [self requestAuthorizationAddressBook];
    
    return YES;
}

- (void)requestAuthorizationAddressBook {
    // 判断是否授权
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
        // 请求授权
        ABAddressBookRef addressBookRef =  ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {  // 授权成功
                
            } else {        // 授权失败
                NSLog(@"授权失败！");
            }
        });
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
