//
//  XLNetworking.h
//  bbd
//
//  Created by Lei Xu on 2017/1/6.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    VideoFile = 0,
    PhotosFile = 1
}FileType;

@interface XLNetworking : NSObject
/*
 * xl_上传文件
 */
+(void)uploadFileData:(NSData*)data andFileType:(FileType)fileType progress:(void(^)(double progress))progress success:(void(^)(NSString *url,BOOL success))success;


@end
