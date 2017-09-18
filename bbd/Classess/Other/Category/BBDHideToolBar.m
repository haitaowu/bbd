//
//  BBDHideToolBar.m
//  bbd
//
//  Created by Lei Xu on 2017/1/7.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDHideToolBar.h"

@implementation BBDHideToolBar


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self initialize];
        
    }
    return self;
}


-(void)initialize{
    
    self.barStyle = UIBarStyleBlack;
    
    //  添加 隐藏BarButton
    UIBarButtonItem *hideBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"down_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)];
    
    // hideBarButton 渲染白色
    hideBarButton.tintColor = [UIColor whiteColor];
    
    // 添加space
    UIBarButtonItem * barButtonSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // 设置 items   |<-----barButtonSpace----->[hideBarButton]|
    self.items = @[barButtonSpace,hideBarButton];
}

/** 隐藏键盘 */ 
-(void)hideKeyboard{
    
    
    if ([self.delegate respondsToSelector:@selector(keyBoardHide)]) {
        [self.delegate keyBoardHide];
    }
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


@end
