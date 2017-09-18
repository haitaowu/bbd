//
//  BBDHomeApplyModel.h
//  bbd
//
//  Created by Lei Xu on 2017/1/6.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDHomeApplyModel : NSObject

/** 产品ID */
@property (nonatomic, assign) NSInteger product_id;

/** 申请条件 */
@property (nonatomic, copy) NSString *condition;

/** 申请流程图 */
@property (nonatomic, copy) NSString *flowchart_img;

/** 产品特点 */
@property (nonatomic, copy) NSString *feature;

/** 费用说明 */
@property (nonatomic, copy) NSString *des;

/** 准备材料 */
@property (nonatomic, copy) NSString *material;

@end

