//
//  BBDAuthenTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDAuthenTableViewController.h"

@interface BBDAuthenTableViewController ()

@end

@implementation BBDAuthenTableViewController
#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"basiceInfoSegue"]) {
//        agencyQCodeController *destinationControl = (agencyQCodeController*)segue.destinationViewController;
//        destinationControl.params = sender;
    }else if ([segue.identifier isEqualToString:@"phoneAuthenSegue"]) {
        
    }else if ([segue.identifier isEqualToString:@"cardAuthenSegue"]) {
        
    }
}

#pragma mark - selectors 
//手机认证
- (IBAction)clickPhoneAuthenBtn:(id)sender {
}

//基本信息认证
- (IBAction)clickBasicAuthenBtn:(id)sender {
}

//身份证认证
- (IBAction)clickIDAuthenBtn:(id)sender {
}

//银行/工资卡认证
- (IBAction)clickCardsAuthenBtn:(id)sender {
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
    return 10;
}

@end
