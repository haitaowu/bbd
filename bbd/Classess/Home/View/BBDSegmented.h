//
//  BBDSegmented.h
//  bbd
//
//  Created by Lei Xu on 2017/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBDSegmented : UIControl

@property(nonatomic,strong) UIView *contentView;

@property(nonatomic,strong) NSArray *itmes;

/*
 * 选择button的Index
 */
@property(nonatomic,assign)NSInteger selectIndex;


/*
 * 设置contentView的约束
 */
@property(nonatomic,assign) UIEdgeInsets edgeInsets;



@end
