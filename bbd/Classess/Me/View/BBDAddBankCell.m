//
//  BBDAddBankCell.m
//  bbd

/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */

//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDAddBankCell.h"

@implementation BBDAddBankCell

-(instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.text = title;
        self.nameLabel.font = [UIFont systemFontOfSize:13];
//        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.width.mas_equalTo(60);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.textField = [[UITextField alloc]init];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.font = [UIFont systemFontOfSize:13];
        [self.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(8);
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-8);
            make.bottom.mas_equalTo(-5);
        }];
        
    }
    return self;
}

-(void)textFieldChanged:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(addBankCellEdtingChanged:text:)]) {
        [self.delegate addBankCellEdtingChanged:self text:textField.text];
    }
}

@end
