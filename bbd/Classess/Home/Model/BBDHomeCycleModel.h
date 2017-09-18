//
//  BBDHomeCycleModel.h
//  bbd
//
//  Created by Lei Xu on 2017/1/6.
//  Copyright © 2017年 韩加宇. All rights reserved.
//
//  首页轮播图 Model

#import <Foundation/Foundation.h>

@interface BBDHomeCycleModel : NSObject

/** url */
@property(nonatomic,copy)NSString *url;

/** 图片 */
@property(nonatomic,copy)NSString *thumbnail_img;

/** id */
@property(nonatomic,copy)NSString *activity_id;

@end
