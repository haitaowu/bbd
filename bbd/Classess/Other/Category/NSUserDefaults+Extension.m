//
//  NSUserDefaults+Extension.m
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)

#pragma 保存UserId
+(void)saveUserId:(NSInteger)userId{
    [[self standardUserDefaults] setInteger:userId forKey:USER_ID_KEY];
}

#pragma 获取UserId
+(NSInteger)getUserId{
    return [[self standardUserDefaults] integerForKey:USER_ID_KEY];
}

#pragma 移除UserId
+(void)removeUserId{
    [[self standardUserDefaults] removeObjectForKey:USER_ID_KEY];
}


+ (void)saveIsGesture {

    [[self standardUserDefaults] setBool:YES forKey:IS_GESTURE_KEY];
}

+ (BOOL)getIsGesture {

    return [[self standardUserDefaults] boolForKey:IS_GESTURE_KEY];
}

+ (void)removeIsGesture {

    [[self standardUserDefaults] setBool:NO forKey:IS_GESTURE_KEY];
}
@end
