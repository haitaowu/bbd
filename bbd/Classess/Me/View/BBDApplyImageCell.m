//
//  BBDApplyImageCell.m
//  bbd
//
//  Created by Mr.Wang on 17/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDApplyImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface BBDApplyImageCell ()

@property (nonatomic,strong) NSMutableArray * imageViewArray;

@property (nonatomic,assign) CGRect imageFrame;

@end

@implementation BBDApplyImageCell

-(NSMutableArray *)imageViewArray
{
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

-(instancetype)initWithImageCount:(int)imageCount
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat imageW = SCREEN_WIDTH /4;
        CGFloat imageH = imageW * 0.75;
        
        for (int i = 0; i < imageCount; i++) {
            
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            imageView.layer.borderWidth = 0.3;
            imageView.image = [UIImage imageNamed:@"video_picture_icon"];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage:)]];
            [self addSubview:imageView];
            
            int row = i/2;
            int line = i%2;
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(120 + line * (imageW + 10));
                make.top.mas_equalTo(8 + row * (imageH + 8));
                make.width.mas_equalTo(imageW);
                make.height.mas_equalTo(imageH);
            }];
            
            [self.imageViewArray addObject:imageView];
        }
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(self.mas_top).offset(8+imageH/2);
        }];
    }
    return self;
}


-(void)setImageArray:(NSArray *)imageArray
{
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView * imageView = self.imageViewArray[i];
        NSString * imageUrl = imageArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"video_picture_icon"]];
    }
}

//查看大图
-(void)seeBigImage:(UIGestureRecognizer *)gestureRecognizer
{
    UIImageView * imageView = self.imageViewArray[gestureRecognizer.view.tag];
    self.imageFrame = [self convertRect:imageView.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    
    UIImageView * bigImageView = [[UIImageView alloc]initWithFrame:self.imageFrame];
    bigImageView.image = imageView.image;
    bigImageView.backgroundColor = [UIColor blackColor];
    bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    bigImageView.userInteractionEnabled = YES;
    [bigImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitImage:)]];
    [bigImageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)]];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:bigImageView];
    
    [UIView animateWithDuration:0.2 animations:^{
        bigImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

//退出查看大图
-(void)exitImage:(UIGestureRecognizer *)gestureRecognizer
{
    UIImageView * imageView = (UIImageView *)gestureRecognizer.view;
    [UIView animateWithDuration:0.2 animations:^{
        imageView.frame = self.imageFrame;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

/**保存相册*/
-(void)saveImage:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageView * imageView = (UIImageView *)gestureRecognizer.view;
            UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:confirm];
        [alert addAction:cancel];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
}

/**保存相册*/
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
