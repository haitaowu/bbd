//
//  BBDLoginViewController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDLoginViewController.h"
#import <SVProgressHUD.h>
#import "BBDDefaultUser.h"
#import "BBDRootTabBarController.h"
#import "BBDRegisterViewController.h"
#import "BBDForgetPwdViewController.h"
#import "KeychainData.h"

@interface BBDLoginViewController ()
/// 背景图
@property (nonatomic, strong) UIImageView *backGroudImageView;
/// logo
@property (nonatomic, strong) UIImageView *logoImageView;
/// app名称
@property (nonatomic, strong) UILabel *appNameLabel;
/// 手机号输入框
@property (nonatomic, strong) HYTextField *telTextField;
/// lineOne
@property (nonatomic, strong) UIView *lineOne;
/// 密码输入框
@property (nonatomic, strong) HYTextField *passwordTextField;
/// lineTwo
@property (nonatomic, strong) UIView *lineTwo;
/// 忘记密码
@property (nonatomic, strong) UIButton *forgetPasswordButton;
/// 登录按钮
@property (nonatomic, strong) UIButton *loginButton;
/// 没有帐号，去注册
@property (nonatomic, strong) UIButton *registerButton;
/// 底部说明
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation BBDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置界面
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    // 忘记手势密码
//    [KeychainData forgotPsw];
}
/**
 *  设置界面
 */
- (void)setupUI {

    [self.view addSubview:self.backGroudImageView];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.appNameLabel];
    [self.view addSubview:self.telTextField];
    [self.view addSubview:self.lineOne];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.lineTwo];
    [self.view addSubview:self.forgetPasswordButton];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.infoLabel];
    
    [self.backGroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.telTextField.mas_top).multipliedBy(0.5);
        make.width.height.mas_equalTo(80);
    }];
    
//    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.centerX.mas_equalTo(0);
//        make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(8);
//        
//        make.bottom.mas_equalTo(self.telTextField.mas_top).mas_offset(-45);
//    }];
    
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(0);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    
    [self.lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.telTextField).mas_offset(35);
        make.right.mas_equalTo(self.telTextField);
        make.top.mas_equalTo(self.telTextField.mas_bottom).mas_offset(1);
        make.height.mas_equalTo(1);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.mas_equalTo(self.telTextField);
        make.top.mas_equalTo(self.lineOne.mas_bottom).mas_offset(8);
    }];
    
    [self.lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.mas_equalTo(self.lineOne);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(1);
    }];
    
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.lineTwo);
        make.top.mas_equalTo(self.lineTwo.mas_bottom).mas_offset(8);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.forgetPasswordButton.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.telTextField);
        make.left.mas_equalTo(self.telTextField).mas_offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}
/**
 *  点击了忘记密码
 */
- (void)forgetPasswordButtonClick {

    [self.navigationController pushViewController:[[BBDForgetPwdViewController alloc] init] animated:YES];
}
/**
 *  点击了登录
 */
- (void)loginButtonClick {

    // 1、判断是否输入了手机号和密码
    if (self.telTextField.text == nil || [self.telTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    if (self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    // 2、请求接口
    [BBDDefaultUser loginWithTel:self.telTextField.text withPassword:self.passwordTextField.text withFinished:^(NSInteger code, NSError *error) {
       
        if (error != nil) {
            return ;
        }
        // 2.1、登录失败
        if (code == 1) {
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
            return;
        }
        // 2.2、登录成功
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        
        // 2.3、改变根控制器
        [self changeRootViewController];
    }];
}
/**
 *  点击了注册
 */
- (void)registerButtonClick {

    [self.navigationController pushViewController:[[BBDRegisterViewController alloc] init]  animated:YES];
}
/**
 *  改变根控制器
 */
- (void)changeRootViewController {
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"reveal";
    animation.duration = 0.3;
    animation.subtype =kCATransitionFromRight;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view removeFromSuperview];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[BBDRootTabBarController alloc] init];
}

#pragma mark -懒加载
- (UIImageView *)backGroudImageView {

    if (_backGroudImageView == nil) {
        _backGroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_background_icon"]];
    }
    return _backGroudImageView;
}

- (UIImageView *)logoImageView {

    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_icon"]];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _logoImageView;
}

- (UILabel *)appNameLabel {

    if (_appNameLabel == nil) {
        _appNameLabel = [[UILabel alloc] initWithTitle:@"帮帮贷" withFontSize:17];
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
        _appNameLabel.textColor = RCColor(90, 90, 90);
    }
    return _appNameLabel;
}

- (HYTextField *)telTextField {

    if (_telTextField == nil) {
        // 左边的图片
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_phone_icon"]];
    
        _telTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:nil withPlaceholder:@"手机号" withFontSize:15 withBorderStyle:0];
        // 设置键盘样式
        _telTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _telTextField;
}

- (UIView *)lineOne {

    if (_lineOne == nil) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = RCColor(214, 215, 220);
    }
    return _lineOne;
}

- (HYTextField *)passwordTextField {

    if (_passwordTextField == nil) {
        // 左边的图片
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_code_icon"]];
        
        _passwordTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:nil withPlaceholder:@"密码" withFontSize:15 withBorderStyle:0];
        // 设置键盘样式
        _passwordTextField.keyboardType = UIKeyboardTypePhonePad;
        // 密码输入框
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIView *)lineTwo {

    if (_lineTwo == nil) {
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = RCColor(214, 215, 220);
    }
    return _lineTwo;
}

- (UIButton *)forgetPasswordButton {

    if (_forgetPasswordButton == nil) {
        _forgetPasswordButton = [[UIButton alloc] init];
        [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_forgetPasswordButton setTitleColor:RCColor(90, 90, 90) forState:UIControlStateNormal];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
}

- (UIButton *)loginButton {

    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginButton setBackgroundColor:GOLDEN_COLOR];
        _loginButton.layer.cornerRadius = 3.0;
        
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {

    if (_registerButton == nil) {
        _registerButton = [[UIButton alloc] init];
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc] initWithString:@"没有帐号？去注册"];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range = [[hintString string] rangeOfString:@"注册"];
        // 设置字体的颜色
        [hintString addAttribute:NSForegroundColorAttributeName value:RCColor(90, 90, 90) range:NSMakeRange(0, range.location)];
        [hintString addAttribute:NSForegroundColorAttributeName value:GOLDEN_COLOR range:range];
        
        [_registerButton setAttributedTitle:hintString forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UILabel *)infoLabel {

    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"帮帮生活，小额贷款";
        _infoLabel.font = [UIFont systemFontOfSize:15];
        _infoLabel.textColor = RCColor(120, 120, 120);
    }
    return _infoLabel;
}

@end
