//
//  BBDMyApplyCell.m
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMyApplyCell.h"
#import "BBDNetworkTool.h"

#define image(name) [UIImage imageNamed:name]

@implementation BBDMyApplyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.kindImegeView = [[UIImageView alloc]init];
        [self addSubview:self.kindImegeView];
        
        [self.kindImegeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(8);
            make.height.width.mas_equalTo(28);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.kindImegeView.mas_right).offset(8);
            make.centerY.mas_equalTo(self.kindImegeView.mas_centerY);
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.timeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-8);
            make.centerY.mas_equalTo(self.kindImegeView.mas_centerY);
        }];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        self.line.hidden = YES;
        [self addSubview:self.line];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.kindImegeView.mas_bottom).offset(8);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(1);
        }];
        
        self.leftLabel = [[UILabel alloc]init];
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.leftLabel];
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.line.mas_bottom).offset(22);
            make.left.mas_equalTo(8);
        }];
        
        self.rightLabel = [[UILabel alloc]init];
        self.rightLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.rightLabel];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.leftLabel.mas_centerY);
            make.right.mas_equalTo(-8);
        }];
        
        self.phoneImage = [[UIImageView alloc]init];
        self.phoneImage.image = [UIImage imageNamed:@"apply_telephone_icon"];
        self.phoneImage.hidden = YES;
        [self addSubview:self.phoneImage];
        
        [self.phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightLabel.mas_left).offset(0);
            make.centerY.mas_equalTo(self.rightLabel.mas_centerY);
            make.width.height.mas_equalTo(28);
        }];
        
        self.leftDetailLabel = [[UILabel alloc]init];
        self.leftDetailLabel.font = [UIFont systemFontOfSize:14];
        self.leftDetailLabel.hidden = YES;
        [self addSubview:self.leftDetailLabel];
        
        [self.leftDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.leftLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(8);
        }];
        
        self.rightDetailLabel = [[UILabel alloc]init];
        self.rightDetailLabel.font = [UIFont systemFontOfSize:14];
        self.rightDetailLabel.hidden = YES;
        [self addSubview:self.rightDetailLabel];
        
        [self.rightDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.leftDetailLabel.mas_centerY);
            make.right.mas_equalTo(-8);
        }];
        
    }
    return self;
}

-(void)setModel:(BBDApplyModel *)model
{
    _model = model;
    
    self.timeLabel.text = model.create_time;
    
    // 区分图标、标题
    if (model.loan_type == 0) {
        self.nameLabel.text = @"汽车贷";
        self.kindImegeView.image = model.isDetail == 0 ? image(@"me_car_icon") : image(@"apply_car_icon");
    }else if (model.loan_type == 1){
        self.nameLabel.text = @"普通贷";
        self.kindImegeView.image = model.isDetail == 0 ? image(@"me_common_icon") : image(@"apply_common_icon");
    }else if (model.loan_type == 2){
        self.nameLabel.text = @"极速贷";
        self.kindImegeView.image = model.isDetail == 0 ? image(@"me_extreme_icon") : image(@"apply_extreme_icon");
    }
    
    // 区分是否显示的是详情中的界面，在详情中的界面要把提提设为蓝色
    if (model.isDetail == 1) {
        self.nameLabel.textColor = GOLDEN_COLOR;
        self.layer.cornerRadius = 0;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
        }];
    }
    
    // 进行中
    if (model.type == 1 && model.isDetail == 0) {
        
        self.line.hidden = NO;
        self.leftLabel.text = [NSString stringWithFormat:@"负责客户经理　%@",model.name];
        self.phoneImage.hidden = NO;
        self.rightLabel.text = [NSString stringWithFormat:@"%@",model.phone];
        self.rightLabel.textColor = RCColor(253, 148, 86);
        self.rightLabel.userInteractionEnabled = YES;
        [self.rightLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call)]];
        
    }
    // 已放款
    else if (model.type == 2 && model.isDetail == 0){
        
        self.line.hidden = NO;
        self.leftDetailLabel.hidden = NO;
        self.rightDetailLabel.hidden = NO;
        
        NSDictionary * attr = @{NSForegroundColorAttributeName:[UIColor redColor]};
        
        NSMutableAttributedString * loanDate = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"放款日期　%@",model.loan_date]];
//        [replayDate setAttributes:attr range:NSMakeRange(5, model.loan_date.length+1)];
        self.leftLabel.attributedText = loanDate;
        
        NSMutableAttributedString * loanMoney = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已放款　%@元",model.loan_money]];
//        [replayMoney setAttributes:attr range:NSMakeRange(4, model.loan_money.length+1)];
        self.rightLabel.attributedText = loanMoney;
        
        NSMutableAttributedString * replyDate = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"还款日期　%@",model.reply_date]];
        //        [replayDate setAttributes:attr range:NSMakeRange(5, model.loan_date.length+1)];
        self.leftDetailLabel.attributedText = replyDate;
        
        NSMutableAttributedString * replyMoney = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"应还金额　%@元",model.reply_money]];
        //        [replayMoney setAttributes:attr range:NSMakeRange(4, model.loan_money.length+1)];
        self.rightDetailLabel.attributedText = replyMoney;
        
    }
    
    [self setFrame:self.frame];
}

-(void)call
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"拨打：%@",self.model.phone] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.model.phone]]];
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:confirm];
    [alert addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(void)setFrame:(CGRect)frame
{
    if (!self.model.isDetail) {
        frame.origin.x+=5;
        frame.size.width-=10;
    }
    [super setFrame:frame];
}

@end

