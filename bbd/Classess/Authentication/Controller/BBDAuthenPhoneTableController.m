//
//  BBDAuthenPhoneTableController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDAuthenPhoneTableController.h"

@interface BBDAuthenPhoneTableController ()

@end

@implementation BBDAuthenPhoneTableController
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
//    if ([segue.identifier isEqualToString:@"basiceInfoSegue"]) {
//        agencyQCodeController *destinationControl = (agencyQCodeController*)segue.destinationViewController;
//        destinationControl.params = sender;
//    }else if ([segue.identifier isEqualToString:@"phoneAuthenSegue"]) {
//    }
}

#pragma mark - selectors 
//下一步
- (IBAction)clickNextBtn:(id)sender {
    [self performSegueWithIdentifier:@"authenSuccSegue" sender:nil];
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
