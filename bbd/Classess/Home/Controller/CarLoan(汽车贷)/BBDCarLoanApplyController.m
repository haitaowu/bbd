//
//  BBCarDIdentityMessageController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCarLoanApplyController.h"
#import "BBDSegmented.h"
#import "BBDCarFillBankCardController.h"
#import "BBDCarPhoneVerifyController.h"


@interface BBDCarLoanApplyController ()
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSMutableArray *messageArr;

@end

@implementation BBDCarLoanApplyController

-(NSMutableArray *)messageArr{
    if (_messageArr == nil) {
        _messageArr = [NSMutableArray arrayWithObjects:@"0",@"",@"",@"", nil];
    }
    return _messageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArr = @[@"汽车性质",@"年　　月",@"车　　型",@"车  架  号"];
    [self setupUI];
}

-(void)setupUI{

    self.navigationItem.title = @"身份信息申请";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.backgroundColor = BASE_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row>0) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.68, 30)];
            [textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
            if (indexPath.row == 1) textField.placeholder = @"年/月/日";
            textField.font = [UIFont systemFontOfSize:13];
            textField.backgroundColor = [UIColor whiteColor];
            textField.borderStyle = UITextBorderStyleBezel;
            cell.accessoryView = textField;
            textField.inputAccessoryView = self.hideToolBar;
            
        }else{
            
            BBDSegmented *segment = [[BBDSegmented alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.68, 30)];
            segment.itmes = @[@"全款车",@"贷款车"];
            [segment addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventTouchUpInside];
            segment.edgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
            segment.selectIndex = 0;
            cell.accessoryView = segment;
            
        }
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];

    return cell;
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)changeText:(UITextField *)textField{
    
    UITableViewCell *cell = (UITableViewCell*)[textField superview];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.messageArr[indexPath.row] = textField.text;
    
    [self judgeFillMessageFinsh];
    
}

/** segment监听 */
- (void) changeSegment:(BBDSegmented *)segment {
    
    self.messageArr[0] = [NSString stringWithFormat:@"%ld",segment.selectIndex];
    [self judgeFillMessageFinsh];
}



/** 判断信息是否全部填写 */
-(void)judgeFillMessageFinsh{
    
    for (NSString *title in self.messageArr) {
        if (title.length<=0) {
            self.bottomButton.enabled = NO;
            return;
        }
    }
    
    self.bottomButton.enabled = YES;
}



#pragma mark - 下一步
-(void)next{

    BBDCarFillBankCardController *fillBankCardVC = [[BBDCarFillBankCardController alloc] init];
    fillBankCardVC.carLoanApplyArr = self.messageArr;
    fillBankCardVC.className = [BBDCarPhoneVerifyController class];
    [self.navigationController pushViewController:fillBankCardVC animated:YES];
}


@end
