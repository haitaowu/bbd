//
//  BBDCommonLoanApplyModel.h
//  bbd
//
//  Created by Lei Xu on 2017/1/10.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Body;
@interface BBDCommonLoanApplyModel : NSObject

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<Body *> *body;


@end

@interface Body : NSObject

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *height;

@end

