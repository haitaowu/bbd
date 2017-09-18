//
//  BBDQuestionListViewController.m
//  bbd
//
//  Created by 韩加宇 on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDQuestionListViewController.h"
#import "QuestionListModel.h"
#import <MJRefresh.h>
#import "BBDQuestionDetailViewController.h"

@interface BBDQuestionListViewController ()<UITableViewDelegate,UITableViewDataSource>

/// 问题tableView
@property (nonatomic, strong) UITableView *questionTableView;

/// 页数
@property (nonatomic, assign) NSInteger page;
/// 问题数组
@property (nonatomic, strong) NSMutableArray *questionArray;
@end

@implementation BBDQuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置界面
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
/**
 *  设置界面
 */
- (void)setupUI {

    switch (self.type) {
        case 1:
            self.title = @"新手引导";
            break;
        case 2:
            self.title = @"安全保障问题";
            break;
        case 3:
            self.title = @"普通贷";
            break;
        case 4:
            self.title = @"还款问题";
            self.type = 5;
            break;
        case 5:
            self.title = @"账户安全问题";
            self.type = 6;
            break;
        case 6:
            self.title = @"账户安全问题";
            break;
        default:
            break;
    }
    
    [self.view addSubview:self.questionTableView];
    
    [self.questionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    // 进入刷新状态
    [self.questionTableView.mj_header beginRefreshing];
}
/**
 *  加载数据
 */
- (void)loadData {

    [QuestionListModel loadQuestionListWithType:self.type withPage:self.page withFinished:^(NSArray *models, NSError *error) {
       
        // 结束刷新状态
        [self.questionTableView.mj_header endRefreshing];
        [self.questionTableView.mj_footer endRefreshing];
        // 有错就返回
        if (error != nil) {
            return ;
        }
        // 如果小于10条，则提示没有更多数据
        if (models.count < 10) {
            [self.questionTableView.mj_footer endRefreshingWithNoMoreData];
        }
        // 是第一页，重复请求数据
        if (self.page == 1) {
            [self.questionArray removeAllObjects];
        }
        
        [self.questionArray addObjectsFromArray:models];
        // 刷新表格
        [self.questionTableView reloadData];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.questionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"questionCell"];
    
    QuestionListModel *model = self.questionArray[indexPath.row];
    
    questionCell.textLabel.text = model.title;
    questionCell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return questionCell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BBDQuestionDetailViewController *questionDetailViewController = [[BBDQuestionDetailViewController alloc] init];
    
    questionDetailViewController.questionModel = self.questionArray[indexPath.row];
    
    [self.navigationController pushViewController:questionDetailViewController animated:YES];
}

#pragma mark -懒加载
- (UITableView *)questionTableView {

    if (_questionTableView == nil) {
        _questionTableView = [[UITableView alloc] init];
        _questionTableView.delegate = self;
        _questionTableView.dataSource = self;
        _questionTableView.backgroundColor = BASE_COLOR;
        
        [_questionTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"questionCell"];
        
        _questionTableView.tableFooterView = [[UIView alloc] init];
        
        _questionTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            self.page = 1;
            
            [_questionTableView.mj_footer resetNoMoreData];
            // 加载数据
            [self loadData];
        }];
        
        _questionTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           
            self.page ++;
            // 加载数据
            [self loadData];
        }];
    }
    return _questionTableView;
}

- (NSMutableArray *)questionArray {

    if (_questionArray == nil) {
        _questionArray = [NSMutableArray array];
    }
    return _questionArray;
}
@end
