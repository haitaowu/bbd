//
//  BBDForgetPwdViewController.m
//  bbd
//
//  Created by 韩加宇 on 17/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDForgetPwdViewController.h"
#import "BBDDefaultUser.h"
#import <SVProgressHUD.h>
#import "BBDSetPwdViewController.h"

@interface BBDForgetPwdViewController ()

/// 手机号
@property (nonatomic, strong) HYTextField *telTextField;
/// 验证码
@property (nonatomic, strong) HYTextField *codeTextField;
/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;

/// 接收到的验证码
@property (nonatomic, copy) NSString *code;
@end

@implementation BBDForgetPwdViewController

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
    
    [self.view addSubview:self.telTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.submitButton];
    
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.mas_equalTo(self.telTextField);
        make.top.mas_equalTo(self.telTextField.mas_bottom).mas_offset(15);
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
    
    if (textField == self.telTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.codeTextField) {
        if (textField.text.length > 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
}

/**
 *  接受验证码
 */
- (void)codeButtonClick:(UIButton *)sender {
    
    // 1、判断是否输入了电话
    if (self.telTextField.text == nil || [self.telTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    // 2、判断是否电话是否正确
    if (![NSString checkTel:self.telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    // 3、获取验证码
    [BBDDefaultUser alterPassWordCodeWithTel:self.telTextField.text withFinished:^(NSDictionary *responseDictionary, NSError *error) {
        
        if (error != nil) {
            return ;
        }
        // 发送失败提示信息
        if ([[responseDictionary valueForKey:@"code"] integerValue] == 1 || [[responseDictionary valueForKey:@"code"] integerValue] == -1) {
            [SVProgressHUD showErrorWithStatus:[responseDictionary valueForKey:@"message"]];
            return;
        }
        
        // 1、保存验证码
        self.code = [responseDictionary valueForKey:@"data"];
        
        // 2、进入定时器状态
        [self timerCode:sender];
    }];
}

/**
 *  接受验证码倒计时
 */
- (void)timerCode:(UIButton *)sender {
    
    ///  获取验证码  60S倒计时
    __block int time = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                sender.enabled = YES;
                [sender setTitle:@"获取" forState:UIControlStateNormal];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                sender.enabled = NO;
                NSString *strTime = [NSString stringWithFormat:@"%2d S",time];
                [sender setTitle:strTime forState:UIControlStateNormal];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
/**
 *  点击提交
 */
- (void)submitButtonClick:(UIButton *)sender {

    // 1、判断是否手机、验证码、密码
    if (self.telTextField.text == nil || [self.telTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    if (self.codeTextField.text == nil || [self.codeTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    // 2.1、判断电话是否正确
    if (![NSString checkTel:self.telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    // 2.2、判断验证码是否正确
    if (![self.code isEqualToString:self.codeTextField.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"验证码错误"];
        return;
    }
    
    BBDSetPwdViewController *setPwdViewController = [[BBDSetPwdViewController alloc] init];
    setPwdViewController.tel = self.telTextField.text;
    [self.navigationController pushViewController:setPwdViewController animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

#pragma mark -懒加载
- (HYTextField *)telTextField {
    
    if (_telTextField == nil) {
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_tell_phone_icon"]];
        _telTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:nil withPlaceholder:@"手机号" withFontSize:13 withBorderStyle:UITextBorderStyleRoundedRect];
        
        _telTextField.keyboardType = UIKeyboardTypePhonePad;
        
        [_telTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _telTextField;
}

- (HYTextField *)codeTextField {
    
    if (_codeTextField == nil) {
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_tell_new_icon"]];
        // 右边的获取验证码按钮
        UIButton *rightView = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, 50, 33)];
        [rightView setTitle:@"获取" forState:UIControlStateNormal];
        [rightView setTitleColor:GOLDEN_COLOR forState:UIControlStateNormal];
        rightView.titleLabel.textAlignment = NSTextAlignmentCenter;
        rightView.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightView setBackgroundImage:[UIImage imageNamed:@"apply_gain_bottom_icon"] forState:UIControlStateNormal];
        [rightView setBackgroundImage:[UIImage imageNamed:@"apply_gain_bottom_icon"] forState:UIControlStateHighlighted];
        [rightView addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _codeTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:rightView withPlaceholder:@"验证码" withFontSize:13 withBorderStyle:UITextBorderStyleRoundedRect];
        
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;
        
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _codeTextField;
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
