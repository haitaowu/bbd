//
//  XLNetworking.m
//  bbd
//
//  Created by Lei Xu on 2017/1/6.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "XLNetworking.h"

@implementation XLNetworking

+(void)uploadFileData:(NSData *)data andFileType:(FileType)fileType progress:(void (^)(double))progress success:(void (^)(NSString *, BOOL))success{
    [[AFHTTPSessionManager manager] POST:[BASE_API stringByAppendingString:@"upload/uploadFile"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (fileType == VideoFile) {
            // 添加上传视频
            [formData appendPartWithFileData:data name:@"file" fileName:@"video.mov" mimeType:@"video/mov"];
        }else{
            // 添加上传图片
            [formData appendPartWithFileData:data name:@"file" fileName:@"image.png" mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 显示上传进度
        dispatch_async(dispatch_get_main_queue(), ^{
            double pro=100*uploadProgress.fractionCompleted;
            progress(pro);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([responseObject[@"code"] integerValue] == 2) {
                success(responseObject[@"data"],YES);
                
            }else{
                
                success(responseObject[@"data"],NO);
                
            }
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(nil,NO);
        });
    }];
    
    
}

@end
