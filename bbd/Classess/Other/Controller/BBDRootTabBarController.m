//
//  BBDRootTabBarController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDRootTabBarController.h"
#import "BBDRootNavigationController.h"
#import "BBDHomeViewController.h"
#import "BBDServeViewController.h"
#import "BBDMeViewController.h"
#import "BBDNetworkTool.h"

@interface BBDRootTabBarController ()

@end

@implementation BBDRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self setupChildVc:[[BBDHomeViewController alloc] init] title:@"借款" image:@"bottom_home_icon"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Authentication" bundle:nil];
    UIViewController *authenticationController = [storyboard instantiateViewControllerWithIdentifier:@"AuthenticationController"];
    [self setupChildVc:authenticationController title:@"认证" image:@"bottom_hand_icon"];
    
    BBDMeViewController * me = [[BBDMeViewController alloc]init];
    [BBDNetworkTool getUnreadMessageCount:^(int messageCount) {
        NSLog(@"%d",messageCount);
        if (messageCount == 0) {
            me.tabBarItem.badgeValue = nil;
        }else{
            me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",messageCount];
        }
    } failure:^{
        
    }];
    [self setupChildVc:me title:@"我" image:@"bottom_me_icon"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image {
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_click",image]];
    self.tabBar.tintColor = GOLDEN_COLOR;
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BBDRootNavigationController *nav = [[BBDRootNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}



@end
