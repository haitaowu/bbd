//
//  BBDAboutBBDController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDAboutBBDController.h"
#import "BBDAgreementController.h"
#import "BBDNetworkTool.h"

@interface BBDAboutBBDController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray * titleArray;

@end

@implementation BBDAboutBBDController

-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"版本消息",@"帮帮贷用户协议",@"免责声明"];
    }
    return _titleArray;
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"me1_about_icon"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.7);
    }];
    
    UIButton * backButton = [[UIButton alloc]init];
    [backButton setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:backButton];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(25);
        make.width.height.mas_equalTo(30);
    }];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"关于帮帮贷";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backButton.mas_centerY);
        make.centerX.mas_equalTo(imageView.centerX);
    }];
    
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.bounces = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"当前版本%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0) {
        BBDAgreementController * vc = [[BBDAgreementController alloc]init];
        vc.type = (int)indexPath.row;
        vc.navigationItem.title = self.titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [BBDNetworkTool getVersion:^(BBDVersion *version) {
            
            double currentVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] doubleValue];
            double newVersion = [version.version_code doubleValue];
            
            if (newVersion > currentVersion) {
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:version.content preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //这边更新
                }];
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:confirm];
                [alert addAction:cancel];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }else{
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"当前已是最新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancel];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^{
            
        }];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
