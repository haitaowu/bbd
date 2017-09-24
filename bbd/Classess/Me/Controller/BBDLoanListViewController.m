//
//  BBDLoanListViewController.m
//  bbd
//
//  Created by taotao on 2017/9/24.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDLoanListViewController.h"
#import "BBDLoadRecordCell.h"

static NSString *BBDLoadRecordCellID = @"BBDLoadRecordCellID";


@interface BBDLoanListViewController ()

@end

@implementation BBDLoanListViewController

#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"借款记录";
    UINib *cellNib = [UINib nibWithNibName:@"BBDLoadRecordCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:BBDLoadRecordCellID];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBDLoadRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:BBDLoadRecordCellID];
    return cell;
}


#pragma mark - UITableView --- Table view  delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}




@end
