//
//  BBDCommonLoanApplyPictureCell.h
//  bbd
//
//  Created by Lei Xu on 2017/1/10.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDIDPictureView.h"

@interface BBDCommonLoanApplyPictureCell : UITableViewCell
@property(nonatomic,strong) BBDIDPictureView *pictureView;

@property(nonatomic,strong) UILabel *detalLabel;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UIView *backView;

@end
