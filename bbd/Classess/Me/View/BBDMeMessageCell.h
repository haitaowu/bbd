//
//  BBDMeMessageCell.h
//  bbd
//
//  Created by Mr.Wang on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBDMessage;

@interface BBDMeMessageCell : UITableViewCell
/**左边图片*/
@property (nonatomic,strong) UIImageView * messageImegeView;
/**贷款名称*/
@property (nonatomic,strong) UILabel * nameLabel;
/**创建时间*/
@property (nonatomic,strong) UILabel * timeLabel;
/**分隔线*/
@property (nonatomic,strong) UIView * line;
/**创建时间*/
@property (nonatomic,strong) UILabel * messageLabel;
/**未读标识*/
@property (nonatomic,strong) UIView * unreadView;

@property (nonatomic,strong) BBDMessage * message;

@end
