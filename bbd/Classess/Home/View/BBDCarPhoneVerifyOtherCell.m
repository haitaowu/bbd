//
//  BBDCarPhoneVerifyOtherCell.m
//  bbd
//
//  Created by Lei Xu on 2017/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCarPhoneVerifyOtherCell.h"


@implementation BBDCarPhoneVerifyOtherCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentView.backgroundColor = BASE_COLOR;
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 3.0;
    backView.layer.borderWidth  = 1.0f;
    backView.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    
    [self.contentView addSubview:backView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.text = @"身份证信息";
    [backView addSubview:self.titleLabel];
    
    
    self.pictureView = [[BBDIDPictureView alloc] init];
    self.pictureView.items = @[@[@"home_apply_id1_icon",@"home_apply_id2_icon"],
                               @[@"home_apply_id3_icon",@"home_apply_id4_icon"]];
    
    [backView addSubview:self.pictureView];
    
    
    self.detalLabel = [[UILabel alloc] init];
    self.detalLabel.textColor = [UIColor grayColor];
    self.detalLabel.numberOfLines = 0;
    self.detalLabel.font = [UIFont systemFontOfSize:12];
    self.detalLabel.text = @"提醒：身份证上的所有信息清晰可见；照片需免冠，手持证件人的五官清晰可见；照片内容真实有效，不得做任何修改；支持jpg,jpge,png格式照片,大小不超过5M";
    [self.contentView addSubview:self.detalLabel];
    
    
    CGSize size = [self.detalLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    
    
    [self.detalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(size.height);
        make.top.mas_equalTo(backView.mas_bottom).mas_offset(5);

    }];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(0);

    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.pictureView.mas_height);
    }];
    
    
    
    
    
    
}

@end
