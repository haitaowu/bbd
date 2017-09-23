//
//  BBDConnectViewController.h
//  bbd
//
//  Created by Mr.Wang on 2017/5/23.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectContactBlock)(NSString *phoneNum);

@interface BBDConnectViewController : UIViewController
@property (nonatomic,copy) SelectContactBlock selectBlock;

@property (nonatomic,strong) NSArray * dataArray;

@end
