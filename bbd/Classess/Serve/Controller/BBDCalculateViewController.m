//
//  BBDCalculateViewController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDCalculateViewController.h"
#import "SGActionSheet.h"

#define FONT_SIZE 15

@interface BBDCalculateViewController () <UITextFieldDelegate, SGActionSheetDelegate>

/// 预借款金额
@property (nonatomic, strong) UILabel *moneyLabel;
/// 信用等级
@property (nonatomic, strong) UILabel *creditLabel;
/// 费率结果
@property (nonatomic, strong) UILabel *rateLabel;


/// 预借款金额输入框
@property (nonatomic, strong) UITextField *monerTextField;
/// 信用等级输入框
@property (nonatomic, strong) UITextField *creditTextField;
/// 费率结果
@property (nonatomic, strong) UILabel *resultLabel;
/// 计算按钮
@property (nonatomic, strong) UIButton *calculateButton;

/// 信用等级
@property (nonatomic, strong) NSArray *creditLevelArray;
/// type  0：信用较好  1：信用一般  2：信用欠佳  3：信用较差  4：信用很差  5：信用极差 6：没有信用
@property (nonatomic, assign) NSInteger type;

@end

@implementation BBDCalculateViewController

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
    self.title = @"费率计算";
    
    [self.view addSubview:self.moneyLabel];
    [self.view addSubview:self.creditLabel];
    [self.view addSubview:self.rateLabel];
    [self.view addSubview:self.monerTextField];
    [self.view addSubview:self.creditTextField];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.calculateButton];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
    }];
    
    [self.monerTextField mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.moneyLabel.mas_right).mas_offset(8);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.moneyLabel);
        make.height.mas_equalTo(35);
    }];
    
    [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.mas_equalTo(self.moneyLabel);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).mas_offset(8);
    }];
    
    [self.creditTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.mas_equalTo(self.monerTextField);
        make.centerY.mas_equalTo(self.creditLabel);
    }];
    
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.moneyLabel);
        make.top.mas_equalTo(self.creditLabel.mas_bottom).mas_offset(8);
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.mas_equalTo(self.creditTextField);
        make.centerY.mas_equalTo(self.rateLabel);
    }];
    
    [self.calculateButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(40);
        make.right.bottom.mas_equalTo(-40);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    [self.view endEditing:YES];
    
    if (textField == self.creditTextField) {
        SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:self.creditLevelArray];
        [sheet show];
        
        return NO;
    }
    
    return YES;
}

#pragma mark -SGActionSheetDelegate
- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {

    self.creditTextField.text = self.creditLevelArray[indexPath];
    self.type = indexPath;
}
/**
 *  点击了开始计算
 */
- (void)calculateButtonClick {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@rate/getMoneyRate",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@(self.type) forKey:@"type"];
    [parameters setValue:self.monerTextField.text forKey:@"money"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject valueForKey:@"code"] integerValue] == 2) {
            
            self.resultLabel.text = [responseObject valueForKey:@"data"];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark -懒加载
- (UILabel *)moneyLabel {

    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithTitle:@"预借款金额" withFontSize:FONT_SIZE];
    }
    return _moneyLabel;
}

- (UILabel *)creditLabel {

    if (_creditLabel == nil) {
        _creditLabel = [[UILabel alloc] initWithTitle:@"信用等级" withFontSize:FONT_SIZE];
    }
    return _creditLabel;
}

- (UILabel *)rateLabel {

    if (_rateLabel == nil) {
        _rateLabel = [[UILabel alloc] initWithTitle:@"费率结果" withFontSize:FONT_SIZE];
    }
    return _rateLabel;
}

- (UITextField *)monerTextField {

    if (_monerTextField == nil) {
        _monerTextField = [[UITextField alloc] init];
        _monerTextField.textAlignment = NSTextAlignmentRight;
        _monerTextField.borderStyle = UITextBorderStyleRoundedRect;
        _monerTextField.placeholder = @"/元";
        _monerTextField.font = [UIFont systemFontOfSize:FONT_SIZE];
        _monerTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _monerTextField;
}

- (UITextField *)creditTextField {

    if (_creditTextField == nil) {
        _creditTextField = [[UITextField alloc] init];
        _creditTextField.borderStyle = UITextBorderStyleRoundedRect;
        _creditTextField.font = [UIFont systemFontOfSize:FONT_SIZE];
        _creditTextField.delegate = self;
        _creditTextField.placeholder = @"请选择";
    }
    return _creditTextField;
}

- (UILabel *)resultLabel {

    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] initWithTitle:@"0.0%" withFontSize:FONT_SIZE];
        _resultLabel.textColor = [UIColor redColor];
        _resultLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _resultLabel;
}

- (NSArray *)creditLevelArray {

    if (_creditLevelArray == nil) {
        _creditLevelArray = @[@"信用较好",@"信用一般",@"信用欠佳",@"信用较差",@"信用很差",@"信用极差",@"没有信用"];
    }
    return _creditLevelArray;
}

- (UIButton *)calculateButton {

    if (_calculateButton == nil) {
        _calculateButton = [[UIButton alloc] init];
        [_calculateButton setBackgroundColor:GOLDEN_COLOR];
        [_calculateButton setTitle:@"开始计算" forState:UIControlStateNormal];
        _calculateButton.layer.cornerRadius = 3.0;
        
        [_calculateButton addTarget:self action:@selector(calculateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calculateButton;
}
@end
