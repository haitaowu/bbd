//
//  BBDCarPhoneVerifyCell.m
//  bbd
//
//  Created by Lei Xu on 2017/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCarPhoneVerifyCell.h"

@implementation BBDCarPhoneVerifyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}


-(void)initialize{
    
    self.backgroundColor = BASE_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textField = [[XLTextField alloc] init];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.textColor = [UIColor darkGrayColor];
    self.textField.font = [UIFont systemFontOfSize:14.0];
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.cornerRadius = 3.0;
    self.textField.layer.borderWidth  = 1.0f;
    self.textField.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:self.textField];
    
    
    
    
    self.obtainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.obtainButton.size =CGSizeMake(80, 40);
    [self.obtainButton setTitle:@"获取" forState:UIControlStateNormal];
    [self.obtainButton setTitleColor:GOLDEN_COLOR forState:UIControlStateNormal];
    [self.obtainButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [self.obtainButton setBackgroundImage:[UIImage imageNamed:@"apply_gain_bottom_icon"] forState:UIControlStateNormal];
    [self.obtainButton setBackgroundImage:[UIImage imageNamed:@"apply_gain_bottom_icon"] forState:UIControlStateDisabled];
    
    [self.obtainButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

    self.obtainButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    self.textField.rightView = self.obtainButton;
    
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];

}
@end
