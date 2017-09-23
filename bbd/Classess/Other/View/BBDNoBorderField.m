//
//  BBDNoBorderField.m
//  bbd
//
//  Created by taotao on 2017/9/23.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDNoBorderField.h"

@implementation BBDNoBorderField
- (void)awakeFromNib{
    [super awakeFromNib];
    self.borderStyle = UITextBorderStyleNone;
}

@end
