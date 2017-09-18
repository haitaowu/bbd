//
//  BBDHomeMainController.h
//  bbd
//
//  Created by Lei Xu on 2017/1/16.
//  Copyright © 2017年 韩加宇. All rights reserved.
//
//  主控制器， 首页 三种类型申请继承于这个

#import <UIKit/UIKit.h>
#import "BBDHideToolBar.h"


@interface BBDHomeMainController : UIViewController<UITableViewDelegate,UITableViewDataSource,KeyBoardHideDelegate>

@property(nonatomic,copy) UITableView *tableView;

@property(nonatomic,copy) UIButton *bottomButton;

@property(nonatomic,copy) BBDHideToolBar *hideToolBar;

/** 是否键盘通知 */
@property(nonatomic,assign) BOOL  keyboardNote;

@end
