//
//  BBDNextView.m
//  bbd
//
//  Created by Lei Xu on 2016/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDNextView.h"

@implementation BBDNextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        [self setMasonry];
    }
    return self;
}


-(void)initialize{
    
    self.lastBtn = [[UIButton alloc] init];
    [self.lastBtn setTitle:@"上一个" forState:UIControlStateNormal];
    self.lastBtn.layer.masksToBounds = YES;
    self.lastBtn.layer.cornerRadius = 5;
    self.lastBtn.layer.borderWidth = 1;
    self.lastBtn.layer.borderColor = GOLDEN_COLOR.CGColor;
    [self.lastBtn setTitleColor:GOLDEN_COLOR forState:UIControlStateNormal];
    [self.lastBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.lastBtn addTarget:self action:@selector(even:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn = [[UIButton alloc] init];
    [self.nextBtn setTitle:@"下一个" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"home_button_icon_click"] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"home_button_icon"] forState:UIControlStateDisabled];
    self.nextBtn.enabled = NO;
    [self.nextBtn addTarget:self action:@selector(even:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [self addSubview:self.lastBtn];
    [self addSubview:self.nextBtn];
    
}

-(void)setMasonry{
    
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(self.nextBtn.mas_left).mas_offset(-30);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.lastBtn.centerY);
        make.height.mas_equalTo(self.lastBtn.mas_height);
        make.width.mas_equalTo(self.lastBtn.mas_width);
        make.right.mas_equalTo(-30);
    }];
    
    
    
}



-(void)even:(UIButton*)btn{
    if ([btn isEqual:self.lastBtn]) {
        self.selectIndex = 1;
    }else if([btn isEqual:self.nextBtn]){
        self.selectIndex = 2;
    }

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.selectIndex = 0;
}


@end
