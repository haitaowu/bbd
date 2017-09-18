//
//  BBDNetworkTool.h
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BBDUser;
@class BBDBankCard;
@class BBDMessage;
@class BBDAbout;
@class BBDVersion;
@class BBDApplyDetail;
@class BBDApplyModel;
@class BBDUserInformation;
@class BBDMoney;

@interface BBDNetworkTool : NSObject

/**纯色图片*/
+(UIImage *)createImageWithColor:(UIColor *)color;

/**获取用户信息*/
+(void)getUserInformation:(void(^)(BBDUser * userInformation))success
                  failure:(void(^)())failure;

/**获取银行卡*/
+(void)getUserBankCard:(void(^)(NSArray * bankCardArray))success
               failure:(void(^)())failure;

/**添加银行卡*/
+(void)addBankCard:(NSString *)name
        cardNumber:(NSString *)cardNumber
         idCardNum:(NSString *)idCardNum
             phone:(NSString *)phone
           success:(void(^)())success
           failure:(void(^)())failure;

/**删除银行卡*/
+(void)deleteBankCard:(BBDBankCard *)bankCard
             canceled:(void(^)())canceled
              success:(void(^)())success
              failure:(void(^)())failure;

/**获取申请列表*/
+(void)getNochecking:(int)type
             success:(void(^)(NSArray * noChecking))success
             failure:(void(^)())failure;

/**获取消息列表*/
+(void)getMyMessagePage:(int)page
                success:(void(^)(NSArray * messageArray))success
                failure:(void(^)())failure;

/**获取消息详情*/
+(void)getMessageDetailMessageId:(NSInteger)messageId
                         success:(void(^)(BBDMessage * message))success
                         failure:(void(^)())failure;

/**获取免责声明*/
+(void)getAgreement:(void(^)(BBDAbout * aggrement))success
            failure:(void(^)())failure;

/**获取最新版本*/
+(void)getVersion:(void(^)(BBDVersion * version))success
          failure:(void(^)())failure;

/**上传图片*/
+(void)uploadImage:(UIImage *)image
           success:(void(^)(NSString * url))success
           failure:(void(^)())failure;

/**上传用户头像*/
+(void)setUserHeadImage:(NSString *)imageUrl
                success:(void(^)())success
                failure:(void(^)())failure;

/**获取申请详情*/
+(void)getApplyDetail:(BBDApplyModel *)apply
              success:(void(^)(BBDApplyDetail * detail))success
              failure:(void(^)())failure;

/**获取用户资料*/
+(void)getUserDataSuccess:(void(^)(BBDUserInformation * userInformation))success
                  failure:(void(^)())failure;

/**修改用户资料*/
+(void)setUserInformationNickname:(NSString *)nickName
                           idCard:(NSString *)idCard
                         birthday:(NSString *)birthday
                          address:(NSString *)address
                          success:(void(^)())success
                          failure:(void(^)())failure;

/**获取未读消息数量*/
+(void)getUnreadMessageCount:(void(^)(int messageCount))success
                     failure:(void(^)())failure;

/**获取客服电话*/
+(void)getTelephone:(void(^)(NSArray * telephone))success
            failure:(void(^)())failure;

/**修改用户资料*/
+(void)getMoneyRate:(NSString *)money
               days:(NSString *)days
            success:(void(^)(BBDMoney * money))success
            failure:(void(^)())failure;

@end

/**用户*/
@interface BBDUser : NSObject

/**昵称*/
@property (nonatomic, copy) NSString * nick_name;
/**头像*/
@property (nonatomic, copy) NSString * head_img;
/**银行卡数*/
@property (nonatomic, assign) NSInteger bankCard_count;
/**申请次数*/
@property (nonatomic, assign) NSInteger apply_count;
/**我的额度*/
@property (nonatomic, assign) NSInteger quota;

@end

/**用户资料*/
@interface BBDUserInformation : NSObject

/**手机号*/
@property (nonatomic, copy) NSString *phone;
/**地址*/
@property (nonatomic, copy) NSString *address;
/**昵称*/
@property (nonatomic, copy) NSString *nickname;
/**生日*/
@property (nonatomic, copy) NSString *birthday;
/**身份证号*/
@property (nonatomic, copy) NSString *cart_number;
/**手势密码*/
@property (nonatomic, copy) NSString *gesture;
/**密码*/
@property (nonatomic, copy) NSString *password;

+(NSString *)getKeyName:(NSString *)key;

@end

/**我的银行卡*/
@interface BBDBankCard : NSObject

/**手机号*/
@property (nonatomic, copy) NSString *phone;
/**卡类型*/
@property (nonatomic, copy) NSString *card_type;
/**银行卡号*/
@property (nonatomic, copy) NSString *card_number;
/**创建时间*/
@property (nonatomic, copy) NSString *create_time;
/**身份证号*/
@property (nonatomic, copy) NSString *cart_number;
/**持卡人姓名*/
@property (nonatomic, copy) NSString *name;
/**银行卡id*/
@property (nonatomic, assign) NSInteger bank_card_id;

@end

/**我的申请*/
@interface BBDApplyModel : NSObject

/**是否是详情界面*/
@property (nonatomic,assign) int isDetail;
/**0待审核，1进行中，2已放款*/
@property (nonatomic,assign) int type;
/**0汽车贷，1普通贷，2急速贷款*/
@property (nonatomic,assign) int loan_type;
/**申请ID*/
@property (nonatomic,assign) int id;
/**申请时间*/
@property (nonatomic,copy) NSString * create_time;

//进行中添加的属性
/**联系人电话*/
@property (nonatomic,copy) NSString * phone;
/**联系人姓名*/
@property (nonatomic,copy) NSString * name;

//已放款添加的属性
/**已放款*/
@property (nonatomic,copy) NSString * loan_money;
/**利率*/
@property (nonatomic,copy) NSString * loan_rate;
/**放款日期*/
@property (nonatomic,copy) NSString * loan_date;
/**应还金额*/
@property (nonatomic,copy) NSString * reply_money;
/**还款日期*/
@property (nonatomic,copy) NSString * reply_date;

@end

/**消息*/
@interface BBDMessage : NSObject

/**0：未读 1：已读*/
@property (nonatomic, copy) NSString *read_flag;
/**消息内容*/
@property (nonatomic, copy) NSString *content;
/**消息标题*/
@property (nonatomic, copy) NSString *title;
/**发送时间*/
@property (nonatomic, copy) NSString *create_time;
/**消息id*/
@property (nonatomic, assign) NSInteger message_id;
/**提醒类消息有1:已还款提醒、2:申请状态变更提醒、3:一般提醒
 通知类消息有4:反馈回复通知、5:一般通知*/
@property (nonatomic, copy) NSString *type;

@end

/**关于*/
@interface BBDAbout : NSObject

/**客服电话*/
@property (nonatomic,copy) NSString * service_tel;
/**用户协议标题*/
@property (nonatomic,copy) NSString * user_agreement_title;
/**用户协议*/
@property (nonatomic,copy) NSString * user_agreement;
/**免责声明标题*/
@property (nonatomic,copy) NSString * disclaimer_title;
/**免责声明*/
@property (nonatomic,copy) NSString * disclaimer;

@end

/**版本号*/
@interface BBDVersion : NSObject

/**版本id*/
@property (nonatomic, assign) NSInteger version_id;
/**说明*/
@property (nonatomic, copy) NSString *content;
/**下载路径*/
@property (nonatomic, copy) NSString *down_url;
/**创建时间*/
@property (nonatomic, copy) NSString *create_time;
/**版本编号*/
@property (nonatomic, copy) NSString *version_code;

@end

/**申请详情*/
@interface BBDApplyDetail : NSObject

/**真实姓名*/
@property (nonatomic,copy) NSString * name;
/**手机号*/
@property (nonatomic,copy) NSString * phone;
/**放款账号类型 0：支付宝 1：银行卡*/
@property (nonatomic,copy) NSString * advance;
/**放款账号*/
@property (nonatomic,copy) NSString * advance_number;
/**申请时间*/
@property (nonatomic,copy) NSString * create_time;
/**身份证正面*/
@property (nonatomic,copy) NSString * cart_front;
/**身份证背面*/
@property (nonatomic,copy) NSString * cart_back;
/**手持身份证正面*/
@property (nonatomic,copy) NSString * hand_front;
/**手持身份证背面*/
@property (nonatomic,copy) NSString * hand_back;
/**身份证图片*/
@property (nonatomic,copy) NSString * idCardNumber;
/**职位*/
@property (nonatomic,copy) NSString * work_post;
/**个人征信报告*/
@property (nonatomic,copy) NSString * credit_report;
/**工作单位*/
@property (nonatomic,copy) NSString * work_unit;
/**学历
 0：小学
 1：初中
 2：高中
 3：专科/本科以上*/
@property (nonatomic,copy) NSString * education;
/**婚姻状况 0：未婚 1：已婚*/
@property (nonatomic,copy) NSString * marriage;
/**座机号码*/
@property (nonatomic,copy) NSString * work_tel;
/**联系人手机号*/
@property (nonatomic,copy) NSString * contacts_phone;
/**单位地址*/
@property (nonatomic,copy) NSString * work_address;
/**工资流水信息*/
@property (nonatomic,copy) NSString * wages_img;
/**身份证号*/
@property (nonatomic,copy) NSString * cart_number;
/**联系人住址*/
@property (nonatomic,copy) NSString * contacts_address;
/**征信中心登录账号*/
@property (nonatomic,copy) NSString * credit;
/**联系人姓名*/
@property (nonatomic,copy) NSString * contacts_name;
/**车性质 0：全款车 1：贷款车*/
@property (nonatomic,copy) NSString * car_type;
/**车年份*/
@property (nonatomic,copy) NSString * car_date;
/**车架号*/
@property (nonatomic,copy) NSString * vin_number;
/**车型*/
@property (nonatomic,copy) NSString * car_model;
/**生日*/
@property (nonatomic,copy) NSString * birthday;
/**居住*/
@property (nonatomic,copy) NSString * address;
/**身份证地址*/
@property (nonatomic,copy) NSString * cart_address;
/**银行卡号*/
@property (nonatomic,copy) NSString * bank_no;
/**支付宝账号*/
@property (nonatomic,copy) NSString * alipay_account;
/**淘宝账号*/
@property (nonatomic,copy) NSString * taobao_account;


+(NSString *)getKeyName:(NSString *)key;

@end

@interface BBDMoney : NSObject

/**费用ID*/
@property (nonatomic,copy) NSString * cost_id;
/**借款金额*/
@property (nonatomic,copy) NSString * loan_money;
/**借款时长*/
@property (nonatomic,copy) NSString * days;
/**快速信审费*/
@property (nonatomic,copy) NSString * check_fee;
/**利息*/
@property (nonatomic,copy) NSString * interest;
/**账户管理费*/
@property (nonatomic,copy) NSString * manage_fee;
/**应还金额*/
@property (nonatomic,copy) NSString * reply_money;

@end
