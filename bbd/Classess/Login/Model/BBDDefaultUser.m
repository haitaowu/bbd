//
//  BBDUser.m
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDDefaultUser.h"

@implementation BBDDefaultUser

+ (void)loginWithTel:(NSString *)tel withPassword:(NSString *)password withFinished:(void (^)(NSInteger, NSError *))finished {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@login/login",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:tel forKey:@"phone"];
    [parameters setValue:password forKey:@"password"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *tmpDictionary = [responseObject valueForKey:@"data"];
        NSInteger user_id = [[tmpDictionary valueForKey:USER_ID_KEY] integerValue];
        
        // 保存
        [NSUserDefaults saveUserId:user_id];
        // 返回code
        finished([[responseObject valueForKey:@"code"] integerValue], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finished(-1, error);
    }];
}

+ (void)registerCodeWithTel:(NSString *)tel withFinished:(void (^)(NSDictionary *, NSError *))finished {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@verificationcode/phoneCodeByRegister",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:tel forKey:@"phone"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finished(responseObject , nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finished(nil, error);
    }];
}

+ (void)registerWithTel:(NSString *)tel withPassword:(NSString *)password withFinished:(void (^)(NSInteger, NSError *))finished {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@register/register",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:tel forKey:@"phone"];
    [parameters setValue:password forKey:@"password"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finished([[responseObject valueForKey:@"code"] integerValue] , nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finished(-1, error);
    }];
}

+ (void)alterPassWordCodeWithTel:(NSString *)tel withFinished:(void (^)(NSDictionary *, NSError *))finished {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@verificationcode/phoneCodeByFindPassword",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:tel forKey:@"phone"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finished(responseObject , nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finished(nil, error);
    }];
}

+ (void)alterPassWordWithTel:(NSString *)tel withNewPwd:(NSString *)newPwd withFinished:(void (^)(NSInteger, NSError *))finished {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@userinfo/editUserPassword",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:tel forKey:@"phone"];
    [parameters setValue:newPwd forKey:@"new_password"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finished([[responseObject valueForKey:@"code"] integerValue] , nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finished(-1, error);
    }];
}
@end
