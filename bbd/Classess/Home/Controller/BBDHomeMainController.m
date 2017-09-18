//
//  BBDHomeMainController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/16.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDHomeMainController.h"


@interface BBDHomeMainController ()

@end

@implementation BBDHomeMainController

-(BBDHideToolBar *)hideToolBar{
    if (_hideToolBar == nil) {
        _hideToolBar = [[BBDHideToolBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _hideToolBar.delegate = self;
    }
    return _hideToolBar;
}

-(UIButton *)bottomButton{
    if (_bottomButton == nil) {
        _bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(40, SCREEN_HEIGHT-115, SCREEN_WIDTH-80, 40)];
        [_bottomButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_bottomButton setBackgroundImage:[UIImage imageNamed:@"home_button_icon_click"] forState:UIControlStateNormal];
        [_bottomButton setBackgroundImage:[UIImage imageNamed:@"home_button_icon"] forState:UIControlStateDisabled];
        _bottomButton.enabled = NO;
        [self.view addSubview:_bottomButton];
    }
    return _bottomButton;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-125)];
        _tableView.backgroundColor = RCColor(225, 225, 223);
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = BASE_COLOR;

}


#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height-60, 0);

}


#pragma mark KeyBoardHideDelegate
-(void)keyBoardHide{
    self.tableView.contentInset = UIEdgeInsetsZero;

}

-(void)setKeyboardNote:(BOOL)keyboardNote{
    _keyboardNote = keyboardNote;
    if (keyboardNote == YES) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
}

@end
