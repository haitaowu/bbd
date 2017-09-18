//
//  NSString+CheckTel.h
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckTel)
/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
+ (BOOL)checkTel:(NSString *)mobile;
@end
