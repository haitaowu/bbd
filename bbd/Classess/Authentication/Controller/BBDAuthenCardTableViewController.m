//
//  BBDAuthenCardTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDAuthenCardTableViewController.h"
#import "BRPickerView.h"
#import <CoreLocation/CoreLocation.h>


#define kBanksRowIndex                          0
#define kCityRowIndex                           1

//系统版本
#define IOS8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)


@interface BBDAuthenCardTableViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *confirmCell;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *bankField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumField;


@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation BBDAuthenCardTableViewController
#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self startUpldatingLocation];
}

#pragma mark - selectors
//点击确定按钮
- (IBAction)clickConfirmBtn:(id)sender {
}


#pragma mark - private methods
- (void)startUpldatingLocation{
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
//开户行 textField
- (void)setupBanksPickView
{
        __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"开户行" dataSource:@[@"中国工商银行", @"招商银行", @"中国农业银行", @"中国建设银行", @"中国民生银行", @"中国光大银行"] defaultSelValue:@"中国工商银行" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.bankField.text = selectValue;
    }];
}

//选择城市
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
    if (indexPath.row == kBanksRowIndex) {
        [self setupBanksPickView];
    }else if (indexPath.row == kCityRowIndex) {
        [self setupCityPickView];
    }else{
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
