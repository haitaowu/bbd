//
//  BBDApplyDetailHeadView.m
//  bbd
//
//  Created by Mr.Wang on 17/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDApplyDetailHeadView.h"

@implementation BBDApplyDetailHeadView

-(instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"home_extreme_arrow_icon"];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(15);
        }];
        
        UILabel * label = [[UILabel alloc]init];
        label.text = title;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(8);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
//        UIView * line1 = [[UIView alloc]init];
//        line1.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
//        [self addSubview:line1];
//        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.mas_equalTo(0);
//            make.height.mas_equalTo(1);
//        }];
        
        UIView * line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

@end
