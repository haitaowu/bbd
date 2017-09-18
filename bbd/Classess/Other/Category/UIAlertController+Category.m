//
//  UIAlertController+Category.m
//  GreenBuilding
//
//  Created by 韩加宇 on 16/11/8.
//  Copyright © 2016年 rcoming. All rights reserved.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)
+ (instancetype)getImagePickerAlert:(UIImagePickerController *)imagePicker withTarget:(id)target {

    // 创建UIAlertController
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    
    // 判断是否支持相机。注：模拟器没有相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [target presentViewController:imagePicker animated:YES completion:^{}];
        }];
        
        [alert addAction:defaultAction];
    }
    
    // 设置按钮
    UIAlertAction * choosePhoto = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置图片源
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        // 跳转
        [target presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    // 设置按钮
    UIAlertAction * cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //  添加按钮
    [alert addAction:choosePhoto];
    [alert addAction:cancel];
    
    return alert;
}
@end
