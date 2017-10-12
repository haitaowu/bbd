//
//  BBDOccupationTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDOccupationTableViewController.h"
#import "BRPickerView.h"
#import <CoreLocation/CoreLocation.h>


#define kOccupationRowIndex                         0
#define kSalaryRowIndex                             1
#define kCompanyRowIndex                            2
#define kLocationRowIndex                           3
#define kDetailAdrRowIndex                          4
#define kCompanyNumRowIndex                         5

//系统版本
#define IOS8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)


@interface BBDOccupationTableViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *confirmCell;

@property (weak, nonatomic) IBOutlet UITextField *occupationField;
@property (weak, nonatomic) IBOutlet UITextField *salaryField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *detailAdrField;
@property (weak, nonatomic) IBOutlet UITextField *companyNumField;

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation BBDOccupationTableViewController
#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self startUpldatingLocation];
}

#pragma mark - selectors
- (IBAction)startUpldatingLocation{
    if([CLLocationManager locationServicesEnabled])
    {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000.0f;
        if (IOS8_OR_LATER) {
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }
}

//点击提交按钮
- (IBAction)tapSubmitBtn:(id)sender {
}

#pragma mark - private methods
- (void)getCurrentAdrWithLoc:(CLLocation *)newLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        dispatch_async(dispatch_get_main_queue(),^ {
            if (placemarks != nil && [placemarks count]>0) {
                CLPlacemark *placemark = placemarks[0];
                
                NSString *provice = placemark.administrativeArea;
                NSString *city = placemark.locality;
                
                if (city == nil) {
                    city = provice;
                }
                NSString *currentAddress = [NSString stringWithFormat:@"%@ %@",provice,city];
                NSLog(@"address=%@",currentAddress);
                self.cityField.text = currentAddress;
            }
        });
    }];
}

#pragma mark - private methods UI
//职业
- (void)setupOccupyPickView
{
        __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"职业" dataSource:@[@"程序员", @"设计师", @"产品经理", @"会计", @"销售", @"其它"] defaultSelValue:@"程序员" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.occupationField.text = selectValue;
    }];
}

//收入
- (void)setupSalaryPickView
{
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"收入" dataSource:@[@"小于1000", @"1000-2000", @"2000-4000", @"4000-6000", @"6000-10000", @"10000以上"] defaultSelValue:@"未婚" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.salaryField.text = selectValue;
    }];
}


//所在城市
- (void)setupCityPickView
{
    __weak typeof(self) weakSelf = self;
    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
        weakSelf.cityField.text = [NSString stringWithFormat:@"%@ %@", selectAddressArr[0], selectAddressArr[1]];
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
    if (indexPath.row == kOccupationRowIndex) {
        [self setupOccupyPickView];
    }else if (indexPath.row == kSalaryRowIndex) {
        [self setupSalaryPickView];
    }else if (indexPath.row == kLocationRowIndex) {
        [self setupCityPickView];
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

#pragma mark -- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [self.locationManager stopUpdatingLocation];
     [self getCurrentAdrWithLoc:newLocation];
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败。。。");
    [self.locationManager stopUpdatingLocation];
}

@end
