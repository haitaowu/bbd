//
//  BBDApplyDetailController.m
//  bbd
//
//  Created by Mr.Wang on 17/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDApplyDetailController.h"
#import "BBDNetworkTool.h"
#import "BBDItemModel.h"
#import "BBDApplyDetailHeadView.h"
#import "BBDMyApplyCell.h"
#import "BBDHomeApplyController.h"
#import "BBDApplyImageCell.h"
#import <SVProgressHUD.h>
#import "BBDSelectMoneyViewController.h"

@interface BBDApplyDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) BBDApplyDetail * applyDetail;

@property (nonatomic,strong) NSMutableArray * IDCardImageArray;

@end

@implementation BBDApplyDetailController

static NSString * ID = @"detailLabelCell";

-(NSMutableArray *)IDCardImageArray
{
    if (_IDCardImageArray == nil) {
        _IDCardImageArray = [NSMutableArray array];
    }
    return _IDCardImageArray;
}

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
        _dataArray = [BBDApplyItem itemArrayWithType:self.model.loan_type];
    }
    return _dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    if (self.model.type == 0) {
        self.navigationItem.title = @"待审核";
    }else if (self.model.type == 1) {
        self.navigationItem.title = @"进行中";
    }else if (self.model.type == 2) {
        self.navigationItem.title = @"已放款";
    }
}

-(void)loadData
{
    [BBDNetworkTool getApplyDetail:self.model success:^(BBDApplyDetail *detail) {
        self.applyDetail = detail;
        self.IDCardImageArray = [NSMutableArray arrayWithArray:
                                 @[[NSString stringWithFormat:@"%@",self.applyDetail.cart_front],
                                   [NSString stringWithFormat:@"%@",self.applyDetail.cart_back],
                                   [NSString stringWithFormat:@"%@",self.applyDetail.hand_front],
                                   [NSString stringWithFormat:@"%@",self.applyDetail.hand_back]]];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDApplyGroup * group = self.dataArray[indexPath.section];
    BBDApplyItem * item = group.itemArray[indexPath.row];
    if (item.type == BBDApplyItemTypeTitle) {
        return 30;
    }else if (item.type == BBDApplyItemTypeOneImage){
        return SCREEN_WIDTH / 4 * 0.75+ 16;
    }else if (item.type == BBDApplyItemTypeFourImage){
        return SCREEN_WIDTH / 2 * 0.75 + 24;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0.1;
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    BBDApplyGroup * group = self.dataArray[section];
    BBDApplyDetailHeadView * headView = [[BBDApplyDetailHeadView alloc]initWithTitle:group.title];
    return headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BBDApplyGroup * group = self.dataArray[section];
    return group.itemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出cell的模型
    BBDApplyGroup * group = self.dataArray[indexPath.section];
    BBDApplyItem * item = group.itemArray[indexPath.row];
    
    if (item.type == BBDApplyItemTypeDefault) {
        
        BBDMyApplyCell * cell = [[BBDMyApplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.model.isDetail = 1;//将模型设为详情的样式
        cell.model = self.model;
        return cell;
        
    }//顶部cell
    else if (item.type == BBDApplyItemTypeTitle) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        //cell模型中的key字符串
        NSString * key = item.keyStr;
        cell.textLabel.text = [BBDApplyDetail getKeyName:key];
        cell.detailTextLabel.text = [self.applyDetail valueForKey:key];

        if ([key isEqualToString:@"advance_number"]) {
            NSArray * array = @[@"支付宝",@"银行卡"];
            cell.textLabel.text = array[[[self.applyDetail valueForKey:@"advance"] intValue] ];
        }//左边，收款账号类型
        
        return cell;
    }//普通文本cell
    else{
        int imageCount;
        
        if (item.type == BBDApplyItemTypeOneImage) {
            imageCount = 1;
        }else if (item.type == BBDApplyItemTypeFourImage) {
            imageCount = 4;
        }
        
        BBDApplyImageCell * cell = [[BBDApplyImageCell alloc]initWithImageCount:imageCount];
        
        NSString * key = item.keyStr;
        cell.nameLabel.text = [BBDApplyDetail getKeyName:key];
        
        if ([key isEqualToString:@"idCardNumber"]) {
            cell.imageArray = [NSArray arrayWithArray:self.IDCardImageArray];
        }else{
            cell.imageArray = @[[NSString stringWithFormat:@"%@",[self.applyDetail valueForKey:key]]];
        }
        
        return cell;
    }//图片cell
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
//        BBDHomeApplyController * vc = [[BBDHomeApplyController alloc]init];
//        NSString * titleName;
//        LoanType loanType;
//        
//        if (self.model.loan_type == 0) {
//            titleName = @"汽车贷";
//            loanType = CarLoan;
//        }else if (self.model.loan_type == 1){
//            titleName = @"普通贷";
//            loanType = CommonLoan;
//        }else if (self.model.loan_type == 2){
//            titleName = @"极速贷";
//            loanType = FastLoan;
//        }
//        
//        vc.titleName = titleName;
//        vc.loanType = loanType;
//        [self.navigationController pushViewController:vc animated:YES];
        BBDSelectMoneyViewController * vc = [[BBDSelectMoneyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
