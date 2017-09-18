//
//  BBDHomeApplyCell.m
//  bbd
//
//  Created by Lei Xu on 2016/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDHomeApplyCell.h"

@implementation BBDHomeApplyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
        [self setMasonry];
        
    }
    
    return self;
}


-(void)initialize{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = BASE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = [UIColor darkGrayColor];
    self.detailLabel.numberOfLines = 0;
    
    self.indexImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_extreme_arrow_icon"]];
    self.indexImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.indexImageView];
    
}

-(void)setMasonry{
    
    [self.indexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(35);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.indexImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(-10);
        
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
}


-(void)setFrame:(CGRect)frame{
    
    frame.origin.y += 1;
    frame.size.height -=1;
    
    [super setFrame:frame];
}
@end
