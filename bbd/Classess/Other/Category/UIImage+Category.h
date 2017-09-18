//
//  UIImage+Category.h
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/**
 *  用颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor*)color;

+(instancetype) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;

@end
