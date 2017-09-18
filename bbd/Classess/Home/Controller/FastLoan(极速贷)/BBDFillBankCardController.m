//
//  BBDFillBankCardController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDFillBankCardController.h"
#import "BBDMeMyBankCardController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "UIAlertView+EXtension.h"

@interface BBDFillBankCardController ()<BBDMeMyBankCardControllerDelegate>

/** 信用额度Label */
@property(nonatomic,weak) UILabel *quotaLabel;

@property(nonatomic,weak) UITextField *bankCardTextField;

@end

@implementation BBDFillBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    [self setupUI];
}


-(void)loadData{
    

    NSDictionary *parameters = @{@"user_id":@([NSUserDefaults getUserId])};
    
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"speedLoan/getUserQuota"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        if (CODE == 2) {
            _quotaLabel.text = [NSString stringWithFormat:@"%@元",responseObject[@"data"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误");
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 隐藏键盘
    [self.view endEditing:YES];
}

-(void)setupUI{
    self.navigationItem.title = @"银行卡填写";
    
    
    [self.bottomButton setTitle:@"提交申请" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bank_bottom_icon"]];
    [self.view addSubview:imageView];
    
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.font = [UIFont systemFontOfSize:13];
    leftLabel.text = @"您的信用额度为";
    [imageView addSubview:leftLabel];
    
    UILabel *quotaLabel = [[UILabel alloc] init];
    quotaLabel.textColor = [UIColor whiteColor];
    quotaLabel.font = [UIFont systemFontOfSize:15];
    quotaLabel.text = @"0元";
    [imageView addSubview:quotaLabel];
    _quotaLabel = quotaLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = @"选择预留的银行卡";
    [self.view addSubview:titleLabel];
    
    UIButton *cardBtn = [[UIButton alloc] init];
    [cardBtn setImage:[UIImage imageNamed:@"home_bank_card_bottom_icon"] forState:UIControlStateNormal];
    [cardBtn addTarget:self action:@selector(myBankCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardBtn];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.borderStyle = UITextBorderStyleBezel;
    _bankCardTextField = textField;
    [textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:textField];

    
    

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.left.mas_equalTo(10);
    }];
    
    [quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.right.mas_equalTo(-10);
    }];
    
    
    [cardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(imageView.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cardBtn.mas_centerY);
        make.height.mas_equalTo(cardBtn.mas_height);
        make.left.mas_equalTo(10);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(cardBtn.mas_bottom).mas_offset(10);
    }];
    
    
}

#pragma mark - 提交申请
-(void)submit{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"]          = @([NSUserDefaults getUserId]);
    parameters[@"name"]             = self.fastLoanApplyArr[0];
    parameters[@"cart_number"]      = self.fastLoanApplyArr[1];
    parameters[@"cart_front"]       = self.fastLoanApplyArr[2][0][0];
    parameters[@"cart_back"]        = self.fastLoanApplyArr[2][0][1];
    parameters[@"hand_front"]       = self.fastLoanApplyArr[2][1][0];
    parameters[@"hand_back"]        = self.fastLoanApplyArr[2][1][1];
    parameters[@"cart_address"]     = self.fastLoanApplyArr[3];
    parameters[@"birthday"]         = self.fastLoanApplyArr[4];
    parameters[@"address"]          = self.fastLoanApplyArr[5];
    parameters[@"phone"]            = self.phoneVerifyArr[0];
    parameters[@"taobao_account"]   = self.fillInfoArr[0];
    parameters[@"alipay_account"]   = self.fillInfoArr[1];
    parameters[@"bank_no"]          = _bankCardTextField.text;
    
    
    [SVProgressHUD showWithStatus:@"正在提交中"];
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"speedLoan/submitApply"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        if (CODE == 2) {
            [UIAlertView wariningWithTitle:@"申请提交成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [UIAlertView wariningWithTitle:@"申请提交失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [UIAlertView wariningWithTitle:@"申请提交失败"];
    }];
    
}

-(void)changeText:(UITextField*)textField{
    
    self.bottomButton.enabled = textField.text.length>0?YES:NO;

}

/**我的银行卡*/
-(void)myBankCard
{
    BBDMeMyBankCardController * bankCardVC = [[BBDMeMyBankCardController alloc]init];
    
    bankCardVC.delegate = self;
    [self.navigationController pushViewController:bankCardVC animated:YES];
}

-(void)meMyBankCardController:(BBDMeMyBankCardController *)bankCardController didSelectBankCard:(NSString *)bankCard{
    
    _bankCardTextField.text = bankCard;
    
    self.bottomButton.enabled = _bankCardTextField.text.length>0?YES:NO;
    
}

@end
