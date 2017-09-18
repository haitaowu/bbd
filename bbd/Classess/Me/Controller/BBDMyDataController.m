//
//  BBDMyDataController.m
//  bbd
//
//  Created by Mr.Wang on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDMyDataController.h"
#import "BBDNetworkTool.h"
#import "BBDItemModel.h"
#import "BBDApplyDetailHeadView.h"
#import "BBDEditInformationController.h"
#import "BBDLoginViewController.h"
#import "BBDGestureViewController.h"
#import "KeychainData.h"
#import "BBDRootNavigationController.h"
#import "BBDForgetPwdViewController.h"

@interface BBDMyDataController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) BBDUserInformation *userInformation;

@property (nonatomic,strong) UIButton * exitButton;

@end

@implementation BBDMyDataController

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithArray:[BBDApplyItem userDataArray]];
    }
    return _dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}

-(void)setupView
{
    self.navigationItem.title = @"我的资料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button addTarget:self action:@selector(editInformation) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"core_order_4_click_icon"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.exitButton = [[UIButton alloc]init];
    self.exitButton.layer.cornerRadius = 5;
    self.exitButton.layer.masksToBounds = YES;
    [self.exitButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.exitButton setBackgroundImage:[BBDNetworkTool createImageWithColor:GOLDEN_COLOR] forState:UIControlStateNormal];
    [self.exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.exitButton];
    
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(33);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(-20);
    }];
}

-(void)loadData
{
    [BBDNetworkTool getUserDataSuccess:^(BBDUserInformation *userInformation) {
        self.userInformation = userInformation;
        
         if ([NSUserDefaults getIsGesture]) {
             self.userInformation.gesture = @"已设置";
         }else{
             self.userInformation.gesture = @"未设置";
         }
        
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BBDApplyGroup * group = self.dataArray[section];
    BBDApplyDetailHeadView * headView = [[BBDApplyDetailHeadView alloc]initWithTitle:group.title];
    return headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BBDApplyGroup * group = self.dataArray[section];
    return group.itemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出cell的模型
    BBDApplyGroup * group = self.dataArray[indexPath.section];
    BBDApplyItem * item = group.itemArray[indexPath.row];
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    //cell模型中的key字符串
    NSString * key = item.keyStr;
    cell.textLabel.text = [BBDUserInformation getKeyName:key];
    cell.detailTextLabel.text = [self.userInformation valueForKey:key];
    
    if ([key isEqualToString:@"password"] || [key isEqualToString:@"gesture"]) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
        [button addTarget:self action:@selector(editPassword:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = indexPath.row;
        [button setTitleColor:GOLDEN_COLOR forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"修改" forState:UIControlStateNormal];
        cell.accessoryView = button;
    }
    
    return cell;
}

-(void)editInformation
{
    if (self.userInformation == nil) return;
    BBDEditInformationController * vc = [[BBDEditInformationController alloc]init];
    vc.userInformation = self.userInformation;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)editPassword:(UIButton *)button
{
    if (button.tag == 1) {
        BBDForgetPwdViewController * vc = [[BBDForgetPwdViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        BBDGestureViewController * vc = [[BBDGestureViewController alloc]init];
        if ([NSUserDefaults getIsGesture]) {
            vc.gestureStyle = AlertPwdModel;
        }else{
            vc.gestureStyle = SetPwdModel;
        }
        vc.block = ^(NSString *pswString){
            [NSUserDefaults saveIsGesture];
            [self.tableView reloadData];
        };
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(void)exitButtonClick
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self logOut];
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:confirm];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)logOut
{
    [NSUserDefaults removeUserId];
    [KeychainData forgotPsw];
    [NSUserDefaults removeIsGesture];
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"reveal";
    animation.duration = 0.3;
    animation.subtype =kCATransitionFromRight;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view removeFromSuperview];
    BBDRootNavigationController *nav = [[BBDRootNavigationController alloc] initWithRootViewController:[[BBDLoginViewController alloc] init]];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

@end
