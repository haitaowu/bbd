//
//  UIAlertView+EXtension.m
//  YiCheng
//
//  Created by Lei Xu on 2016/12/12.
//  Copyright © 2016年 Rcoming. All rights reserved.
//

#import "UIAlertView+EXtension.h"

@implementation UIAlertView (EXtension)
+(void)wariningWithTitle:(NSString *)title{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];    
}

@end
