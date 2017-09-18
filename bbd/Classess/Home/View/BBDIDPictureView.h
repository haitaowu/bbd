//
//  BBDIDPictureView.h
//  bbd
//
//  Created by Lei Xu on 2016/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBDIDPictureView : UIControl

typedef struct {
    long row;  // 行数
    long col;  // 列数
}BtnIndex;

@property(nonatomic,strong) UIView *contentView;


/*
 * textLabel的约束。 
 * edgeInsets.top 相对于contentView.bottom的约束
 * 其余都是相对于superView的约束
 */
@property(nonatomic,assign)UIEdgeInsets edgeInsets;

@property(nonatomic,strong) NSArray *items;

@property(nonatomic,strong) UIButton *selectBtn;

/*
 * 被选中item的行数和列数
 */
@property(nonatomic,assign) BtnIndex btnIndex;

@property(nonatomic,strong) UILabel *textLabel;


@end
