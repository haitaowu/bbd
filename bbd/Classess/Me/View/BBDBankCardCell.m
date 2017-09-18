//
//  BBDBankCardCell.m
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

//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDBankCardCell.h"
#import "BBDNetworkTool.h"

@implementation BBDBankCardCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * background = [[UIView alloc]init];
        background.backgroundColor = [UIColor whiteColor];
        background.layer.cornerRadius = 5;
        [self addSubview:background];
        
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(-5);
        }];
        
//        self.bankImage = [[UIImageView alloc]init];
//        self.bankImage.image = [UIImage imageNamed:@"jianshe"];
//        [background addSubview:self.bankImage];
//        
//        [self.bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.mas_equalTo(8);
//            make.height.width.mas_equalTo(35);
//        }];
        
        UIView * line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [background addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(1);
        }];
        
        self.bankNameLabel = [[UILabel alloc]init];
        self.bankNameLabel.font = [UIFont systemFontOfSize:15];
        [background addSubview:self.bankNameLabel];
        
        [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(line.mas_centerY).offset(-20);
        }];
        
        self.bankNumberLabel = [[UILabel alloc]init];
        self.bankNumberLabel.font = [UIFont systemFontOfSize:12];
        [background addSubview:self.bankNumberLabel];
        
        [self.bankNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(line.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

-(void)setCard:(BBDBankCard *)card
{
    _card = card;
    self.bankNameLabel.text = card.card_type;
    self.bankNumberLabel.text = card.card_number;
}

@end
