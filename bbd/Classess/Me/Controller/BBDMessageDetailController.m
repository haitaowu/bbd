//
//  BBDMessageDetailController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMessageDetailController.h"
#import "BBDNetworkTool.h"

@interface BBDMessageDetailController ()

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation BBDMessageDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self loadData];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息详情";
    
    self.webView = [[UIWebView alloc]init];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
}

-(void)loadData
{
    [BBDNetworkTool getMessageDetailMessageId:self.message.message_id success:^(BBDMessage *message) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"messageClick" object:nil];
        self.message = message;
        [self.webView loadHTMLString:[NSString stringWithFormat:
                                      @"<!DOCTYPE html>\
                                      <html>\
                                      <head lang=\"en\">\
                                      <meta charset=\"UTF-8\" name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\
                                      <title></title>\
                                      <style>\
                                      h4{font-weight:normal;}\
                                      </style>\
                                      </head>\
                                      <body>\
                                      <h4 align=\"center\">%@</h4>\
                                      <h6 align=\"right\">%@</h6>\
                                      <p style=\"font-size:14px;\">%@</p>\
                                      </body>\
                                      </html>",
                                      self.message.title,self.message.create_time,self.message.content] baseURL:nil];
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
