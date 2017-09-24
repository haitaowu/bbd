//
//  BBDLoanDetailViewController.m
//  bbd
//
//  Created by taotao on 2017/9/24.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDLoanDetailViewController.h"
#import "BBDLoadRecordCell.h"


@interface BBDLoanDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation BBDLoanDetailViewController

#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.submitBtn.layer.borderColor = GOLDEN_COLOR.CGColor;
    self.submitBtn.layer.borderWidth = 1;
}


#pragma mark - UITableView --- Table view  delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    return 50;
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
    if (section == 0) {
        return 0.001;
    }else{
        return 50;
    }
}




@end
