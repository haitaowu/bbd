//
//  BBDMeHomeButton.h
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

@interface BBDMeHomeButton : UIView

/**下方按钮的文字*/
@property (nonatomic,strong) NSString * detailTitle;
/**上方标题*/
@property (nonatomic,strong) UILabel * titleLabel;
/**按钮标题*/
@property (nonatomic,strong) UILabel * buttonLabel;


-(instancetype)initWithTarget:(id)target action:(SEL)action title:(NSString *)title;

@end
