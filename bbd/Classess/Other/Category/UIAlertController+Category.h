//
//  UIAlertController+Category.h
//  GreenBuilding
//
//  Created by 韩加宇 on 16/11/8.
//  Copyright © 2016年 rcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Category)

+ (instancetype)getImagePickerAlert:(UIImagePickerController *)imagePicker withTarget:(id)target;

@end
