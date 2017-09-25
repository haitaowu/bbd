//
//  BBDSelectMoneyViewController.m
//  bbd
//
//  Created by Mr.Wang on 2017/5/18.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDSelectMoneyViewController.h"
#import "BBDSelectMoneyView.h"
#import "BBDNetworkTool.h"
#import <SVProgressHUD.h>
#import "BBDCommonLoanApplyController.h"
#import "BBDHomeAuthenTableViewController.h"

@interface BBDSelectMoneyViewController ()<BBDSelectMoneyViewDelegate>

@property (nonatomic,assign) int day;
@property (nonatomic,assign) int money;
@property (nonatomic,strong) NSMutableArray * labelArray;
@property (nonatomic,strong) UILabel * label;

@property (nonatomic,copy) NSString * moneyID;
@end

@implementation BBDSelectMoneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelArray = [NSMutableArray array];
    [self setupView];
}

-(void)setupView
{
    self.navigationItem.title = @"选择金额";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"select_money_background"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-120);
    }];
    
    BBDSelectMoneyView * moneyView = [[BBDSelectMoneyView alloc]initWithType:1];
    moneyView.delegate = self;
    moneyView.numberArray = @[@500,@1000];
    [self.view addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.right.mas_equalTo(imageView.mas_right).offset(-10);
        make.top.mas_equalTo(imageView.mas_top);
        make.height.mas_equalTo(imageView.mas_height).multipliedBy(0.3);
    }];
    
    BBDSelectMoneyView * dayView = [[BBDSelectMoneyView alloc]initWithType:2];
    dayView.delegate = self;
    dayView.numberArray = @[@7,@14];
    [self.view addSubview:dayView];
    [dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.right.mas_equalTo(imageView.mas_right).offset(-10);
        make.top.mas_equalTo(moneyView.mas_bottom);
        make.height.mas_equalTo(imageView.mas_height).multipliedBy(0.3);
    }];
    
    UIButton * selectButton = [[UIButton alloc]init];
    selectButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [selectButton setTitle:@"请选择优惠券" forState:UIControlStateNormal];
    [self.view addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(imageView.centerX);
        make.top.mas_equalTo(dayView.mas_bottom);
    }];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = GOLDEN_COLOR;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(10);
        make.right.mas_equalTo(imageView.mas_right).offset(-10);
        make.top.mas_equalTo(selectButton.mas_bottom);
        make.height.mas_equalTo(2);
    }];
    
    NSArray * array = @[@"快速信审费：0元",@"利息：0元",@"账户管理费：0元",@"优惠券：0元"];
    
    for (int i = 0; i < 4; i++) {
        UILabel * label = [[UILabel alloc]init];
        if (i%2==1) {
            label.textAlignment = NSTextAlignmentRight;
        }
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor lightGrayColor];
        [self.view addSubview:label];
        int row = i/2;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line).offset(20*row + 20);
            make.left.mas_equalTo(line.mas_left);
            make.right.mas_equalTo(line.mas_right);
        }];
        [self.labelArray addObject:label];
    }
    
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:22];
    self.label = label;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.top.mas_equalTo(line.mas_bottom).mas_offset(80);
    }];
    
    UIButton * button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"select_heightlight"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        make.bottom.mas_equalTo(-30);
    }];
}

-(void)type:(int)type number:(int)number;
{
    if (type == 1) {
        self.money = number;
    }else{
        self.day = number;
    }
    if (!(self.money&&self.day)) {
        return;
    }
    [SVProgressHUD showWithStatus:@"请稍后"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [BBDNetworkTool getMoneyRate:[NSString stringWithFormat:@"%d",self.money] days:[NSString stringWithFormat:@"%d",self.day] success:^(BBDMoney *money) {
        [SVProgressHUD dismiss];
        NSArray * array = @[[NSString stringWithFormat:@"快速信审费：%@元",money.check_fee],
                            [NSString stringWithFormat:@"利息：%@元",money.interest],
                            [NSString stringWithFormat:@"账户管理费：%@元",money.manage_fee],
                            [NSString stringWithFormat:@"优惠券：0元"]];
        for (int i = 0; i < 4; i++) {
            UILabel * label = self.labelArray[i];
            label.text = array[i];
        }
        self.moneyID = money.cost_id;
        
        NSString * replayMoney = [NSString stringWithFormat:@"到期应还：%@元",money.reply_money];
        NSMutableAttributedString *AreplayMoney=[[NSMutableAttributedString alloc] initWithString:replayMoney];
        NSRange range = [replayMoney rangeOfString:[NSString stringWithFormat:@"%@元",money.reply_money]];
        
        // 设置字体的颜色
        [AreplayMoney addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, range.location)];
        [AreplayMoney addAttribute:NSForegroundColorAttributeName value:GOLDEN_COLOR range:range];
        [AreplayMoney addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        [self.label setAttributedText:AreplayMoney];
        
    } failure:^{
        [SVProgressHUD dismiss];
    }];
}

-(void)buttonClick
{
    if (!(self.money&&self.day)) {
        return;
    }
    
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    BBDHomeAuthenTableViewController *controller = [homeStoryboard instantiateViewControllerWithIdentifier:@"BBDHomeAuthenTableViewController"];
    
//    BBDCommonLoanApplyController * vc = [[BBDCommonLoanApplyController alloc]init];
//    vc.moneyID = self.moneyID;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
