//
//  BBDDateInputView.m
//  bbd
//
//  Created by Mr.Wang on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDDateInputView.h"

@implementation BBDDateInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * backView = [[UIView alloc]init];
        [self addSubview:backView];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(SCREEN_WIDTH * 0.1);
        }];
        
        self.picker = [[UIDatePicker alloc]init];
        self.picker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:self.picker];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(backView.mas_bottom);
        }];
        
        UIButton * button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(confirmButtolClick) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:RCColor(40, 158, 255) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [backView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(backView.mas_centerY);
        }];
    }
    return self;
}

-(void)confirmButtolClick
{
    NSDateFormatter * formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"yyyy-MM-dd";
    self.datePickBlock([formate stringFromDate:self.picker.date]);
}

@end
