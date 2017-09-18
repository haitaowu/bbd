//
//  BBDGestureViewController.m
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDGestureViewController.h"
#import "BBDLoginViewController.h"
#import "BBDRootNavigationController.h"

@interface BBDGestureViewController ()

@end

@implementation BBDGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupUI];
}

/**
 *  设置界面
 */
- (void)setupUI {

    self.view.backgroundColor = BASE_COLOR;
    self.title = @"手势密码";
    
    [self.view addSubview:self.alipay];
    [self.view addSubview:self.otherButton];
    
    [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.right.mas_equalTo(-10);
        
    }];
}
/**
 *  其他方式登录
 */
- (void)otherButtonClick {

    // 忘记手势密码
    [KeychainData forgotPsw];
    [NSUserDefaults removeIsGesture];
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"reveal";
    animation.duration = 0.3;
    animation.subtype =kCATransitionFromRight;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view removeFromSuperview];
    
    BBDRootNavigationController *nav = [[BBDRootNavigationController alloc] initWithRootViewController:[[BBDLoginViewController alloc] init]];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

#pragma mark -懒加载
- (AliPayViews *)alipay {

    if (_alipay == nil) {
        _alipay = [[AliPayViews alloc] initWithFrame:self.view.bounds];
        
        if (self.gestureStyle == SetPwdModel) {
            [KeychainData forgotPsw];
        }
        
        _alipay.gestureModel = self.gestureStyle;
        
        __weak typeof(self) weakSelf = self;
        _alipay.block = ^(NSString *pswString) {
            NSLog(@"设置密码成功-----你的密码为 = 【%@】\n\n", pswString);
            weakSelf.block();
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _alipay;
}
- (UIButton *)otherButton {

    if (_otherButton == nil) {
        _otherButton = [[UIButton alloc] init];
        
        [_otherButton setTitle:@"其他方式登录" forState:UIControlStateNormal];
        _otherButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _otherButton.hidden = YES;
        [_otherButton addTarget:self action:@selector(otherButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherButton;
}
@end
