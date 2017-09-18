//
//  BBDApplyImageCell.h
//  bbd
//
//  Created by Mr.Wang on 17/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBDApplyItem;

@interface BBDApplyImageCell : UITableViewCell

@property (nonatomic,assign) int imageCount;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) NSArray * imageArray;

-(instancetype)initWithImageCount:(int)imageCount;

@end
