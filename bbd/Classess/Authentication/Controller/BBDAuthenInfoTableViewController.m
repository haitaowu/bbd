//
//  BBDAuthenInfoTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDAuthenInfoTableViewController.h"

@interface BBDAuthenInfoTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *confirmCell;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation BBDAuthenInfoTableViewController
#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - UITableView --- Table view  delegate
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
    return 0.001;
}

@end
