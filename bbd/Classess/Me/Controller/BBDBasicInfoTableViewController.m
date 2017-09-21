//
//  BBDBasicInfoTableViewController.m
//  bbd
//
//  Created by taotao on 2017/9/20.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDBasicInfoTableViewController.h"
#import "BRPickerView.h"
#import <CoreLocation/CoreLocation.h>


#define kEducationRowIndex                          0
#define kMarriageStateRowIndex                      1
#define kChildCountRowIndex                         2
#define kLocationRowIndex                           3
#define kDetailAdrRowIndex                          4
#define kLiveYearRowIndex                           5
#define kQQRowIndex                                 6
#define kEmailRowIndex                              7

//系统版本
#define IOS8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)


@interface BBDBasicInfoTableViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *confirmCell;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *educationField;
@property (weak, nonatomic) IBOutlet UITextField *marriageField;
@property (weak, nonatomic) IBOutlet UITextField *childrenField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *detailAdrField;
@property (weak, nonatomic) IBOutlet UITextField *liveYearField;
@property (weak, nonatomic) IBOutlet UITextField *qqField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation BBDBasicInfoTableViewController
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
//学历 textField
- (void)setupEducationPickView
{
        __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"学历" dataSource:@[@"大专以下", @"大专", @"本科", @"硕士", @"博士", @"博士后"] defaultSelValue:@"本科" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.educationField.text = selectValue;
    }];
}

//婚姻
- (void)setupMarriagePickView
{
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"婚姻" dataSource:@[@"已婚", @"未婚"] defaultSelValue:@"未婚" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.marriageField.text = selectValue;
    }];
}

//子女个数
- (void)setupChildCountPickView
{
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"子女个数" dataSource:@[@"0", @"1",@"2",@"3",@"4"] defaultSelValue:@"0" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.marriageField.text = selectValue;
    }];
}

//居住时长
- (void)setupLiveYearPickView
{
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"居住时长" dataSource:@[@"三个月", @"六个月",@"一年",@"两年",@"两年以上"] defaultSelValue:@"三个月" isAutoSelect:YES resultBlock:^(id selectValue) {
        weakSelf.liveYearField.text = selectValue;
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
    if (indexPath.row == kEducationRowIndex) {
        [self setupEducationPickView];
    }else if (indexPath.row == kMarriageStateRowIndex) {
        [self setupMarriagePickView];
    }else if (indexPath.row == kChildCountRowIndex) {
        [self setupChildCountPickView];
    }else if (indexPath.row == kLiveYearRowIndex) {
        [self setupLiveYearPickView];
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
