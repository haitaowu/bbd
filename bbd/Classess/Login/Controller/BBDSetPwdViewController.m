//
//  BBDSetPwdViewController.m
//  bbd
//
//  Created by 韩加宇 on 17/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDSetPwdViewController.h"
#import "BBDDefaultUser.h"
#import <SVProgressHUD.h>
#import "BBDSetPwdViewController.h"

@interface BBDSetPwdViewController ()

/// 手机号
@property (nonatomic, strong) HYTextField *passwordTextField;
/// 验证码
@property (nonatomic, strong) HYTextField *aginTextField;
/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;

/// 接收到的验证码
@property (nonatomic, copy) NSString *code;
@end

@implementation BBDSetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
/**
 *  设置界面
 */
- (void)setupUI {
    
    self.view.backgroundColor = BASE_COLOR;
    self.title = @"忘记密码";
    
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.aginTextField];
    [self.view addSubview:self.submitButton];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    
    [self.aginTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.mas_equalTo(self.passwordTextField);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(15);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(40);
    }];
}

/**
 *  输入框的长度限制
 */
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == self.passwordTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    if (textField == self.aginTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}
/**
 *  点击提交
 */
- (void)submitButtonClick:(UIButton *)sender {
    
    // 1、判断是否手机、验证码、密码
    if (self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (self.aginTextField.text == nil || [self.aginTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return;
    }
    
    // 2、修改密码
    [BBDDefaultUser alterPassWordWithTel:self.tel withNewPwd:self.aginTextField.text withFinished:^(NSInteger code, NSError *error) {
       
        if (error != nil) {
            return ;
        }
        
        if (code == 2) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
        
        if (code == 1) {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
            return;
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

#pragma mark -懒加载
- (HYTextField *)passwordTextField {
    
    if (_passwordTextField == nil) {
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_key_icon"]];
        _passwordTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:nil withPlaceholder:@"新密码" withFontSize:13 withBorderStyle:UITextBorderStyleRoundedRect];
        
        _passwordTextField.keyboardType = UIKeyboardTypePhonePad;
        
        _passwordTextField.secureTextEntry = YES;
        
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}

- (HYTextField *)aginTextField {
    
    if (_aginTextField == nil) {
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_key_icon"]];
        
        _aginTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:nil withPlaceholder:@"重复新密码" withFontSize:13 withBorderStyle:UITextBorderStyleRoundedRect];
        
        _aginTextField.keyboardType = UIKeyboardTypePhonePad;
        
        _aginTextField.secureTextEntry = YES;
        
        [_aginTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _aginTextField;
}

- (UIButton *)submitButton {
    
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc] init];
        
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton setBackgroundColor:GOLDEN_COLOR];
        _submitButton.layer.cornerRadius = 3.0;
        
        [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

@end

