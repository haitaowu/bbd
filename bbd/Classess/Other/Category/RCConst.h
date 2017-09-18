//
//  RCConst.h
//  bbd
//
//  Created by Lei Xu on 2016/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCConst : NSObject
/*
 * 根API
 */
UIKIT_EXTERN NSString * const BASE_API;
/**
 *  USER_ID
 */
UIKIT_EXTERN NSString * const USER_ID_KEY;
/**
 *  IS_GESTURE
 */
UIKIT_EXTERN NSString * const IS_GESTURE_KEY;

typedef enum {
    
    FastLoan     = 0,   // 极速贷
    CarLoan      = 1,   // 汽车贷
    CommonLoan = 2    // 普通贷
    
}LoanType;

@end
