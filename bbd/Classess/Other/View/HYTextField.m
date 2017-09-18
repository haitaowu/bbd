//
//  HYTextField.m
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "HYTextField.h"

@implementation HYTextField

- (instancetype)initWithLeftView:(UIView *)leftView withRightView:(UIView *)rightView withPlaceholder:(NSString *)placeholder withFontSize:(CGFloat)fontSize withBorderStyle:(UITextBorderStyle)borderStyle {
    
    self = [super init];
    if (self) {
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        [self setLeftView:leftView];
        [self setRightView:rightView];
        
        self.placeholder = placeholder;
        self.font = [UIFont systemFontOfSize:fontSize];
        self.borderStyle = borderStyle;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10; // leftView向右边偏10
    return iconRect;
}

@end
