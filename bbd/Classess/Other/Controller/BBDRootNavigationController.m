//
//  BBDRootNavigationController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDRootNavigationController.h"
#import <SVProgressHUD.h>

@interface BBDRootNavigationController ()

@end

@implementation BBDRootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
+ (void)initialize {
    // 设置UIUINavigationBar的主题
    [self setupNavigationBarTheme];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupNavigationBarTheme {
    // 通过appearance对象能修改整个项目中所有UIBarbuttonItem的样式
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    [appearance setBackgroundImage:[UIImage createImageWithColor:RCColor(246, 246, 246)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[UIImage new]];
    appearance.tintColor = [UIColor blackColor];
    
    // 设置文字
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    att[NSForegroundColorAttributeName] = [UIColor blackColor];
    [appearance setTitleTextAttributes:att];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [SVProgressHUD dismiss];

    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航栏的按钮
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        backButton.tintColor = [UIColor blackColor];
        viewController.navigationItem.leftBarButtonItem = backButton;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
        
        [self setNavigationBarHidden:NO animated:YES];

    }else{
        [self setNavigationBarHidden:YES animated:YES];

    }
    [super pushViewController:viewController animated:animated];
}


- (void)back {
    [SVProgressHUD dismiss];
    [self popViewControllerAnimated:YES];
}


@end
