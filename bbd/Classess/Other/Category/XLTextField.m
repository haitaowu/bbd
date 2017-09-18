//
//  YCLoginTextField.m
//  YiCheng
//
//  Created by Lei Xu on 2016/11/15.
//  Copyright © 2016年 Rcoming. All rights reserved.
//

#import "XLTextField.h"

@implementation XLTextField


- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tintColor = [UIColor lightGrayColor];
    
}


// 设置UITextField左边视图
-(void)drawLeftView:(NSString*)imageString{

    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftImageView.image = [UIImage imageNamed:imageString];
    self.leftView = leftImageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)drawPlaceholderInRect:(CGRect)rect{
    
    CGRect frame = rect;
    frame.origin.y += 11;
    [self.placeholder drawInRect:frame
                  withAttributes:@{NSForegroundColorAttributeName :[UIColor lightGrayColor],
                                               NSFontAttributeName:self.font}];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10; // leftView向右边偏10
    return iconRect;
}

//-(CGRect)rightViewRectForBounds:(CGRect)bounds{
//    CGRect iconRect = [super rightViewRectForBounds:bounds];
//    iconRect.origin.x -= 10;  // rightView向左边偏10
//    return iconRect;
//}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 40, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 40, 0);
}


@end
