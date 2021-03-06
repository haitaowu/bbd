//
//  BBDHomeViewController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/28.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDHomeViewController.h"
#import <SDCycleScrollView.h>
#import "BBDHomeCell.h"
#import "BBDHomeApplyController.h"
#import "BBDHomeCycleModel.h"
#import "BBDHomeDetailController.h"
#import "BBDSelectMoneyViewController.h"
#import "BBDCommonPhoneVerifyController.h"
#import "BBDConnect.h"
#import <MJExtension.h>

@interface BBDHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSArray *cycleModelArr;
@property(nonatomic,strong) SDCycleScrollView *headerView;

@end

@implementation BBDHomeViewController

-(SDCycleScrollView *)headerView{
    
    if (_headerView == nil) {
        _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.6) delegate:self placeholderImage:[UIImage imageNamed:@"video_picture_icon"]];
        _headerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _headerView.backgroundColor = RCColor(219, 219, 219);
    }
    return _headerView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArr = @[@{@"title":@"普通贷",
                     @"detail":@"额度高 下载快",
                     @"leftImage":@"home_common_icon",
                     @"rightImage":@"home_common_chart_icon"}];
    
//    _dataArr = @[@{@"title":@"极速贷",
//                   @"detail":@"10分钟下款",
//                   @"leftImage":@"home_extreme_icon",
//                   @"rightImage":@"home_extreme_chart_icon"},
//                 @{@"title":@"汽车贷",
//                   @"detail":@"最高下款20万",
//                   @"leftImage":@"home_car_icon",
//                   @"rightImage":@"home_car_chart_icon"},
//                 @{@"title":@"普通贷",
//                   @"detail":@"额度高 下载快",
//                   @"leftImage":@"home_common_icon",
//                   @"rightImage":@"home_common_chart_icon"}];
    
    [self setUI];
    [self uploadConnect];
}

-(void)setUI
{
    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.scrollEnabled = NO;
    self.navigationItem.title = @"首页";
    self.tableView.backgroundColor = RCColor(241, 242, 243);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[BBDHomeCell class] forCellReuseIdentifier:NSStringFromClass([BBDHomeCell class])];
    
}

-(void)uploadConnect
{
    NSMutableArray * dicArray = [NSMutableArray array];
    NSArray * array = [BBDConnect connectArray];
    for (BBDConnect * connect in array) {
        if (connect.phone == nil) {
            connect.phone = @"";
        }
        NSDictionary * dic = [connect mj_keyValues];
        [dicArray addObject:dic];
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dicArray options:kNilOptions error:nil] encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d",(int)[NSUserDefaults getUserId]] forKey:@"user_id"];
    [parameters setObject:jsonString forKey:@"addressBook"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@userinfo/saveAddressBook",BASE_API] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadHeaderImages];
    [self setupRefresh];
}

-(void)setupRefresh{
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
}


-(void)refresh{
    NSLog(@"%s",__func__);
    [self.tableView.refreshControl endRefreshing];
}

-(void)loadHeaderImages{

    
    __weak typeof(self) target = self;
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"home/getHomeImg"]
                             parameters:nil
                               progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (CODE == 2) {
            _cycleModelArr = [BBDHomeCycleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [target headerViewAddImages];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)headerViewAddImages
{
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (BBDHomeCycleModel *model in _cycleModelArr) {
        [imagesArr addObject:model.thumbnail_img];
    }
    self.headerView.imageURLStringsGroup = imagesArr;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDHomeCell class])];
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.titleLabel.text = dic[@"title"];
    cell.detailLabel.text = dic[@"detail"];
    cell.leftImageView.image = [UIImage imageNamed:dic[@"leftImage"]];
    cell.rightImageView.image = [UIImage imageNamed:dic[@"rightImage"]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImageView *headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_round_icon"]];
    headView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.text = @"帮帮贷，您身边的贷款好帮手";
    headLabel.font = [UIFont systemFontOfSize:13];
    headLabel.textColor = GOLDEN_COLOR;
    [headView addSubview:headLabel];
  
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView.mas_centerX);
        make.height.mas_equalTo(headView.mas_height);
    }];

    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    BBDHomeApplyController * applyVC = [[BBDHomeApplyController alloc] init];
//    
//    applyVC.titleName = _dataArr[indexPath.row][@"title"];
//    applyVC.loanType = (int)indexPath.row;
//    [self.navigationController pushViewController:applyVC animated:YES];
    BBDSelectMoneyViewController * vc = [[BBDSelectMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    BBDHomeCycleModel *model = _cycleModelArr[index];

    BBDHomeDetailController *homeDetailVC = [[BBDHomeDetailController alloc] init];
        
    homeDetailVC.activityId = model.activity_id;
    
    homeDetailVC.urlStr = model.url;
    [self.navigationController pushViewController:homeDetailVC animated:YES];
    
}
@end
