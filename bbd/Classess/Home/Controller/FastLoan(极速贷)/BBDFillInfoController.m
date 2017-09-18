//
//  BBDFillInfoController.m
//  bbd
//
//  Created by Lei Xu on 2016/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDFillInfoController.h"
#import "BBDFillBankCardController.h"

@interface BBDFillInfoController ()
@property(nonatomic,weak) UITextField *tbTextField;
@property(nonatomic,weak) UITextField *zfbTextField;

@end

@implementation BBDFillInfoController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupUI];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 隐藏键盘
    [self.view endEditing:YES];
}

-(void)setupUI{
    
    self.navigationItem.title = @"信息填写";

    [self.bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *tbTextField = [[UITextField alloc] init];
    tbTextField.backgroundColor = [UIColor whiteColor];
    tbTextField.font = [UIFont systemFontOfSize:15];
    tbTextField.borderStyle = UITextBorderStyleRoundedRect;
    [tbTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:tbTextField];
    _tbTextField = tbTextField;
    
    UILabel *tbLabel = [[UILabel alloc] init];
    tbLabel.text = @"淘宝账号";
    tbLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tbLabel];
    
    
    UITextField *zfbTextField = [[UITextField alloc] init];
    zfbTextField.backgroundColor = [UIColor whiteColor];
    zfbTextField.font = [UIFont systemFontOfSize:15];
    zfbTextField.borderStyle = UITextBorderStyleRoundedRect;
    [zfbTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:zfbTextField];
    _zfbTextField = zfbTextField;
    
    
    UILabel *zfbLabel = [[UILabel alloc] init];
    zfbLabel.text = @"支付宝账号";
    zfbLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:zfbLabel];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"提醒：淘宝账号和支付宝账号只是为最终确定借贷额度做参考，不会以任何方式泄露给他人";
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:titleLabel];
    
    [tbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tbTextField.mas_centerY);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(zfbLabel.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    [tbTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(zfbTextField.mas_width);
    }];
    
    
    
    [zfbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(zfbTextField.mas_centerY);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    
    [zfbTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tbTextField.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(zfbLabel.mas_right).mas_offset(20);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(zfbTextField.mas_bottom).mas_offset(10);
    }];
    
    
}


#pragma mark - textField监听改变
-(void)changeText:(UITextField *)textField{

    self.bottomButton.enabled = (_tbTextField.text.length>0&&_zfbTextField.text.length>0)?YES:NO;
    
}

#pragma mark -  上一步/下一步
-(void)next{
    
    BBDFillBankCardController *fillBankCardVc = [[BBDFillBankCardController alloc] init];
    fillBankCardVc.fastLoanApplyArr = self.fastLoanApplyArr;
    fillBankCardVc.phoneVerifyArr = self.phoneVerifyArr;
    fillBankCardVc.fillInfoArr = [NSArray arrayWithObjects:_tbTextField.text,_zfbTextField.text, nil];
    [self.navigationController pushViewController:fillBankCardVc animated:YES];

}

@end
