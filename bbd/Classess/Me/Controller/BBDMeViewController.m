//
//  BBDMeViewController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/28.
//  Copyright © 2016年 Mr.Wang. All rights reserved.
//

#import "BBDMeViewController.h"
#import "BBDMeHomeTableViewHeaderView.h"
#import "BBDItemModel.h"
#import "BBDMeMyBankCardController.h"
#import "BBDMyApplyController.h"
#import "BBDMyMessageController.h"
#import "BBDAboutBBDController.h"
#import "BBDNetworkTool.h"
#import <SVProgressHUD.h>
#import "BBDMyDataController.h"
#import "BBDConnectViewController.h"

@interface BBDMeViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) BBDMeHomeTableViewHeaderView * tableViewHeaderView;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * itemArray;

@property (nonatomic,strong) UIImagePickerController * imagePicker;

@property (nonatomic,assign) int messageCount;

@property (nonatomic,strong) UIView * redView;

@end

@implementation BBDMeViewController

#define tableViewHeaderViewHeight SCREEN_WIDTH * 0.7

-(UIView *)redView
{
    if (_redView == nil) {
        _redView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 18, 8, 8)];
        _redView.layer.cornerRadius = 4;
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

-(UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

-(NSArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = @[[[BBDItemModel alloc]initWithImage:@"me_1_icon" title:@"我的资料" class:
                        [BBDMyDataController class]],
                       [[BBDItemModel alloc]initWithImage:@"me_2_icon" title:@"我的消息" class:[BBDMyMessageController class]],
                       [[BBDItemModel alloc]initWithImage:@"me_3_icon" title:@"关于帮帮贷" class:[BBDAboutBBDController class]],
                       [[BBDItemModel alloc]initWithImage:@"me_4_icon" title:@"资讯400电话" class:nil],
                       [[BBDItemModel alloc]initWithImage:@"me_3_icon" title:@"通讯录" class:[BBDConnectViewController class]],];
        
    }
    return _itemArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableViewHeaderView loadData];
    
    [BBDNetworkTool getUnreadMessageCount:^(int messageCount) {
        
        self.messageCount = messageCount;
        [self.tableView reloadData];
        
    } failure:^{
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)setupView
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarItem.badgeValue = nil;
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableViewHeaderView = [[BBDMeHomeTableViewHeaderView alloc]initWithTarget:self];
    [self.tableViewHeaderView.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeadImage)]];
    [self.view addSubview:self.tableViewHeaderView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.mas_equalTo(tableViewHeaderViewHeight);
    }];
    
    [self.tableViewHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(tableViewHeaderViewHeight);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**我的额度*/
-(void)myLimit
{
    
}

/**我的银行卡*/
-(void)myBankCard
{
    BBDMeMyBankCardController * vc = [[BBDMeMyBankCardController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**我的申请*/
-(void)myApply
{
    BBDMyApplyController * vc = [[BBDMyApplyController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDItemModel * item = self.itemArray[indexPath.row];
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed:item.image];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 1) {
        if (self.messageCount != 0) {
            [cell addSubview:self.redView];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBDItemModel * item = self.itemArray[indexPath.row];
    
//    if (indexPath.row == 0) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Authentication" bundle:nil];
//        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"AuthenController"];
//       [self.navigationController pushViewController:controller animated:YES];
//        return;
//    }
    if (item.className != nil) {
        UIViewController * vc = [[[item.className class]alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 3) {
        [BBDNetworkTool getTelephone:^(NSArray *telephone) {
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            for (NSString * tel in telephone) {
                UIAlertAction * confirm = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"拨打：%@",tel] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",tel]]];
                }];
                [alert addAction:confirm];
            }
            
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancel];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            
        } failure:^{
            
        }];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y < 0) {
        [self.tableViewHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(tableViewHeaderViewHeight - self.tableView.contentOffset.y);
        }];
    }
}

-(void)selectHeadImage
{
    self.imagePicker.allowsEditing = YES;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * choosePhoto = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction * takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction * cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:choosePhoto];
    [alert addAction:takePhoto];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - imagePicker delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [BBDNetworkTool uploadImage:image success:^(NSString *url) {
        
        [BBDNetworkTool setUserHeadImage:url success:^{
            self.tableViewHeaderView.headImageView.image = image;
        } failure:^{
            
        }];
    } failure:^{
        
    }];
}

@end
