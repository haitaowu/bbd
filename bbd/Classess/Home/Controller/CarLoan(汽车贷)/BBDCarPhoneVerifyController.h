//
//  BBDFastPhoneVerifyController.h
//  bbd
//
//  Created by Lei Xu on 2017/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//


#import "BBDHomeMainController.h"

@interface BBDCarPhoneVerifyController : BBDHomeMainController

/*
 * 放款账号和类型
 * index = 0     0:支付宝, 1:银行卡
 * index = 1     对应的支付宝/银行卡号
 */
@property(nonatomic,copy) NSArray *advanceArr;

@property(nonatomic,copy) NSMutableArray *carLoanApplyArr;


@end
