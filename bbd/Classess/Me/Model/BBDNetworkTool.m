//
//  BBDNetworkTool.m
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDNetworkTool.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "NSUserDefaults+Extension.h"
#import "MBProgressHUD+MJ.h"

#define userId [NSString stringWithFormat:@"%d",(int)[NSUserDefaults getUserId]]

@implementation BBDNetworkTool

/**纯色图片*/
+(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 500, 500);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(void)GET:(NSString *)path parameters:(NSMutableDictionary *)parameters progressHud:(BOOL)progressHud success:(void(^)(id responseObject))success failure:(void(^)())failure
{
    if (progressHud) {
        [SVProgressHUD show];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@%@",BASE_API,path] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        if (CODE == 2) {
            success(responseObject);
        }else{
            failure();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        failure();
    }];
}

/**获取用户信息*/
+(void)getUserInformation:(void(^)(BBDUser * userInformation))success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    
    [self GET:@"personal/getUserInformation" parameters:parameters progressHud:NO success:^(id responseObject) {
        BBDUser * user = [BBDUser mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(user);
    } failure:^{
        failure();
    }];
}

/**获取银行卡*/
+(void)getUserBankCard:(void(^)(NSArray * bankCardArray))success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    
    [self GET:@"bankcard/getMyCardBank" parameters:parameters progressHud:YES success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray * array = [BBDBankCard mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        success(array);
    } failure:^{
        failure();
    }];
}

/**添加银行卡*/
+(void)addBankCard:(NSString *)name cardNumber:(NSString *)cardNumber idCardNum:(NSString *)idCardNum phone:(NSString *)phone success:(void(^)())success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    [parameters setObject:name forKey:@"name"];
    [parameters setObject:cardNumber forKey:@"card_number"];
    [parameters setObject:idCardNum forKey:@"cart_number"];
    [parameters setObject:phone forKey:@"phone"];
    
    [self GET:@"bankcard/addBankCard" parameters:parameters progressHud:YES success:^(id responseObject) {
        success();
    } failure:^{
        failure();
    }];
}

/**删除银行卡*/
+(void)deleteBankCard:(BBDBankCard *)bankCard canceled:(void(^)())canceled success:(void(^)())success failure:(void(^)())failure
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确定删除该银行卡？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:userId forKey:@"user_id"];
        [parameters setObject:@(bankCard.bank_card_id) forKey:@"bank_card_id"];
        
        [self GET:@"bankcard/deleteBankCard" parameters:parameters progressHud:YES success:^(id responseObject) {
            success();
        } failure:^{
            failure();
        }];
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        canceled();
    }];
    
    [alert addAction:confirm];
    [alert addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

/**获取申请列表*/
+(void)getNochecking:(int)type success:(void(^)(NSArray * noChecking))success failure:(void(^)())failure
{
    NSArray * pathArray = @[@"check/showUserNoCheck",
                            @"check/showUserIsCheck",
                            @"check/showUserHasCheck"];
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    
    [self GET:pathArray[type] parameters:parameters progressHud:YES success:^(id responseObject) {
        NSArray * array = [BBDApplyModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        for (BBDApplyModel * model in array) {
            model.type = type;
        }
        success(array);
    } failure:^{
        failure();
    }];
}

/**获取消息列表*/
+(void)getMyMessagePage:(int)page success:(void(^)(NSArray * messageArray))success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    [parameters setObject:@(page) forKey:@"page"];
    
    [self GET:@"message/getUserMessage" parameters:parameters progressHud:NO success:^(id responseObject) {
        NSArray * array = [BBDMessage mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        success(array);
    } failure:^{
        failure();
    }];
}

/**获取消息详情*/
+(void)getMessageDetailMessageId:(NSInteger)messageId success:(void(^)(BBDMessage * message))success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@(messageId) forKey:@"message_id"];
    
    [self GET:@"message/getMessageDetail" parameters:parameters progressHud:YES success:^(id responseObject) {
        BBDMessage * message = [BBDMessage mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(message);
    } failure:^{
        failure();
    }];
}

/**获取免责声明*/
+(void)getAgreement:(void(^)(BBDAbout * aggrement))success failure:(void(^)())failure
{
    [self GET:@"system/getSystemInformation" parameters:nil progressHud:YES success:^(id responseObject) {
        BBDAbout * about = [BBDAbout mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(about);
    } failure:^{
        failure();
    }];
}

/**获取最新版本*/
+(void)getVersion:(void(^)(BBDVersion * version))success failure:(void(^)())failure
{
    [self GET:@"system/getIosVersion" parameters:nil progressHud:YES success:^(id responseObject) {
        BBDVersion * version = [BBDVersion mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(version);
    } failure:^{
        failure();
    }];
}

/**上传用户头像*/
+(void)setUserHeadImage:(NSString *)imageUrl success:(void(^)())success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:imageUrl forKey:@"head_img"];
    [parameters setObject:userId forKey:@"user_id"];
    
    [self GET:@"personal/saveUerHeadImg" parameters:parameters progressHud:YES success:^(id responseObject) {
        success();
    } failure:^{
        failure();
    }];
}

/**获取申请详情*/
+(void)getApplyDetail:(BBDApplyModel *)apply success:(void(^)(BBDApplyDetail * detail))success failure:(void(^)())failure
{
    NSArray * pathArray = @[@"carLoan/showCarLoan",
                            @"commonLoan/showCommonLoan",
                            @"speedLoan/showSpeedLoan"];
    NSArray * paraStrArray = @[@"carloan_id",
                               @"commonloan_id",
                               @"speedloan_id"];
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@(apply.id) forKey:paraStrArray[apply.loan_type]];
    [parameters setObject:userId forKey:@"user_id"];
    
    [self GET:pathArray[apply.loan_type] parameters:parameters progressHud:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        BBDApplyDetail * detail = [BBDApplyDetail mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(detail);
    } failure:^{
        failure();
    }];
}

/**获取用户资料*/
+(void)getUserDataSuccess:(void(^)(BBDUserInformation * userInformation))success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    
    [self GET:@"userinfo/getUserInformation" parameters:parameters progressHud:NO success:^(id responseObject) {
        BBDUserInformation * information = [BBDUserInformation mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(information);
    } failure:^{
        failure();
    }];
}

/**修改用户资料*/
+(void)setUserInformationNickname:(NSString *)nickName idCard:(NSString *)idCard birthday:(NSString *)birthday address:(NSString *)address success:(void(^)())success failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"user_id"];
    [parameters setObject:nickName forKey:@"nickname"];
    [parameters setObject:idCard forKey:@"cart_number"];
    [parameters setObject:birthday forKey:@"birthday"];
    [parameters setObject:address forKey:@"address"];
    
    [self GET:@"userinfo/editUserinfo" parameters:parameters progressHud:YES success:^(id responseObject) {
        success();
    } failure:^{
        failure();
    }];
}

/**获取未读消息数量*/
+(void)getUnreadMessageCount:(void(^)(int messageCount))success
                     failure:(void(^)())failure
{
    [self getMyMessagePage:1 success:^(NSArray *messageArray) {
        int messageCount = 0;
        for (BBDMessage * message in messageArray) {
            if ([message.read_flag isEqualToString:@"0"]) {
                messageCount++;
            }
        }
        success(messageCount);
    } failure:^{
        failure();
    }];
}

/**获取客服电话*/
+(void)getTelephone:(void(^)(NSArray * telephone))success
            failure:(void(^)())failure
{
    [self getAgreement:^(BBDAbout *aggrement) {
        
        NSArray *array = [aggrement.service_tel componentsSeparatedByString:@","];
        success(array);
    } failure:^{
        failure();
    }];
}

/**修改用户资料*/
+(void)getMoneyRate:(NSString *)money
               days:(NSString *)days
            success:(void(^)(BBDMoney * money))success
            failure:(void(^)())failure
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:money forKey:@"loan_money"];
    [parameters setObject:days forKey:@"days"];
    [self GET:@"cost/getByMoneyAndDays" parameters:parameters progressHud:NO success:^(id responseObject) {
        BBDMoney * money = [BBDMoney mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        success(money);
    } failure:^{
        failure();
    }];
}

/**上传图片*/
+(void)uploadImage:(UIImage *)image success:(void(^)(NSString * url))success failure:(void(^)())failure
{
    MBProgressHUD * hud = [MBProgressHUD showMessage:@"正在上传图片" toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * path = [NSString stringWithFormat:@"%@upload/uploadFile",BASE_API];
    
    [manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"image.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        double pro=100 * uploadProgress.fractionCompleted;
        hud.detailsLabelText=[NSString stringWithFormat:@"%d%@",(int)pro,@"%"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hide:YES];
        if (CODE == 2) {
            NSString * url = [responseObject objectForKey:@"data"];
            NSLog(@"%@",url);
            success(url);
        }else{
            failure(@"");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        failure(@"");
    }];
}

@end

@implementation BBDUserInformation

+(NSString *)getKeyName:(NSString *)key
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"地址" forKey:@"address"];
    [dic setObject:@"昵称" forKey:@"nickname"];
    [dic setObject:@"生日" forKey:@"birthday"];
    [dic setObject:@"密码" forKey:@"password"];
    [dic setObject:@"手机号" forKey:@"phone"];
    [dic setObject:@"身份证号" forKey:@"cart_number"];
    [dic setObject:@"手势密码" forKey:@"gesture"];
    
    return [dic objectForKey:key];
}

@end

@implementation BBDApplyDetail

+(NSString *)getKeyName:(NSString *)key
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"" forKey:@"advance_number"];
    [dic setObject:@"学历" forKey:@"education"];
    [dic setObject:@"年份" forKey:@"car_date"];
    [dic setObject:@"车架号" forKey:@"vin_number"];
    [dic setObject:@"手机号" forKey:@"phone"];
    [dic setObject:@"银行卡" forKey:@"bank_no"];
    [dic setObject:@"淘宝账号" forKey:@"taobao_account"];
    [dic setObject:@"真实姓名" forKey:@"name"];
    [dic setObject:@"婚姻状况" forKey:@"marriage"];
    [dic setObject:@"身份证号" forKey:@"cart_number"];
    [dic setObject:@"工作单位" forKey:@"work_unit"];
    [dic setObject:@"单位地址" forKey:@"work_address"];
    [dic setObject:@"座机号码" forKey:@"work_tel"];
    [dic setObject:@"工作岗位" forKey:@"work_post"];
    [dic setObject:@"工作岗位" forKey:@"work_post"];
    [dic setObject:@"汽车性质" forKey:@"car_type"];
    [dic setObject:@"身份证信息" forKey:@"idCardNumber"];
    [dic setObject:@"出生年月日" forKey:@"birthday"];
    [dic setObject:@"联系人姓名" forKey:@"contacts_name"];
    [dic setObject:@"实际居住地" forKey:@"address"];
    [dic setObject:@"身份证地址" forKey:@"cart_address"];
    [dic setObject:@"支付宝账号" forKey:@"alipay_account"];
    [dic setObject:@"联系人住址" forKey:@"contacts_address"];
    [dic setObject:@"工资流水信息" forKey:@"wages_img"];
    [dic setObject:@"个人征信报告" forKey:@"credit_report"];
    [dic setObject:@"联系人手机号" forKey:@"contacts_phone"];
    [dic setObject:@"人民银行征信中心登录账号" forKey:@"credit"];
    
    return [dic objectForKey:key];
}

-(NSString *)education
{
    NSArray * array = @[@"小学",@"初中",@"高中",@"专科/本科以上"];
    NSString * text = array[_education.intValue];
    return text;
}

-(NSString *)car_type
{
    NSArray * array = @[@"全款车",@"贷款车"];
    NSString * text = array[_car_type.intValue];
    return text;
}

-(NSString *)marriage
{
    NSArray * array = @[@"未婚",@"已婚"];
    NSString * text = array[_marriage.intValue];
    return text;
}

@end

@implementation BBDUser

@end

@implementation BBDBankCard

@end

@implementation BBDApplyModel

@end

@implementation BBDMessage

@end

@implementation BBDAbout

@end

@implementation BBDVersion

@end

@implementation BBDMoney

@end
