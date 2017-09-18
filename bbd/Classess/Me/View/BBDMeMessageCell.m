//
//  BBDMeMessageCell.m
//  bbd
//
//  Created by Mr.Wang on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMeMessageCell.h"
#import "BBDNetworkTool.h"

@implementation BBDMeMessageCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius = 5;
        
        self.messageImegeView = [[UIImageView alloc]init];
        [self addSubview:self.messageImegeView];
        
        [self.messageImegeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(8);
            make.height.width.mas_equalTo(28);
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.timeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-8);
            make.centerY.mas_equalTo(self.messageImegeView.mas_centerY);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.messageImegeView.mas_right).offset(8);
            make.centerY.mas_equalTo(self.messageImegeView.mas_centerY);
            make.right.mas_equalTo(self.timeLabel.mas_left).offset(-8);
        }];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        self.line.hidden = YES;
        [self addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageImegeView.mas_bottom).offset(8);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(1);
        }];
        
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.messageLabel];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(self.line.mas_bottom).offset(8);
            make.right.mas_equalTo(-8);
        }];
        
        self.unreadView = [[UIView alloc]init];
        self.unreadView.layer.cornerRadius = 2;
        self.unreadView.backgroundColor = [UIColor redColor];
        [self addSubview:self.unreadView];
        
        [self.unreadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_right).offset(-8);
            make.top.mas_equalTo(self.mas_top).offset(8);
            make.width.height.mas_equalTo(4);
        }];
    }
    return self;
}

-(void)setMessage:(BBDMessage *)message
{
    _message = message;
    
    self.unreadView.hidden = message.read_flag.intValue;
    
    if ([message.type isEqualToString:@"4"] || [message.type isEqualToString:@"5"]) {
        self.messageImegeView.image = [UIImage imageNamed:@"new_2_icon"];
    }else{
        self.messageImegeView.image = [UIImage imageNamed:@"new_1_icon"];
    }
    
    self.nameLabel.text = message.title;
    self.messageLabel.text = message.content;
    self.timeLabel.text = message.create_time;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width -= 10;
    frame.origin.x += 5;
    [super setFrame:frame];
}

@end
