//
//  BBDSelectMoneyView.m
//  bbd
//
//  Created by Mr.Wang on 2017/5/18.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDSelectMoneyView.h"

@implementation BBDSelectMoneyView

- (instancetype)initWithType:(int)type
{
    self = [super init];
    if (self) {
        
        self.type = type;
        
        self.label = [[UILabel alloc]init];
        self.label.textColor = [UIColor lightGrayColor];
        self.label.font = [UIFont systemFontOfSize:16];
        if (self.type == 1) {
            self.label.text = @"选择借款金额";
        }else{
             self.label.text = @"选择借款时长";
        }
        
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(20);
        }];
        
        self.leftButton = [[UIButton alloc]init];
        [self.leftButton setAdjustsImageWhenHighlighted:NO];
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"select_normal"] forState:UIControlStateNormal];
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"select_heightlight"] forState:UIControlStateSelected];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftButton];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.mas_centerX).offset(-15);
            make.top.mas_equalTo(self.label.mas_bottom).offset(20);
            make.height.mas_equalTo(54);
        }];
        
        self.rightButton = [[UIButton alloc]init];
        [self.rightButton setAdjustsImageWhenHighlighted:NO];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"select_normal"] forState:UIControlStateNormal];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"select_heightlight"] forState:UIControlStateSelected];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(self.mas_centerX).offset(15);
            make.top.mas_equalTo(self.label.mas_bottom).offset(20);
            make.height.mas_equalTo(54);
        }];
        
    }
    return self;
}

-(void)buttonClick:(UIButton *)button
{
    if (button == self.leftButton) {
        self.leftButton.selected = YES;
        self.rightButton.selected = NO;
    }else{
        self.leftButton.selected = NO;
        self.rightButton.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(type:number:)]) {
        [self.delegate type:self.type number:(int)button.tag];
    }
}

-(void)setNumberArray:(NSArray *)numberArray
{
    _numberArray = numberArray;
    
    self.leftButton.tag = [numberArray[0] intValue];
    self.rightButton.tag = [numberArray[1] intValue];
    
    if (self.type == 1) {
        [self.leftButton setTitle:[NSString stringWithFormat:@"%d元",[numberArray[0] intValue]] forState:UIControlStateNormal];
        [self.rightButton setTitle:[NSString stringWithFormat:@"%d元",[numberArray[1] intValue]] forState:UIControlStateNormal];
    }else{
        [self.leftButton setTitle:[NSString stringWithFormat:@"%d天",[numberArray[0] intValue]] forState:UIControlStateNormal];
        [self.rightButton setTitle:[NSString stringWithFormat:@"%d天",[numberArray[1] intValue]] forState:UIControlStateNormal];
    }
}

@end
