//
//  BBDEmergencyTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDEmergencyTableViewController.h"
#import "BRPickerView.h"
#import "BBDConnectViewController.h"


#define kFamilySectionIndex                         0
#define kSocialSectionIndex                         1



@interface BBDEmergencyTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *confirmCell;

@property (weak, nonatomic) IBOutlet UITextField *familyField;
@property (weak, nonatomic) IBOutlet UITextField *familyPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *socialField;
@property (weak, nonatomic) IBOutlet UITextField *socialPhoneField;



@end

@implementation BBDEmergencyTableViewController
#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - selectors
//亲属关系 选择联系人
- (IBAction)clickFamilyContactsBtn{
    __block typeof(self) blockSelf = self;
    BBDConnectViewController * vc = [[BBDConnectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.selectBlock = ^(NSString *phoneNum) {
        blockSelf.familyPhoneField.text = phoneNum;
    };
}

//社会关系 选择联系人
- (IBAction)clickSocialContactsBtn{
    __block typeof(self) blockSelf = self;
    BBDConnectViewController * vc = [[BBDConnectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.selectBlock = ^(NSString *phoneNum) {
        blockSelf.socialPhoneField.text = phoneNum;
    };
}

#pragma mark - private methods UI
//亲属关系
- (void)setupFamilyPickView
{
        __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"亲属关系" dataSource:@[@"父母", @"配偶", @"兄弟姐妹"] defaultSelValue:@"父母" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.familyField.text = selectValue;
    }];
}

//社会关系
- (void)setupSocialPickView
{
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"社会关系" dataSource:@[@"同学", @"同事", @"朋友"] defaultSelValue:@"同学" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.socialField.text = selectValue;
    }];
}


#pragma mark - UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableView --- Table view  delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == kFamilySectionIndex) {
        if (indexPath.row == 0) {
            [self setupFamilyPickView];
        }
    }else if (indexPath.section == kSocialSectionIndex) {
        if (indexPath.row == 0) {
            [self setupSocialPickView];
        }
    }
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
