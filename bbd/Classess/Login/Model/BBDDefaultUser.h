//
//  BBDUser.h
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDDefaultUser : NSObject
/**
 *  登录
 *
 *  @param tel      手机号
 *  @param password 密码
 */
+ (void)loginWithTel:(NSString *)tel withPassword:(NSString *)password withFinished:(void (^)(NSInteger code, NSError *error))finished;
/**
 *  获取注册验证码
 *
 *  @param tel      电话
 */
+ (void)registerCodeWithTel:(NSString *)tel withFinished:(void (^)(NSDictionary *responseDictionary, NSError *error))finished;
/**
 *  注册
 *
 *  @param tel      手机号
 *  @param password 密码
 */
+ (void)registerWithTel:(NSString *)tel withPassword:(NSString *)password withFinished:(void (^)(NSInteger code, NSError *error))finished;
/**
 *  获取修改密码验证码
 *
 *  @param tel      电话
 */
+ (void)alterPassWordCodeWithTel:(NSString *)tel withFinished:(void (^)(NSDictionary *responseDictionary, NSError *error))finished;
/**
 *  修改密码
 *
 *  @param tel      手机号
 *  @param newPwd   新密码
 */
+ (void)alterPassWordWithTel:(NSString *)tel withNewPwd:(NSString *)newPwd withFinished:(void (^)(NSInteger code, NSError *error))finished;

@end
