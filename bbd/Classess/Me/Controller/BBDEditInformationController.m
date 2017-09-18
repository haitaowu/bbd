//
//  BBDEditInformationController.m
//  bbd
//
//  Created by Mr.Wang on 17/1/4.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDEditInformationController.h"
#import "BBDAddBankCell.h"
#import "BBDNetworkTool.h"
#import "BBDDateInputView.h"
#import "BBDNetworkTool.h"
#import "UIAlertView+EXtension.h"

@interface BBDEditInformationController ()<UITableViewDataSource,UITableViewDelegate,BBDAddBankCellDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * detailArray;

@property (nonatomic,strong) NSArray * titleArray;

@property (nonatomic,strong) UIButton * confirmButton;

@end

@implementation BBDEditInformationController

-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"昵　　称",@"身份证号",@"生　　日",@"地　　址"];
    }
    return _titleArray;
}

-(NSMutableArray *)detailArray
{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray arrayWithArray:@[self.userInformation.nickname,
                                                        self.userInformation.cart_number,
                                                        self.userInformation.birthday,
                                                        self.userInformation.address]];
    }
    return _detailArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

-(void)setupView
{
    self.navigationItem.title = @"修改我的资料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdting)]];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    
    self.confirmButton = [[UIButton alloc]init];
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
    [self.confirmButton setBackgroundColor:[UIColor clearColor]];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[BBDNetworkTool createImageWithColor:GOLDEN_COLOR] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[BBDNetworkTool createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(33);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBDAddBankCell * cell = [[BBDAddBankCell alloc]initWithTitle:self.titleArray[indexPath.row]];
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
    cell.textField.text = self.detailArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)addBankCellEdtingChanged:(BBDAddBankCell *)cell text:(NSString *)text
{
    [self.detailArray replaceObjectAtIndex:cell.textField.tag withObject:text];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
        
        BBDDateInputView * picker = [[BBDDateInputView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.6)];
        picker.datePickBlock = ^(NSString * date){
            textField.text = date;
            [self.detailArray replaceObjectAtIndex:2 withObject:date];
        };
        textField.inputView = picker;
    }
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 2) {
        return NO;
    }return YES;
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
    NSString * nickname = self.detailArray[0];
    NSString * idCard = self.detailArray[1];
    NSString * birthday = self.detailArray[2];
    NSString * address = self.detailArray[3];
    NSLog(@"%@",self.detailArray);
    
    if (!(nickname.length&&idCard.length&&birthday.length&&address.length)) return;
    
    if (![self IsIdentityCard:idCard]) {
        [UIAlertView wariningWithTitle:@"请填写正确的身份证号码"];
        return;
    }
    
    [BBDNetworkTool setUserInformationNickname:nickname idCard:idCard birthday:birthday address:address success:^{
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^{
        
    }];
}

-(void)endEdting
{
    [self.view endEditing:YES];
}

@end
