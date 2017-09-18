//
//  BBDMyMessageController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMyMessageController.h"
#import "BBDNetworkTool.h"
#import "BBDMeMessageCell.h"
#import "BBDMessageDetailController.h"
#import <MJRefresh.h>

@interface BBDMyMessageController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) int page;

@end

@implementation BBDMyMessageController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self.tableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"messageClick" object:nil];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的消息";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)loadData
{
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [BBDNetworkTool getMyMessagePage:self.page success:^(NSArray *messageArray) {
        self.dataArray = [NSMutableArray arrayWithArray:messageArray];
        [self.tableView reloadData];
        self.page++;
        
        if (self.dataArray.count <10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^{
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadMoreData
{
    [BBDNetworkTool getMyMessagePage:self.page success:^(NSArray *messageArray) {
        for (BBDMessage * message in messageArray) {
            [self.dataArray addObject:message];
        }
        [self.tableView reloadData];
        self.page++;
        
        [self.tableView.mj_footer endRefreshing];
        if (messageArray.count <10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^{
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDMeMessageCell * cell = [[BBDMeMessageCell alloc]init];
    BBDMessage * message = self.dataArray[indexPath.section];
    cell.message = message;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBDMessageDetailController * vc = [[BBDMessageDetailController alloc]init];
    BBDMessage * message = self.dataArray[indexPath.section];
    vc.message = message;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
