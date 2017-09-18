//
//  QuestionListModel.m
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "QuestionListModel.h"

@implementation QuestionListModel

+ (void)loadQuestionListWithType:(NSInteger)type withPage:(NSInteger)page withFinished:(void (^)(NSArray *, NSError *))finished {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"%@question/getQuestion",BASE_API];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@(type) forKey:@"type"];
    [parameters setValue:@(page) forKey:@"page"];
    
    [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *tmpArray = [responseObject valueForKey:@"data"];
        NSArray *models = [QuestionListModel mj_objectArrayWithKeyValuesArray:tmpArray];
        
        finished(models, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finished(nil, error);
    }];
}

@end
