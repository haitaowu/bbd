//
//  BBDHomeAuthenTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDHomeAuthenTableViewController.h"

@interface BBDHomeAuthenTableViewController ()

@end

@implementation BBDHomeAuthenTableViewController
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
        //手机认证
        
    }else if ([segue.identifier isEqualToString:@"cardAuthenSegue"]) {
        //银行/工资卡认证
    }else if ([segue.identifier isEqualToString:@"idAuthenSegue"]) {
        //身份证认证
    }
}

#pragma mark - selectors
//手机认证
- (IBAction)tapPhoneAuthenBtn:(id)sender {
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Authentication" bundle:nil];
    BBDHomeAuthenTableViewController *controller = [homeStoryboard instantiateViewControllerWithIdentifier:@"BBDAuthenPhoneTableController"];
    [self.navigationController pushViewController:controller animated:YES];
}

//身份证认证
- (IBAction)tapIDAuthenBtn:(id)sender {
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Authentication" bundle:nil];
    BBDHomeAuthenTableViewController *controller = [homeStoryboard instantiateViewControllerWithIdentifier:@"BBDAuthenIDTableViewController"];
    [self.navigationController pushViewController:controller animated:YES];
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
