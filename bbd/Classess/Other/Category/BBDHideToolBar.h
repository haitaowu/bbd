//
//  BBDHideToolBar.h
//  bbd
//
//  Created by Lei Xu on 2017/1/7.
//  Copyright © 2017年 韩加宇. All rights reserved.
//
//  工具 --- 键盘添加隐藏按钮
//

#import <UIKit/UIKit.h>

@protocol KeyBoardHideDelegate <NSObject>

-(void)keyBoardHide;

@end

@interface BBDHideToolBar : UIToolbar

@property(nonatomic,weak) id<KeyBoardHideDelegate>delegate;

@end
