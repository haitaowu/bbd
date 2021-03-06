//
//  BBDDateInputView.h
//  bbd
//
//  Created by Mr.Wang on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBDDateInputView : UIView

@property (nonatomic,strong) void (^datePickBlock)(NSString * date);

@property (nonatomic,strong) UIDatePicker * picker;

@end
