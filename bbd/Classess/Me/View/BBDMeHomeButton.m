//
//  BBDMeHomeButton.m
//  bbd

/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */

//  Created by Mr.Wang on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMeHomeButton.h"

@implementation BBDMeHomeButton

-(instancetype)initWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = GOLDEN_COLOR;
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        self.buttonLabel = [[UILabel alloc]init];
        self.buttonLabel.font = [UIFont systemFontOfSize:16];
        self.buttonLabel.textColor = GOLDEN_COLOR;
        [self addSubview:self.buttonLabel];
        
        [self.buttonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];
    }
    return self;
}

-(void)setDetailTitle:(NSString *)detailTitle
{
    _detailTitle = detailTitle;
    self.buttonLabel.text = detailTitle;
}

@end
