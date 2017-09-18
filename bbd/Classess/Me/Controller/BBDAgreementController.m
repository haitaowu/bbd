//
//  BBDAgreementController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDAgreementController.h"
#import "BBDNetworkTool.h"

@interface BBDAgreementController ()

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation BBDAgreementController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.webView = [[UIWebView alloc]init];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
}

-(void)loadData
{
    [BBDNetworkTool getAgreement:^(BBDAbout *aggrement) {
        NSString * title;
        NSString * content;
        if (self.type == 1) {
            title = aggrement.user_agreement_title;
            content = aggrement.user_agreement;
        }else if (self.type == 2){
            title = aggrement.disclaimer_title;
            content = aggrement.disclaimer;
        }
        [self.webView loadHTMLString:[NSString stringWithFormat:
                                      @"<!DOCTYPE html>\
                                      <html>\
                                      <head lang=\"en\">\
                                      <meta charset=\"UTF-8\" name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\
                                      <title></title>\
                                      </head>\
                                      <body>\
                                      <h4 align=\"center\">%@</h4>\
                                      <p style=\"font-size:14px;\">%@</p>\
                                      </body>\
                                      </html>",
                                      title,content] baseURL:nil];
        
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
