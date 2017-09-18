//
//  BBDYCTableViewCell.m
//  bbd
//
//  Created by Lei Xu on 2016/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDYCTableViewCell.h"

@implementation BBDYCTableViewCell

-(void)layoutSubviews{
    [super layoutSubviews];
        
    if (self.cellType == OtherType) {
        
        self.textLabel.y = 20;
    }
    self.imageView.size = CGSizeMake(20, 20);
    self.imageView.centerY = self.textLabel.centerY;
    
}


@end
