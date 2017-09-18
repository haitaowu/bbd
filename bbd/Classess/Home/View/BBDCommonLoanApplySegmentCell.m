//
//  BBDCommonLoanApplySegmentCell.m
//  bbd
//
//  Created by Lei Xu on 2017/1/10.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCommonLoanApplySegmentCell.h"

@implementation BBDCommonLoanApplySegmentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initialize];
        [self setupMasonary];
        
    }
    
    return self;
}


-(void)initialize{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.titleLabel];
    
    
    self.segmented = [[BBDSegmented alloc] init];
    [self.contentView addSubview:self.segmented];
    
}


-(void)setupMasonary{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(2);
        make.width.mas_equalTo(70);
    }];
    
    
    [self.segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
}

@end
