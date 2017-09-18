//
//  BBDCommonLoanApplySectionView.m
//  bbd
//
//  Created by Lei Xu on 2017/1/10.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCommonLoanApplySectionView.h"

@implementation BBDCommonLoanApplySectionView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initialize];
        [self setupMasonary];
    }
    
    return self;
}


-(void)initialize{
    
    
    self.titleLabe = [[UILabel alloc] init];
    self.titleLabe.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleLabe];
    
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = [UIColor grayColor];
    [self addSubview:self.detailLabel];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    
    
    
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = BASE_COLOR;
    [self addSubview:self.line];
}


-(void)setupMasonary{
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.line.mas_top);
        make.width.mas_equalTo(7);
    }];
    
    
    [self.titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.line.mas_top);
        make.width.mas_equalTo(80);
    }];
    
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabe.mas_right).mas_offset(5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.line.mas_top);
        make.right.mas_equalTo(0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(0);
    }];
}

@end
