//
//  BBDHomeApplyOtherCell.m
//  bbd
//
//  Created by Lei Xu on 2017/1/6.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDHomeApplyOtherCell.h"

@implementation BBDHomeApplyOtherCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
        [self setMasonry];
        
    }
    
    return self;
}


-(void)initialize{
    
    self.contentView.backgroundColor = BASE_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.detailImageView];

    self.indexImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_extreme_arrow_icon"]];
    self.indexImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.indexImageView];
    
    
    
}

-(void)setMasonry{
    
    
    [self.indexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.indexImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(-10);
        
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    
    
    
}

@end
