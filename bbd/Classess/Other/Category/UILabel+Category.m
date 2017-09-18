//
//  UILabel+Category.m
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (instancetype)initWithTitle:(NSString *)title withFontSize:(CGFloat)size {

    self = [super init];
    if (self) {
        self.text = title;
        self.font = [UIFont systemFontOfSize:size];
        self.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end
