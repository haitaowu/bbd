//
//  BBDPhoneVerifyController.m
//  bbd
//
//  Created by Lei Xu on 2016/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDPhoneVerifyController.h"
#import "XLTextField.h"
#import "BBDNextView.h"
#import "BBDFillInfoController.h"
#import "NSString+CheckTel.h"
#import "UIAlertView+EXtension.h"
#import <SVProgressHUD.h>

@interface BBDPhoneVerifyController ()
@property(nonatomic,weak) XLTextField *phoneTextField;
@property(nonatomic,weak) XLTextField *codeTextField;
@property(nonatomic,strong) UIButton *obtainButton;
@property(nonatomic,strong) NSString *verifyCode;

@end

@implementation BBDPhoneVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 隐藏键盘
    [self.view endEditing:YES];
}

-(void)setupUI{
    
    self.navigationItem.title = @"验证手机号";    
    self.keyboardNote = YES;
    [self.bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    XLTextField *phoneTextField = [[XLTextField alloc] init];
    phoneTextField.backgroundColor = [UIColor whiteColor];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.textColor = [UIColor darkGrayColor];
    phoneTextField.font = [UIFont systemFontOfSize:14.0];
    phoneTextField.placeholder = @"实名手机号";
    [phoneTextField drawLeftView:@"home_tell_phone_icon"];
    phoneTextField.layer.masksToBounds = YES;
    phoneTextField.layer.cornerRadius = 3.0;
    phoneTextField.layer.borderWidth  = 1.0f;
    phoneTextField.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    [phoneTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phoneTextField];
    _phoneTextField = phoneTextField;
    

    UIButton *obtainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    obtainButton.size =CGSizeMake(80, 40);
    [obtainButton setTitle:@"获取" forState:UIControlStateNormal];
    [obtainButton setTitleColor:GOLDEN_COLOR forState:UIControlStateNormal];
    [obtainButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [obtainButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [obtainButton setBackgroundImage:[UIImage imageNamed:@"apply_gain_bottom_icon"] forState:UIControlStateNormal];
    [obtainButton setBackgroundImage:[UIImage imageNamed:@"apply_gain_bottom_icon"] forState:UIControlStateDisabled];
    
    [obtainButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [obtainButton addTarget:self action:@selector(obtain:) forControlEvents:UIControlEventTouchUpInside];
    obtainButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _obtainButton = obtainButton;
    
    
    XLTextField *codeTextField = [[XLTextField alloc] init];
    codeTextField.backgroundColor = [UIColor whiteColor];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.textColor = [UIColor darkGrayColor];
    codeTextField.font = [UIFont systemFontOfSize:14.0];
    codeTextField.placeholder = @"验证码";
    [codeTextField drawLeftView:@"home_tell_new_icon"];
    codeTextField.layer.masksToBounds = YES;
    codeTextField.layer.cornerRadius = 5.0;
    codeTextField.layer.borderWidth  = 1.0f;
    codeTextField.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    codeTextField.rightView = obtainButton;
    codeTextField.rightViewMode = UITextFieldViewModeAlways;
    [codeTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:codeTextField];
    _codeTextField = codeTextField;
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(30);
    }];
    
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(phoneTextField.mas_bottom).mas_offset(30);
    }];
    


}

#pragma mark - TextField监听事件
-(void)changeText:(UITextField*)textField{
    
    if (textField == _phoneTextField) {
        if (textField.text.length >= 11)  // 手机号11位
            textField.text = [textField.text substringToIndex:11];
    }else {
        if (textField.text.length >= 4)   //  验证码4位
            textField.text = [textField.text substringToIndex:4];
    }

    self.bottomButton.enabled = (_phoneTextField.text.length==11)&&(_codeTextField.text.length==4)?YES:NO;
    
}

#pragma mark - 获取验证码
-(void)obtain:(UIButton*)btn{
    
    
    if(![NSString checkTel:_phoneTextField.text]){
        [UIAlertView wariningWithTitle:@"手机号不正确"];
        return;
    }
    
    [SVProgressHUD show];
    NSDictionary *parameters = @{@"phone":_phoneTextField.text};
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"verificationcode/phoneCode"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (CODE == 2) {
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功，请注意查收"];
//            [UIAlertView wariningWithTitle:responseObject[@"data"]];
            _verifyCode = responseObject[@"data"];
            [self obtainVerifyCode];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
    
    
}

#pragma mark - 获取验证码  60S倒计时
-(void)obtainVerifyCode{
    
    
    __block int time = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _obtainButton.enabled = YES;
                _phoneTextField.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _obtainButton.enabled = NO;
                _phoneTextField.userInteractionEnabled = NO;
                NSString *strTime = [NSString stringWithFormat:@"%2d S",time];
                [_obtainButton setTitle:strTime forState:UIControlStateDisabled];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}


#pragma mark -  上一步/下一步
-(void)next{
    
    if(![_codeTextField.text isEqualToString:_verifyCode]){
        [UIAlertView wariningWithTitle:@"验证码错误"];
        return;
    }
    
    BBDFillInfoController *fillInfoVC = [[BBDFillInfoController alloc] init];
    fillInfoVC.phoneVerifyArr = [NSArray arrayWithObjects:_phoneTextField.text,_codeTextField.text, nil];
    fillInfoVC.fastLoanApplyArr = self.fastLoanApplyArr;
    [self.navigationController pushViewController:fillInfoVC animated:YES];

}

@end
