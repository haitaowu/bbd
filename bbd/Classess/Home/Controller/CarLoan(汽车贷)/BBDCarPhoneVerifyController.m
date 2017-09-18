//
//  BBDFastPhoneVerifyController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCarPhoneVerifyController.h"
#import "BBDCarPhoneVerifyCell.h"
#import "BBDCarPhoneVerifyOtherCell.h"
#import "UIAlertController+Category.h"
#import "UIAlertView+EXtension.h"
#import "NSString+CheckTel.h"
#import "BBDIDPictureView.h"
#import <SVProgressHUD.h>
#import "XLNetworking.h"


@interface BBDCarPhoneVerifyController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UIImagePickerController *imagePicker;
@property(nonatomic,weak) BBDIDPictureView *pictureView;

/** 验证码 */
@property(nonatomic,assign)NSString *verifyCode;

@property(nonatomic,strong) NSMutableArray *imageArray;

@property(nonatomic,strong) NSMutableArray *messageArray;


@end

@implementation BBDCarPhoneVerifyController

-(NSMutableArray *)imageArray{
    
    if (_imageArray == nil) {
        
        /**
         *   创建二维数组
         *   @[@[1,2],
         *     @[3,4]]
         */
        
        NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"",@"",nil];
        NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"",@"",nil];
        _imageArray = [NSMutableArray arrayWithObjects:array1,array2,nil];
        
    }
    
    return _imageArray;
}


-(NSMutableArray *)messageArray{
    if (_messageArray == nil) {
        _messageArray = [NSMutableArray arrayWithObjects:@"",self.imageArray,@"",@"",nil];
    }
    return _messageArray;
}


-(UIImagePickerController *)imagePicker{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@{@"image":@"home_tell_id_icon",
                   @"placeholder":@"身份证号"},
                 @{@"image":@"",
                   @"placeholder":@"身份证信息"},
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
    [self.tableView registerClass:[BBDCarPhoneVerifyOtherCell class] forCellReuseIdentifier:NSStringFromClass([BBDCarPhoneVerifyOtherCell class])];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row!=1) {
        BBDCarPhoneVerifyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCarPhoneVerifyCell class])];
        
        cell.textField.placeholder = _dataArr[indexPath.row][@"placeholder"];
        cell.textField.inputAccessoryView = self.hideToolBar;
        [cell.textField drawLeftView:_dataArr[indexPath.row][@"image"]];
        [cell.textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.row == 3) {
            cell.textField.rightViewMode = UITextFieldViewModeAlways;
            [cell.obtainButton addTarget:self action:@selector(obtain:) forControlEvents:UIControlEventTouchUpInside];
        }

        return cell;
    }else{
        BBDCarPhoneVerifyOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCarPhoneVerifyOtherCell class])];
        cell.titleLabel.text = _dataArr[indexPath.row][@"placeholder"];
        [cell.pictureView addTarget:self action:@selector(chooseIDPictrue:) forControlEvents:UIControlEventTouchUpInside];
        _pictureView = cell.pictureView;
        return cell;
    }
    

}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath.row==1? 200:60;
}

-(void)changeText:(UITextField *)textField{
    // 通过textField获取 cell
    BBDCarPhoneVerifyCell *cell = (BBDCarPhoneVerifyCell*)[[textField superview] superview];
    
    // 通过cell获取 indexPath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    
    NSLog(@"%ld",indexPath.row);
    
    self.messageArray[indexPath.row] = textField.text;
    
    [self judgeFillMessageFinsh];
}

#pragma mark - 提交申请
-(void)submit{
    
    if (![self.messageArray[3] isEqualToString:_verifyCode]) {
        [UIAlertView wariningWithTitle:@"验证码不正确"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"]          = @([NSUserDefaults getUserId]);
    parameters[@"car_type"]         = self.carLoanApplyArr[0];
    parameters[@"car_date"]         = self.carLoanApplyArr[1];
    parameters[@"car_model"]        = self.carLoanApplyArr[2];
    parameters[@"vin_number"]       = self.carLoanApplyArr[3];
    parameters[@"advance"]          = self.advanceArr[0];
    parameters[@"advance_number"]   = self.advanceArr[1];
    parameters[@"cart_number"]      = self.messageArray[0];
    parameters[@"cart_front"]       = self.messageArray[1][0][0];
    parameters[@"cart_back"]        = self.messageArray[1][0][1];
    parameters[@"hand_front"]       = self.messageArray[1][1][0];
    parameters[@"hand_back"]        = self.messageArray[1][1][1];
    parameters[@"phone"]            = self.messageArray[2];
    
    [SVProgressHUD showWithStatus:@"正在提交中"];
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"carLoan/submitApply"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
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

#pragma mark - 获取验证码
-(void)obtain:(UIButton*)btn{
    
    
    if(![NSString checkTel:self.messageArray[2]]){
        [UIAlertView wariningWithTitle:@"手机号不正确"];
        return;
        
    }
    
    [SVProgressHUD show];
    NSDictionary *parameters = @{@"phone":self.messageArray[2]};
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"verificationcode/phoneCode"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (CODE == 2) {
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功，请注意查收"];
            [UIAlertView wariningWithTitle:responseObject[@"data"]];
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
    
    BBDCarPhoneVerifyCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
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

-(void)chooseIDPictrue:(BBDIDPictureView*)view{
        
    UIAlertController *alert = [UIAlertController getImagePickerAlert:self.imagePicker withTarget:self];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_pictureView.selectBtn setBackgroundImage:image forState:UIControlStateNormal];
    NSData *imageData = UIImagePNGRepresentation(image) == nil?UIImageJPEGRepresentation(image, 1):UIImagePNGRepresentation(image);
    
    //  pictureView 选中的button复制给btn上传图片，并显示进度，防止因为线程问题导致selectBtn对应的信息错乱
    UIButton *btn = _pictureView.selectBtn;
    
    //  上传图片就将图片数组对应的index清除 (为重复上传做准备)
    self.imageArray[btn.tag/10-1][btn.tag%10-1] = @"";
    
    self.bottomButton.enabled = NO;
    
    [XLNetworking uploadFileData:imageData andFileType:PhotosFile progress:^(double progress) {
        
        // btn 显示上传进度
        [btn setTitle:[NSString stringWithFormat:@"%.0f%%",progress] forState:UIControlStateNormal];
        
    } success:^(NSString *url, BOOL success) {
        if (success) {
            
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            
            //  button的tag = (row+1*10)+(col+1) 从11开始，及对应第1行第1列
            self.imageArray[btn.tag/10-1][btn.tag%10-1] = url;
            
            // self.imageArray 有改变就判断信息是否全部填写
            [self judgeFillMessageFinsh];
            
        }else{
            [btn setTitle:@"上传失败" forState:UIControlStateNormal];
        }
    }];
}

/** 判断信息是否全部填写 */
-(void)judgeFillMessageFinsh{

    // 筛选是否有未填写的内容，有就返回，若没有 “下一步”则打开
    
    NSLog(@"%@",self.messageArray);
    
    for (int i = 0; i<self.messageArray.count; i++) {
        if (i == 1) {
            for (int j = 0; j<self.imageArray.count; j++) {
                for (NSString *title in self.imageArray[j]) {
                    if (title.length<=0) {
                        self.bottomButton.enabled = NO;
                        return;
                    }
                }
            }
        }else{
            if ([self.messageArray[i] length]<=0) {
                self.bottomButton.enabled = NO;
                return;
            }
        }
    }
    
    self.bottomButton.enabled = YES;
}

@end
