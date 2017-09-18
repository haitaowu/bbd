//
//  BBDCarPhoneVerifyController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/6.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCommonPhoneVerifyController.h"

#import "BBDCarPhoneVerifyCell.h"
#import "BBDCarPhoneVerifyOtherCell.h"
#import "UIAlertController+Category.h"
#import "UIAlertView+EXtension.h"
#import "NSString+CheckTel.h"
#import <SVProgressHUD.h>

@interface BBDCommonPhoneVerifyController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSString *verifyCode;
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSMutableArray *messageArray;

@end

@implementation BBDCommonPhoneVerifyController

-(NSMutableArray *)messageArray{
    if (_messageArray == nil) {
        _messageArray = [NSMutableArray arrayWithObjects:@"",@"",@"",nil];
    }
    return _messageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@{@"image":@"home_tell_id_icon",
                   @"placeholder":@"身份证号"},
                 @{@"image":@"home_tell_new_icon",
                   @"placeholder":@"真实手机号"},
                 @{@"image":@"home_tell_phone_icon",
                   @"placeholder":@"验证码"}];
    
    [self setupUI];
}

-(void)setupUI{
    

    self.navigationItem.title = @"验证手机号";
    
    self.keyboardNote = YES;

    [self.bottomButton setTitle:@"提交申请" forState:UIControlStateNormal];

    [self.bottomButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];

    
    

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BBDCarPhoneVerifyCell class] forCellReuseIdentifier:NSStringFromClass([BBDCarPhoneVerifyCell class])];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBDCarPhoneVerifyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCarPhoneVerifyCell class])];
    
    cell.textField.placeholder = _dataArr[indexPath.row][@"placeholder"];
    [cell.textField drawLeftView:_dataArr[indexPath.row][@"image"]];
    
    cell.textField.inputAccessoryView = self.hideToolBar;
    
    [cell.textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == _dataArr.count-1) {
        
        cell.textField.rightViewMode = UITextFieldViewModeAlways;
        [cell.obtainButton addTarget:self action:@selector(obtain:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length == 15 || IDCardNumber.length == 18) {
        return YES;
    }
    return NO;
}

#pragma mark - 提交申请
-(void)submit{
    
    if (![self IsIdentityCard:self.messageArray[0]]) {
        [UIAlertView wariningWithTitle:@"请填写正确的身份证号码"];
        return;
    }
    
    if (![self.messageArray[2] isEqualToString:_verifyCode]) {
        [UIAlertView wariningWithTitle:@"验证码不正确"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"]          = @([NSUserDefaults getUserId]);
    parameters[@"education"]        = self.commonLoanApplyArr[0][0];
    parameters[@"marriage"]         = self.commonLoanApplyArr[0][1];
    parameters[@"credit"]           = self.commonLoanApplyArr[1][0];
    parameters[@"cart_front"]       = self.commonLoanApplyArr[2][0][0][0];
    parameters[@"cart_back"]        = self.commonLoanApplyArr[2][0][0][1];
    parameters[@"hand_front"]       = self.commonLoanApplyArr[2][0][1][0];
    parameters[@"hand_back"]        = self.commonLoanApplyArr[2][0][1][1];
    parameters[@"wages_img"]        = self.commonLoanApplyArr[2][1][0][0];
    parameters[@"credit_report"]    = self.commonLoanApplyArr[2][2][0][0];
    parameters[@"work_unit"]        = self.commonLoanApplyArr[3][0];
    parameters[@"work_address"]     = self.commonLoanApplyArr[3][1];
    parameters[@"work_tel"]         = self.commonLoanApplyArr[3][2];
    parameters[@"work_post"]        = self.commonLoanApplyArr[3][3];
    parameters[@"contacts_name"]    = self.commonLoanApplyArr[4][0];
    parameters[@"contacts_phone"]   = self.commonLoanApplyArr[4][1];
    parameters[@"contacts_address"] = self.commonLoanApplyArr[4][2];
    parameters[@"advance"]          = self.advanceArr[0];
    parameters[@"advance_number"]   = self.advanceArr[1];
    parameters[@"cart_number"]      = self.messageArray[0];
    parameters[@"phone"]            = self.messageArray[1];
    parameters[@"cost_id"]            = self.moneyID;
    
    NSLog(@"%@",parameters);

    [SVProgressHUD showWithStatus:@"正在提交中"];
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"commonLoan/submitApply"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"数据：%@",responseObject);
        [SVProgressHUD dismiss];
        if (CODE == 2) {
            [UIAlertView wariningWithTitle:@"申请提交成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [UIAlertView wariningWithTitle:@"申请提交失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        NSLog(@"错误信息%@",error);
        [UIAlertView wariningWithTitle:@"申请提交失败"];
    }];
}


-(void)changeText:(UITextField *)textField{
    // 通过textField获取 cell
    BBDCarPhoneVerifyCell *cell = (BBDCarPhoneVerifyCell*)[[textField superview] superview];
    
    // 通过cell获取 indexPath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.messageArray[indexPath.row] = textField.text;
    
    [self judgeFillMessageFinsh];
}

#pragma mark - 获取验证码
-(void)obtain:(UIButton*)btn{
    
    if(![NSString checkTel:self.messageArray[1]]){
        [UIAlertView wariningWithTitle:@"手机号不正确"];
        return;
        
    }
    
    [SVProgressHUD show];
    NSDictionary *parameters = @{@"phone":self.messageArray[1]};
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"verificationcode/phoneCode"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (CODE == 2) {
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功，请注意查收"];
//            [UIAlertView wariningWithTitle:responseObject[@"data"]];
            _verifyCode = responseObject[@"data"];
            [self obtainVerifyCode:btn];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
    
    
}

#pragma mark - 获取验证码  60S倒计时
-(void)obtainVerifyCode:(UIButton *)btn{
    
    BBDCarPhoneVerifyCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    __block int time = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                btn.enabled = YES;
                cell.textField.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                btn.enabled = NO;
                cell.textField.userInteractionEnabled = NO;
                NSString *strTime = [NSString stringWithFormat:@"%2d S",time];
                [btn setTitle:strTime forState:UIControlStateDisabled];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}


/** 判断信息是否全部填写 */
-(void)judgeFillMessageFinsh{
    
    // 筛选是否有未填写的内容，有就返回，若没有 “下一步”则打开
    
    NSLog(@"%@",self.messageArray);
    
    for (NSString *title in self.messageArray) {
        if (title.length<=0) {
            self.bottomButton.enabled = NO;
            return;
        }
    }
    
    self.bottomButton.enabled = YES;
}


@end
