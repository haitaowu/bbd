//
//  BBDServeViewController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDServeViewController.h"
#import "BBDQuestionListViewController.h"
#import "BBDCalculateViewController.h"
#import "YCMineProposalViewController.h"
#import "BBDLoginViewController.h"

@interface BBDServeViewController ()

/// 背景图
@property (nonatomic, strong) UIImageView *backGroudImageView;

@end

@implementation BBDServeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

/**
 *  设置界面
 */
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backGroudImageView];
    
    [self.backGroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-49);
    }];
    
    CGFloat buttonW = (SCREEN_WIDTH - 60) / 2;
    CGFloat buttonH = (SCREEN_HEIGHT - 200 - 49) / 4;
    CGFloat space = 18;
    NSInteger tag = 1;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 60)];
    imageView.image = [UIImage imageNamed:@"logo_icon"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0 ; j < 2; j++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(space + (j * buttonW) + (j * space), 160 + (i * buttonH) + (i * space), buttonW, buttonH)];
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"aide_%ld_icon",tag]] forState:UIControlStateNormal];
            button.tag = tag;
            tag ++;
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.backGroudImageView addSubview:button];
        }
    }
}
/**
 *  点击了按钮
 */
- (void)buttonClick:(UIButton *)sender {

    // 费率计算
    if (sender.tag == 7) {
        
        [self.navigationController pushViewController:[[BBDCalculateViewController alloc] init]animated:YES];
        return;
    }
    // 意见反馈
    if (sender.tag == 6) {
        
        [self.navigationController pushViewController:[[YCMineProposalViewController alloc] init]  animated:YES];
        return;
    }
    
    BBDQuestionListViewController *questionListViewController = [[BBDQuestionListViewController alloc] init];
    questionListViewController.type = sender.tag;
    [self.navigationController pushViewController:questionListViewController animated:YES];
}

#pragma mark -懒加载
- (UIImageView *)backGroudImageView {

    if (_backGroudImageView == nil) {
        _backGroudImageView = [[UIImageView alloc] init];
        _backGroudImageView.backgroundColor = RCColor(35, 31, 32);
        _backGroudImageView.userInteractionEnabled = YES;
    }
    return _backGroudImageView;
}

@end
