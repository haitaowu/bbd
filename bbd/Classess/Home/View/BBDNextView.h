//
//  BBDNextView.h
//  bbd
//
//  Created by Lei Xu on 2016/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBDNextView : UIControl

@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) UIButton *nextBtn;

/**
    点击按钮的index
    0 --- 没有点击任何按钮
    1 --- 点击了<上一个>按钮lastBtn
    2 --- 点击了<下一个>按钮nextBtn
 */
@property(nonatomic,assign)NSInteger selectIndex;

@end
