//
//  BBDQuestionDetailViewController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDQuestionDetailViewController.h"
#import <WebKit/WebKit.h>

@interface BBDQuestionDetailViewController ()

/// 网页浏览器
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation BBDQuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupUI];
    
    self.title = @"问题详情";
}
/**
 *  设置界面
 */
- (void)setupUI {

    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark -懒加载
- (WKWebView *)webView {

    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
        
        NSString *imageString = [[NSString alloc] init];
        NSArray *imageArray = [self.questionModel.img componentsSeparatedByString:@","];
        
        for (int i = 0; i < imageArray.count; i++) {
            NSString *tmpImg = [NSString stringWithFormat:@"<div><img style='max-width:100%%' src=\"%@\"></div>",imageArray[i]];
            imageString = [imageString stringByAppendingString:tmpImg];
        }
        
        [_webView loadHTMLString:[NSString stringWithFormat:
                                  @"<!DOCTYPE html>\
                                  <html>\
                                  <head lang=\"en\">\
                                  <meta charset=\"UTF-8\" name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\
                                  <title></title>\
                                  </head>\
                                  <body>\
                                  <h4 align=\"left\" style=\"word-wrap:break-word; word-break:normal;\">问题：%@</h4>\
                                  <p style=\"font-size:14px;word-wrap:break-word; word-break:normal;\">问题答案：%@</p>\
                                  %@\
                                  </body>\
                                  </html>",
                                  self.questionModel.title,self.questionModel.content,imageString]
                    baseURL:nil];
    }
    return _webView;
}
@end
