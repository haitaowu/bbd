//
//  BBDHomeCell.m
//  bbd
//
//  Created by Lei Xu on 2016/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDHomeCell.h"

@implementation BBDHomeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
        [self setMasonry];
        
    }
    return self;
}

-(void)initialize
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = [UIColor darkGrayColor];
    
    
    self.leftImageView = [[UIImageView alloc] init];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.rightImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.rightImageView];
    
    
}

-(void)setMasonry{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(self.contentView.mas_height);
        make.width.mas_equalTo(self.leftImageView.mas_height).multipliedBy(0.6);
        
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.rightImageView.mas_height).multipliedBy(1.6);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(self.detailLabel.mas_top);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(self.titleLabel.mas_height);
    }];
    
    
    
}

-(void)setFrame:(CGRect)frame {
    
    frame.size.height -=10;
    [super setFrame:frame];
}

@end
