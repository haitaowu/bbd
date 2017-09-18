//
//  BBDCommonLoanApplyTextFieldOtherCell.m
//  bbd
//
//  Created by Lei Xu on 2017/1/10.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCommonLoanApplyTextFieldOtherCell.h"

@implementation BBDCommonLoanApplyTextFieldOtherCell

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
    
    
    self.textField = [[UITextField alloc] init];
    self.textField.backgroundColor = BASE_COLOR;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:self.textField];
    
}



-(void)setupMasonary{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
}
@end
