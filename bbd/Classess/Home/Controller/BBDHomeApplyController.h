//
//  BBDHomeApplyController.h
//  bbd
//
//  Created by Lei Xu on 2017/1/16.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDHomeMainController.h"

@interface BBDHomeApplyController : BBDHomeMainController

@property(nonatomic,copy) NSString *titleName;

/** 贷款类型 */
@property(nonatomic,assign)LoanType loanType;


@end
