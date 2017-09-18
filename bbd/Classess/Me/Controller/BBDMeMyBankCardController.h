//
//  BBDMeMyBankCardController.h
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
@class BBDBankCard;
@class BBDMeMyBankCardController;

@protocol BBDMeMyBankCardControllerDelegate <NSObject>

-(void)meMyBankCardController:(BBDMeMyBankCardController *)bankCardController didSelectBankCard:(NSString *)bankCard;

@end

@interface BBDMeMyBankCardController : UIViewController

@property (nonatomic,weak) id <BBDMeMyBankCardControllerDelegate> delegate;

@end
