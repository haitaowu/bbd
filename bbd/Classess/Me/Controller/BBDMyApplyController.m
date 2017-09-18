//
//  BBDMyApplyController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMyApplyController.h"
#import "BBDMyApplyTableViewController.h"
#import <SVProgressHUD.h>

@interface BBDMyApplyController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView * indicator;
@property (nonatomic,strong) NSMutableArray * buttonArray;
@property (nonatomic,weak) UIButton * lastButton;
@property (nonatomic,strong) UIView * titleView;

@end

@implementation BBDMyApplyController

-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"待审核",@"进行中",@"已放款"];
    }
    return _titleArray;
}

-(NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)setupView
{
    self.edgesForExtendedLayout = NO;
    self.navigationItem.title = @"我的申请";
    
    //添加子控制器
    for (int i = 0; i < self.titleArray.count; i++) {
        BBDMyApplyTableViewController * vc = [[BBDMyApplyTableViewController alloc]init];
        vc.type = i;
        [self addChildViewController:vc];
    }
    
    //顶部的titleView
    self.titleView = [[UIScrollView alloc]init];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    //添加顶部按钮
    CGFloat buttonW = SCREEN_WIDTH / 3;
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        NSString * title = self.titleArray[i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonW * i, 0, buttonW, 30)];
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:GOLDEN_COLOR forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:button];
        
        [self.buttonArray addObject:button];
        if (i==0) {
            button.selected = YES;
            self.lastButton = button;
        }
    }

    //分隔线
    self.indicator = [[UIView alloc]initWithFrame:CGRectMake(5, 28, buttonW -10, 2)];
    self.indicator.layer.cornerRadius = 1;
    self.indicator.backgroundColor = GOLDEN_COLOR;
    [self.titleView addSubview:self.indicator];
    
    //底部的View
    UIScrollView * scrollview=[[UIScrollView alloc]init];
    scrollview.width = SCREEN_WIDTH;
    scrollview.contentSize=CGSizeMake(scrollview.width * self.titleArray.count,0);
    scrollview.delegate=self;
    scrollview.pagingEnabled=YES;
    scrollview.bounces=NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollView=scrollview;
    [self scrollViewDidEndScrollingAnimation:scrollview];
    [self.view addSubview:scrollview];
    
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}
-(void)titleButtonClick:(UIButton *)button
{
    self.lastButton.selected = NO;
    button.selected = YES;
    self.lastButton = button;
    
    CGPoint piont=self.scrollView.contentOffset;
    piont.x=button.tag * self.scrollView.width;
    [self.scrollView setContentOffset:piont animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/scrollView.width;
    UIViewController * vc=self.childViewControllers[index];
    vc.view.height=self.scrollView.height;
    vc.view.y=0;
    vc.view.x=scrollView.contentOffset.x;
    
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    int index = scrollView.contentOffset.x/scrollView.width;
    
    for (UIButton * button in self.buttonArray) {
        if (button.tag==index) {
            [self titleButtonClick:button];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double offset = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    self.indicator.x= SCREEN_WIDTH /3 * offset + 5;
    
    int index = [self numberWithDouble:offset];
    
    for (UIButton * button in self.buttonArray) {
        button.selected = NO;
        if (button.tag==index) {
            button.selected = YES;
        }
    }
}

-(int)numberWithDouble:(double)index
{
    int A = index;
    double B = index - A;
    if (B<0.5) {
        return A;
    }else{
        return A + 1;
    }
}

@end
