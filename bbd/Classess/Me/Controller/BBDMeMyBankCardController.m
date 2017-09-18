//
//  BBDMeMyBankCardController.m
//  bbd

/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */

//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMeMyBankCardController.h"
#import "BBDNetworkTool.h"
#import "BBDBankCardCell.h"
#import "BBDAddBankCardController.h"
#import "SVProgressHUD.h"

@interface BBDMeMyBankCardController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation BBDMeMyBankCardController

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的银行卡";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"me_bank_plus_icon"] style:0 target:self action:@selector(addBankCard)];
}

-(void)loadData
{
    [BBDNetworkTool getUserBankCard:^(NSArray *bankCardArray) {
        self.dataSource = [NSMutableArray arrayWithArray:bankCardArray];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDBankCardCell * cell = [[BBDBankCardCell alloc]init];
    BBDBankCard * card = self.dataSource[indexPath.section];
    cell.card = card;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView reloadData];
        BBDBankCard * bankCard = self.dataSource[indexPath.section];
        [BBDNetworkTool deleteBankCard:bankCard canceled:^{
            
        } success:^{
            [self loadData];
        } failure:^{
            
        }];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(meMyBankCardController:didSelectBankCard:)]) {
        BBDBankCard * bankCard = self.dataSource[indexPath.section];
        [self.delegate meMyBankCardController:self didSelectBankCard:bankCard.card_number];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)addBankCard
{
    BBDAddBankCardController * vc = [[BBDAddBankCardController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
