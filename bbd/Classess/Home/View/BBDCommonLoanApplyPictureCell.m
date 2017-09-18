//
//  BBDCommonLoanApplyPictureCell.m
//  bbd
//
//  Created by Lei Xu on 2017/1/10.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCommonLoanApplyPictureCell.h"

@implementation BBDCommonLoanApplyPictureCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentView.backgroundColor = BASE_COLOR;
    
    self.backView = [[UIView alloc] init];
    [self.contentView addSubview:self.backView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.titleLabel];
    
    
    self.pictureView = [[BBDIDPictureView alloc] init];

    [self.backView addSubview:self.pictureView];
    
    
    self.detalLabel = [[UILabel alloc] init];
    self.detalLabel.textColor = [UIColor grayColor];
    self.detalLabel.numberOfLines = 0;
    self.detalLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.detalLabel];
    
    
    CGSize size = [self.detalLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    
    [self.detalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(size.height);
        make.top.mas_equalTo(self.backView.mas_bottom).mas_offset(5);
        
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(0);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(90);
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.pictureView.mas_height);
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.detalLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    [self.detalLabel mas_updateConstraints:^(MASConstraintMaker *make) {

        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(size.height);
        make.top.mas_equalTo(self.backView.mas_bottom).mas_offset(5);
        
    }];
}

@end
