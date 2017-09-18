//
//  BBDFastFillBankCardController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCarFillBankCardController.h"
#import "BBDCarPhoneVerifyController.h"
#import "BBDMeMyBankCardController.h"
#import "BBDCarPhoneVerifyController.h"
#import "BBDCommonPhoneVerifyController.h"

@interface BBDCarFillBankCardController ()<BBDMeMyBankCardControllerDelegate>
@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,weak) UITextField *bankTextField;
@property(nonatomic,weak) UITextField *zfbTextField;
@end

@implementation BBDCarFillBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
    
}

-(void)setupUI{
    
    self.navigationItem.title = @"银行卡填写";

    [self.bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];

    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"放款账号选择 ▶▸";
    [self.view addSubview:titleLabel];
    
    
    UIButton *zfbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zfbBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zfbBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [zfbBtn setTitle:@"支付宝" forState:UIControlStateNormal];
    [zfbBtn setImage:[UIImage imageNamed:@"home_bank_choice_icon"] forState:UIControlStateNormal];
    [zfbBtn setImage:[UIImage imageNamed:@"home_bank_choice_icon_click"] forState:UIControlStateDisabled];
    [zfbBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    zfbBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.view addSubview:zfbBtn];
    
    UITextField *zfbTextField = [[UITextField alloc] init];
    zfbTextField.borderStyle = UITextBorderStyleRoundedRect;
    zfbTextField.backgroundColor = [UIColor whiteColor];
    zfbTextField.font = [UIFont systemFontOfSize:13];
    zfbTextField.placeholder = @"填写放款的支付宝账号";
    [zfbTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    _zfbTextField= zfbTextField;
    [self.view addSubview:zfbTextField];
    
    
    UIButton *bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bankBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bankBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bankBtn setTitle:@"银行卡" forState:UIControlStateNormal];
    [bankBtn setImage:[UIImage imageNamed:@"home_bank_choice_icon"] forState:UIControlStateNormal];
    [bankBtn setImage:[UIImage imageNamed:@"home_bank_choice_icon_click"] forState:UIControlStateDisabled];
    [bankBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    bankBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self choose:bankBtn];
    [self.view addSubview:bankBtn];
    
    UITextField *bankTextField = [[UITextField alloc] init];
    bankTextField.borderStyle = UITextBorderStyleRoundedRect;
    bankTextField.backgroundColor = [UIColor whiteColor];
    [bankTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    _bankTextField = bankTextField;
    [self.view addSubview:bankTextField];
    
    
    UILabel *bankLabel = [[UILabel alloc] init];
    bankLabel.text = @"选择预留的银行卡";
    bankLabel.font = [UIFont systemFontOfSize:13];
    bankLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:bankLabel];
    
    UIButton *chooseBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBankBtn setImage:[UIImage imageNamed:@"home_bank_card_bottom_icon"] forState:UIControlStateNormal];
    [chooseBankBtn addTarget:self action:@selector(myBankCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseBankBtn];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    
    [zfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
    }];
    
    
    [zfbTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(zfbBtn.mas_bottom).mas_offset(3);
    }];
    
    [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(zfbTextField.mas_bottom).mas_offset(15);
    }];
    
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(bankBtn.mas_bottom);
    }];
    
    [bankTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(bankLabel.mas_bottom).mas_offset(2);
    }];
    
    [chooseBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
        make.centerY.mas_equalTo(bankLabel.mas_centerY);
    }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -下一步
-(void)next{

    
    if ([self.className isEqual:[BBDCarPhoneVerifyController class]]) {
        BBDCarPhoneVerifyController *carPhoneVerfiyVC = [[BBDCarPhoneVerifyController alloc] init];
        
        carPhoneVerfiyVC.advanceArr =  [_selectBtn.currentTitle isEqualToString:@"银行卡"]?@[@"1",_bankTextField.text]:@[@"0",_zfbTextField.text];
        
        carPhoneVerfiyVC.carLoanApplyArr = self.carLoanApplyArr;
        
        NSLog(@"汽车");
        [self.navigationController pushViewController:carPhoneVerfiyVC animated:YES];
        
    }else{
        BBDCommonPhoneVerifyController *commonPhoneVerifyVC = [[BBDCommonPhoneVerifyController alloc] init];
        commonPhoneVerifyVC.commonLoanApplyArr = self.carLoanApplyArr;
        
        commonPhoneVerifyVC.advanceArr =  [_selectBtn.currentTitle isEqualToString:@"银行卡"]?@[@"1",_bankTextField.text]:@[@"0",_zfbTextField.text];
        
        NSLog(@"普通");
        commonPhoneVerifyVC.moneyID = self.moneyID;
        [self.navigationController pushViewController:commonPhoneVerifyVC animated:YES];
    }
    
    
}

-(void)changeText:(UITextField *)textField{
    
    [self judgeFillMessageFinsh];

}

-(void)choose:(UIButton *)btn{
    _selectBtn.enabled = YES;
    _selectBtn = btn;
    _selectBtn.enabled = NO;
    [self judgeFillMessageFinsh];
}


/** 判断信息是否全部填写 */
-(void)judgeFillMessageFinsh{
    if (  ([_selectBtn.currentTitle isEqualToString:@"银行卡"] && _bankTextField.text.length>0)
        ||([_selectBtn.currentTitle isEqualToString:@"支付宝"] && _zfbTextField.text.length>0)) {
        
        self.bottomButton.enabled = YES;
    }else{
        self.bottomButton.enabled = NO;
    }
    
}

/**我的银行卡*/
-(void)myBankCard
{
    BBDMeMyBankCardController * bankCardVC = [[BBDMeMyBankCardController alloc]init];
    bankCardVC.delegate = self;
    [self.navigationController pushViewController:bankCardVC animated:YES];
}

-(void)meMyBankCardController:(BBDMeMyBankCardController *)bankCardController didSelectBankCard:(NSString *)bankCard{
    _bankTextField.text = bankCard;
    [self judgeFillMessageFinsh];
}

@end
