//
//  BBDMeHomeTableViewHeaderView.h
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

//  Created by Mr.Wang on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBDMeHomeButton;

@interface BBDMeHomeTableViewHeaderView : UIView

/**背景图*/
@property (nonatomic,strong) UIImageView * backgroundView;
/**头像*/
@property (nonatomic,strong) UIImageView * headImageView;
/**昵称*/
@property (nonatomic,strong) UILabel * nameLabel;
/**底部灰色的View*/
@property (nonatomic,strong) UIView * bottonView;
/**我的额度*/
@property (nonatomic,strong) BBDMeHomeButton * buttonLimit;
/**我的银行卡*/
@property (nonatomic,strong) BBDMeHomeButton * buttonBankCard;
/**我的申请*/
@property (nonatomic,strong) BBDMeHomeButton * buttonApply;

- (instancetype)initWithTarget:(id)target;

-(void)loadData;

@end
