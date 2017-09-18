//
//  BBDConnectViewController.m
//  bbd
//
//  Created by Mr.Wang on 2017/5/23.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDConnectViewController.h"
#import <AddressBook/AddressBook.h>
#import "BBDConnect.h"

@interface BBDConnectViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BBDConnectViewController

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [BBDConnect connectArray];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    BBDConnect * people = self.dataArray[indexPath.row];
    cell.textLabel.text = people.name;
    cell.detailTextLabel.text = people.phone;
    return cell;
}

@end
