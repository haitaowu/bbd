//
//  BBDRegisterViewController.m
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDRegisterViewController.h"
#import "BBDDefaultUser.h"
#import <SVProgressHUD.h>
#import "BBDGestureViewController.h"
#import "BBDAgreementController.h"

@interface BBDRegisterViewController ()

/// 手机输入框
@property (nonatomic, strong) HYTextField *telTextField;
/// 验证码
@property (nonatomic, strong) HYTextField *codeTextField;
/// 数字密码
@property (nonatomic, strong) HYTextField *passwordTextField;
/// 是否绘制图案
@property (nonatomic, strong) UIButton *drawButton;
/// 线
@property (nonatomic, strong) UIView *line;
/// 已有帐号 去登录
@property (nonatomic, strong) UIButton *loginButton;
/// 用户协议
@property (nonatomic, strong) UIButton *agreementButton;
/// 注册按钮
@property (nonatomic, strong) UIButton *registerButton;
/// 底部说明
@property (nonatomic, strong) UILabel *infoLabel;


/// 接受到的验证码
@property (nonatomic, copy) NSString *code;

@end

@implementation BBDRegisterViewController

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
    self.title = @"注册";
    
    [self.view addSubview:self.telTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.drawButton];
    [self.view addSubview:self.line];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.agreementButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.infoLabel];
    
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.mas_equalTo(self.telTextField);
        make.top.mas_equalTo(self.telTextField.mas_bottom).mas_offset(15);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.codeTextField.mas_bottom).mas_offset(15);
        make.left.right.height.mas_equalTo(self.telTextField);
    }];
    
    [self.drawButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.telTextField).mas_offset(5);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self.passwordTextField);
        make.top.mas_equalTo(self.drawButton.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(1);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.drawButton);
        make.top.mas_equalTo(self.line.mas_bottom).mas_offset(10);
    }];
    
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(self.registerButton.mas_top).mas_offset(0);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self.infoLabel.mas_top).mas_offset(-20);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(40);
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
 *  点击了绘制密码
 */
- (void)drawButtonClick:(UIButton *)sender {

    // 没有设置手势密码
    if (!sender.selected) {
        BBDGestureViewController *gestureViewController = [[BBDGestureViewController alloc] init];
        gestureViewController.gestureStyle = SetPwdModel;
        gestureViewController.block = ^(){
        
            sender.selected = YES;
        };
        [self presentViewController:gestureViewController animated:YES completion:nil];
    }
    // 取消密码
    [KeychainData forgotPsw];
    sender.selected = NO;
}
/**
 *  点击了去登录
 */
- (void)loginButtonClick:(UIButton *)sender {
    // 返回登录界面
    [self.navigationController popViewControllerAnimated:YES];
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
    [BBDDefaultUser registerCodeWithTel:self.telTextField.text withFinished:^(NSDictionary *responseDictionary, NSError *error) {
        
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
 *  点击了注册
 */
- (void)registerButtonClick:(UIButton *)sender {

    // 1、判断是否手机、验证码、密码
    if (self.telTextField.text == nil || [self.telTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    if (self.codeTextField.text == nil || [self.codeTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
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

    // 3、注册
    [BBDDefaultUser registerWithTel:self.telTextField.text withPassword:self.passwordTextField.text withFinished:^(NSInteger code, NSError *error) {
       
        if (error != nil) {
            return ;
        }
        // 注册失败
        if (code == -1 || code == 1) {
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
            return;
        }
        // 手机号被占用
        if (code == 3) {
            [SVProgressHUD showErrorWithStatus:@"手机号已经被注册"];
            return;
        }
        // 注册成功
        // 保存手势密码
        [NSUserDefaults saveIsGesture];
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
    
    if (textField == self.passwordTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}
/**
 *  点击用户协议
 */
- (void)agreementButtonClick {
    BBDAgreementController *agreenmentController = [[BBDAgreementController alloc] init];
    agreenmentController.type = 1;
    [self.navigationController pushViewController:agreenmentController animated:YES];
}

#pragma mark －懒加载
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

- (HYTextField *)passwordTextField {

    if (_passwordTextField == nil) {
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"log_code_icon"]];
        
        _passwordTextField = [[HYTextField alloc] initWithLeftView:leftView withRightView:nil withPlaceholder:@"设置6位数密码" withFontSize:13 withBorderStyle:UITextBorderStyleRoundedRect];
        
        _passwordTextField.keyboardType = UIKeyboardTypePhonePad;
        // 密码输入框
        _passwordTextField.secureTextEntry = YES;
        
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _passwordTextField;
}

- (UIButton *)drawButton {

    if (_drawButton == nil) {
        _drawButton = [[UIButton alloc] init];
        
        [_drawButton setImage:[UIImage imageNamed:@"register_round_icon"] forState:UIControlStateNormal];
        [_drawButton setImage:[UIImage imageNamed:@"register_round_icon_click"] forState:UIControlStateSelected];
        
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc] initWithString:@" 绘制密码解锁图案（可选）"];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range = [[hintString string] rangeOfString:@"（可选）"];
        [hintString addAttribute:NSForegroundColorAttributeName value:RCColor(90, 90, 90) range:NSMakeRange(0, range.location)];
        [hintString addAttribute:NSForegroundColorAttributeName value:RCColor(150, 150, 150) range:range];
        
        [_drawButton setAttributedTitle:hintString forState:UIControlStateNormal];
        
        _drawButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_drawButton addTarget:self action:@selector(drawButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawButton;
}

- (UIView *)line {

    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RCColor(214, 215, 220);
    }
    return _line;
}

- (UIButton *)loginButton {

    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        
        [_loginButton setImage:[UIImage imageNamed:@"register_account_icon"] forState:UIControlStateNormal];
        
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc] initWithString:@"已有帐号？去登陆"];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range = [[hintString string] rangeOfString:@"去登陆"];
        [hintString addAttribute:NSForegroundColorAttributeName value:RCColor(90, 90, 90) range:NSMakeRange(0, range.location)];
        [hintString addAttribute:NSForegroundColorAttributeName value:GOLDEN_COLOR range:range];
        
        [_loginButton setAttributedTitle:hintString forState:UIControlStateNormal];
        
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)agreementButton {

    if (_agreementButton == nil) {
        _agreementButton = [[UIButton alloc] init];
        
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc] initWithString:@"点击注册意味着同意用户协议"];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range = [[hintString string] rangeOfString:@"用户协议"];
        [hintString addAttribute:NSForegroundColorAttributeName value:RCColor(90, 90, 90) range:NSMakeRange(0, range.location)];
        [hintString addAttribute:NSForegroundColorAttributeName value:GOLDEN_COLOR range:range];
        
        [_agreementButton setAttributedTitle:hintString forState:UIControlStateNormal];
        
        _agreementButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_agreementButton addTarget:self action:@selector(agreementButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreementButton;
}

- (UIButton *)registerButton {

    if (_registerButton == nil) {
        _registerButton = [[UIButton alloc] init];
        
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_registerButton setBackgroundColor:GOLDEN_COLOR];
        _registerButton.layer.cornerRadius = 3.0;
        
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
