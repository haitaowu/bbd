//
//  BBDAddBankCardController.m
//  bbd
//
//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDAddBankCardController.h"
#import "BBDAddBankCell.h"
#import "BBDNetworkTool.h"
#import "UIAlertView+EXtension.h"

@interface BBDAddBankCardController ()<UITableViewDataSource,UITableViewDelegate,BBDAddBankCellDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * titleArray;

@property (nonatomic,strong) NSMutableArray * detailArray;

@property (nonatomic,strong) UIButton * confirmButton;

@end

@implementation BBDAddBankCardController

-(NSMutableArray *)detailArray
{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
    }
    return _detailArray;
}

-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"持卡人",@"手机号",@"卡　号",@"身份证号"];
    }
    return _titleArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
}

-(void)setupView
{
    self.navigationItem.title = @"添加银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.bounces = NO;
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdting)]];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(0);
    }];
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 20)];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.text = @"请绑定持卡人本人的银行卡";
    [headerView addSubview:tipLabel];
    self.tableView.tableHeaderView = headerView;
    
    self.confirmButton = ({
        
        UIButton * confirmButton = [[UIButton alloc]init];
        confirmButton.layer.cornerRadius = 5;
        confirmButton.layer.masksToBounds = YES;
        [confirmButton setBackgroundColor:[UIColor clearColor]];
        [confirmButton setTitle:@"确定绑定" forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[BBDNetworkTool createImageWithColor:GOLDEN_COLOR] forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[BBDNetworkTool createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
        confirmButton.enabled = NO;
        [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:confirmButton];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.height.mas_equalTo(33);
            make.right.mas_equalTo(-40);
            make.bottom.mas_equalTo(-20);
        }];
        confirmButton;
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDAddBankCell * cell = [[BBDAddBankCell alloc]initWithTitle:self.titleArray[indexPath.row]];
    cell.textField.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

-(void)addBankCellEdtingChanged:(BBDAddBankCell *)cell text:(NSString *)text
{
    [self.detailArray replaceObjectAtIndex:cell.textField.tag withObject:text];
    NSString * str0 = self.detailArray[0];
    NSString * str1 = self.detailArray[1];
    NSString * str2 = self.detailArray[2];
    NSString * str3 = self.detailArray[3];
    
    self.confirmButton.enabled = str0.length&&str1.length&&str2.length&&str3.length;
}

-(BOOL)IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length == 15 || IDCardNumber.length == 18) {
        return YES;
    }
        return NO;
}

-(void)confirmButtonClick
{
    if (![self IsIdentityCard:self.detailArray[3]]) {
        [UIAlertView wariningWithTitle:@"请填写正确的身份证号码"];
        return;
    }
    [BBDNetworkTool addBankCard:self.detailArray[0] cardNumber:self.detailArray[2] idCardNum:self.detailArray[3] phone:self.detailArray[1] success:^{
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^{
        
    }];
}

-(void)endEdting
{
    [self.view endEditing:YES];
}

@end

//                          ┌─┐       ┌─┐
//                       ┌──┘ ┴───────┘ ┴──┐
//                       │                 │
//                       │       ───       │
//                       │  ─┬┘       └┬─  │
//                       │                 │
//                       │       ─┴─       │
//                       │                 │
//                       └───┐         ┌───┘
//                           │         │
//                           │         │
//                           │         │
//                           │         └──────────────┐
//                           │                        │
//                           │                        ├─┐
//                           │                        ┌─┘
//                           │                        │
//                           └─┐  ┐  ┌───────┬──┐  ┌──┘
//                             │ ─┤ ─┤       │ ─┤ ─┤
//                             └──┴──┘       └──┴──┘
//                                    神兽保佑
//                                   代码无BUG!
