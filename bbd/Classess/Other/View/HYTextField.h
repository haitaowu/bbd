//
//  HYTextField.h
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTextField : UITextField

- (instancetype)initWithLeftView:(UIView *)leftView withRightView:(UIView *)rightView withPlaceholder:(NSString *)placeholder withFontSize:(CGFloat)fontSize withBorderStyle:(UITextBorderStyle)textBorderStyle;

@end
