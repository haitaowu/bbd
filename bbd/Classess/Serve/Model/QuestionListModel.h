//
//  QuestionListModel.h
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionListModel : NSObject
/**
 *  加载问题
 *
 *  @param type     类型 1：新手引导   2：安全保障问题    3：普通贷问题；
                        4：极速贷问题 5：还款问题  6：账户管理问题
 *  @param page     页数
 */
+ (void)loadQuestionListWithType:(NSInteger)type withPage:(NSInteger)page withFinished:(void (^)(NSArray *models, NSError *error))finished;

/// 问题正文
@property (nonatomic, copy) NSString *content;
/// 问题标题
@property (nonatomic, copy) NSString *title;
/// 图片
@property (nonatomic, copy) NSString *img;

@end
