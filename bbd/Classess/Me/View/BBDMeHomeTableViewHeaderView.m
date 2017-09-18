//
//  BBDMeHomeTableViewHeaderView.m
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

#import "BBDMeHomeTableViewHeaderView.h"
#import "BBDMeHomeButton.h"
#import "BBDMeViewController.h"
#import "BBDNetworkTool.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BBDMeHomeTableViewHeaderView

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        
        self.backgroundView = [[UIImageView alloc]init];
        self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundView.image = [UIImage imageNamed:@"me_title_icon"];
        [self addSubview:self.backgroundView];
        
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
        
        self.bottonView = [[UIView alloc]init];
        self.bottonView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0];
        [self addSubview:self.bottonView];
        
        [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textColor = GOLDEN_COLOR;
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.bottonView.mas_top).offset(-20);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.image = [UIImage imageNamed:@"me_head_icon"];
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 30;
        self.headImageView.userInteractionEnabled = YES;
        [self addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.nameLabel.mas_top).offset(-15);
            make.width.height.mas_equalTo(60);
        }];
        
        CGFloat buttonW = SCREEN_WIDTH / 3;
        
        self.buttonLimit = [[BBDMeHomeButton alloc]initWithTarget:target action:@selector(myLimit) title:@"我的额度"];
        [self.bottonView addSubview:self.buttonLimit];
        
        [self.buttonLimit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(buttonW);
        }];
        
        self.buttonBankCard = [[BBDMeHomeButton alloc]initWithTarget:target action:@selector(myBankCard) title:@"我的银行卡"];
        [self.bottonView addSubview:self.buttonBankCard];
        
        [self.buttonBankCard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonLimit.mas_right);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(buttonW);
        }];
        
        self.buttonApply = [[BBDMeHomeButton alloc]initWithTarget:target action:@selector(myApply) title:@"我的申请"];
        [self.bottonView addSubview:self.buttonApply];
        
        [self.buttonApply mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonBankCard.mas_right);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(buttonW);
        }];
        
        UIView * line1 = [[UIView alloc]init];
        line1.backgroundColor = GOLDEN_COLOR;
        [self.bottonView addSubview:line1];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.buttonLimit.mas_right);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(1);
        }];
        
        UIView * line2 = [[UIView alloc]init];
        line2.backgroundColor = GOLDEN_COLOR;
        [self.bottonView addSubview:line2];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonApply.mas_left);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(1);
        }];
    }
    return self;
}

-(void)loadData
{
    [BBDNetworkTool getUserInformation:^(BBDUser *userInformation) {
        
        self.nameLabel.text = userInformation.nick_name;
        self.buttonLimit.detailTitle = [NSString stringWithFormat:@"%ld元",(long)userInformation.quota];
        self.buttonBankCard.detailTitle = [NSString stringWithFormat:@"%ld张",(long)userInformation.bankCard_count];
        self.buttonApply.detailTitle = [NSString stringWithFormat:@"%ld条",(long)userInformation.apply_count];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userInformation.head_img] placeholderImage:[UIImage imageNamed:@"me_head_icon"]];
        
    } failure:^{
        
    }];
}

@end
