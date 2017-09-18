//
//  NSUserDefaults+Extension.h
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

/** 保存userId */
+(void)saveUserId:(NSInteger)userId;

/** 获取userId */
+(NSInteger)getUserId;

/** 移除userId */
+(void)removeUserId;


/** 保存手势密码 */
+(void)saveIsGesture;

/** 是否有手势密码 */
+(BOOL)getIsGesture;

/** 移除手势密码 */
+(void)removeIsGesture;

@end
