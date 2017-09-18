//
//  BBDYCTableViewCell.h
//  bbd
//
//  Created by Lei Xu on 2016/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TextFieldType = 0,
    OtherType = 1
}CellType;

@interface BBDYCTableViewCell : UITableViewCell

@property(nonatomic,assign)CellType cellType;


@end
