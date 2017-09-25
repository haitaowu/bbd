//
//  BBDAuthenIDTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDAuthenIDTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>

@interface BBDAuthenIDTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *confirmCell;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *idCardView;
@property (weak, nonatomic) IBOutlet UIButton *idCardUserView;

@property (nonatomic,strong)UIButton *currentPickView;

@end

@implementation BBDAuthenIDTableViewController
#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - selectors
//证件正面
- (IBAction)tapIDCardBtn:(UIButton*)sender
{
    self.currentPickView = _idCardView;
    [self pickImageByCamera];
}

//手持证件
- (IBAction)tapIDCardUserBtn:(UIButton*)sender
{
    self.currentPickView = _idCardUserView;
    [self pickImageByCamera];
}

#pragma mark - private methods
- (void)pickImageByCamera
{
    AVAuthorizationStatus authorStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    if (authorStatus == AVAuthorizationStatusDenied ||UIImagePickerControllerSourceTypeCamera == AVAuthorizationStatusNotDetermined) {
        NSString *message = @"宝贝快打开摄像头让我们拍照吧";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未获取授权使用相机" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }else{
        NSLog(@"相机 是可用的");
    }
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }else{
        NSLog(@"相机 是 不可用的");
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingImage");
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.currentPickView setBackgroundImage:image forState:UIControlStateNormal];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UITableView --- Table view  delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

@end
