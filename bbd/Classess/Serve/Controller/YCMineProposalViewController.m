//
//  YCMineProposalViewController.m
//  YiCheng
//
//  Created by 韩加宇 on 16/11/30.
//  Copyright © 2016年 Rcoming. All rights reserved.
//

#import "YCMineProposalViewController.h"
#import <SVProgressHUD.h>

@interface YCMineProposalViewController () <UITextViewDelegate>

/// 输入框
@property (nonatomic, strong) UITextView *messageTF;
/// 提交
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation YCMineProposalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
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

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.messageTF];
    [self.view addSubview:self.submitButton];
    
    [self.messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-200);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

#pragma mark -UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    if ([textView.text isEqualToString:@"输入您想说的"]) {
        textView.text = nil;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        // 取消第一响应者
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

#pragma mark -提交反馈
- (void)submitButtonClick {

    if ([self.messageTF.text isEqualToString:@"输入您想说的"] || [self.messageTF.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString * path=[NSString stringWithFormat:@"%@feedback/submitFeedBack",BASE_API];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [parameters setObject:@([NSUserDefaults getUserId])  forKey:@"user_id"];
    [parameters setObject:self.messageTF.text forKey:@"content"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject valueForKey:@"code"] integerValue] == 2) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            return ;
        }
        
        [SVProgressHUD showErrorWithStatus:[responseObject valueForKey:@"message"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络链接失败"];
    }];
}

#pragma mark -懒加载
- (UITextView *)messageTF {

    if (_messageTF == nil) {
        _messageTF = [[UITextView alloc] init];
        _messageTF.backgroundColor = RCColor(239, 239, 239);
        _messageTF.font = [UIFont systemFontOfSize:14];
        _messageTF.layer.cornerRadius = 3.0;
        _messageTF.text = @"输入您想说的";
        _messageTF.returnKeyType = UIReturnKeyDone;
        _messageTF.delegate = self;
        _messageTF.textColor = [UIColor grayColor];
    }
    return _messageTF;
}

- (UIButton *)submitButton {
    
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc] init];
        _submitButton.backgroundColor = GOLDEN_COLOR;
        [_submitButton setTitle:@"提交反馈" forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 5.0;
        [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

@end
