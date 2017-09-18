//
//  BBDMyApplyCell.h
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBDApplyModel;

@interface BBDMyApplyCell : UITableViewCell

/**左边图片*/
@property (nonatomic,strong) UIImageView * kindImegeView;
/**贷款名称*/
@property (nonatomic,strong) UILabel * nameLabel;
/**创建时间*/
@property (nonatomic,strong) UILabel * timeLabel;
/**分隔线*/
@property (nonatomic,strong) UIView * line;
/**左边详情*/
@property (nonatomic,strong) UILabel * leftLabel;
/**右边详情*/
@property (nonatomic,strong) UILabel * rightLabel;
/**电话图标*/
@property (nonatomic,strong) UIImageView * phoneImage;

/**左边详情*/
@property (nonatomic,strong) UILabel * leftDetailLabel;
/**右边详情*/
@property (nonatomic,strong) UILabel * rightDetailLabel;

@property (nonatomic,strong) BBDApplyModel * model;

@end
