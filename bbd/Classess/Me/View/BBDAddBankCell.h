//
//  BBDAddBankCell.h
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

#import <UIKit/UIKit.h>
@class BBDAddBankCell;

@protocol BBDAddBankCellDelegate <NSObject>

-(void)addBankCellEdtingChanged:(BBDAddBankCell *)cell text:(NSString *)text;

@end

@interface BBDAddBankCell : UITableViewCell

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UITextField * textField;

@property (nonatomic,weak) id <BBDAddBankCellDelegate> delegate;

-(instancetype)initWithTitle:(NSString *)title;

@end
