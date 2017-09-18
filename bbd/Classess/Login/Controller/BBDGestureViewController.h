//
//  BBDGestureViewController.h
//  bbd
//
//  Created by 韩加宇 on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AliPayViews.h"
#import "KeychainData.h"

@interface BBDGestureViewController : UIViewController

typedef void (^GestureViewControllerBlock) ();

/// 手势类型
@property (nonatomic, assign) GestureModel gestureStyle;
/// block
@property (nonatomic, copy) GestureViewControllerBlock block;

/// 其他方式登录
@property (nonatomic, strong) UIButton *otherButton;
/// 手势密码
@property (nonatomic, strong) AliPayViews *alipay;

@end
