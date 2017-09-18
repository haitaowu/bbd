//
//  BBDSelectMoneyView.h
//  bbd
//
//  Created by Mr.Wang on 2017/5/18.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBDSelectMoneyViewDelegate <NSObject>

-(void)type:(int)type number:(int)number;

@end

@interface BBDSelectMoneyView : UIView

@property (nonatomic,strong) UILabel * label;
@property (nonatomic,strong) UIButton * leftButton;
@property (nonatomic,strong) UIButton * rightButton;
@property (nonatomic,assign) int type;
@property (nonatomic,strong) NSArray * numberArray;
@property (nonatomic,weak) id<BBDSelectMoneyViewDelegate> delegate;

- (instancetype)initWithType:(int)type;

@end
