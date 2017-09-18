//
//  BBDHomeDetailController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/12.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDHomeDetailController.h"
#import <SVProgressHUD.h>
#import <WebKit/WebKit.h>

@interface BBDHomeDetailController ()

@property (nonatomic, strong) WKWebView *webView;

@property (weak, nonatomic) CALayer *progresslayer;

@end

@implementation BBDHomeDetailController

-(WKWebView *)webView{
    if (_webView == nil) {
        
        _webView = [[WKWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
    }
    
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    self.urlStr.length>0?[self loadRequest]:[self loadData];
    
}


-(void)setupUI{
    self.navigationItem.title = @"活动详情";
    self.view.backgroundColor = BASE_COLOR;
    self.edgesForExtendedLayout = NO;
    
    UIBarButtonItem *leftBI = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_icon"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(backBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftBI;
    
    //添加属性监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 10, 3);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}


-(void)loadRequest{
    // 构建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    // 发起请求
    [self.webView loadRequest:request];
}


-(void)loadData{
    
    NSDictionary *parameters = @{@"activity_id":self.activityId};
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"home/getHomeIngContent"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (CODE == 2) {
        
            NSDictionary *data = responseObject[@"data"];
            [self.webView loadHTMLString:[NSString stringWithFormat:
                                          @"<!DOCTYPE html>\
                                          <html>\
                                          <head lang=\"en\">\
                                          <meta charset=\"UTF-8\" name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\
                                          </head>\
                                          <body>\
                                          <div><img style='max-width:100%%' src=\"%@\"></div>\
                                          <div style=\"font-size:14px\">%@<div>\
                                          </body>\
                                          </html>",data[@"img"],data[@"content"]]
                                 baseURL:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progresslayer.opacity = 0;
        });
    }];
}



/**
   webview加载进度条监听
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {

        self.progresslayer.opacity = 1;
        
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


/**
   返回
 */
-(void)backBarButtonItemClick{
    
    if (self.webView.canGoBack) {
        
        [self.webView goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/**
   销毁监听
 */
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
