//
//  BBDMyApplyTableViewController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDMyApplyTableViewController.h"
#import "BBDMyApplyCell.h"
#import "BBDNetworkTool.h"
#import "BBDApplyDetailController.h"

@interface BBDMyApplyTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * dataArray;

@end

@implementation BBDMyApplyTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self loadData];
}

-(void)loadData
{
    [BBDNetworkTool getNochecking:self.type success:^(NSArray *noChecking) {
        self.dataArray = noChecking;
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (self.type == 0) {
        return 44;
    }else if (self.type == 1){
        return 88;
    }else{
        return 108;
    }
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
    BBDMyApplyCell * cell = [[BBDMyApplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    BBDApplyModel * model = self.dataArray[indexPath.section];
    model.isDetail = 0;
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDApplyDetailController * vc = [[BBDApplyDetailController alloc]init];
    BBDApplyModel * model = self.dataArray[indexPath.section];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
