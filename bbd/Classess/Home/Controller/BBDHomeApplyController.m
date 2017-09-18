//
//  BBDHomeApplyController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/16.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDHomeApplyController.h"
#import "BBDHomeApplyCell.h"
#import "BBDHomeApplyModel.h"
#import "BBDHomeApplyOtherCell.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "BBDSelectMoneyViewController.h"

@interface BBDHomeApplyController ()

@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) BBDHomeApplyModel *applyModel;

@end

@implementation BBDHomeApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = @[@"产品特色",
                 @"申请条件",
                 @"费用说明",
                 @"申请流程图"];
    
    self.navigationItem.title = self.titleName;
    
    [self loadData];
}

-(void)loadData{
    
    [SVProgressHUD show];
    NSDictionary *parameters = @{@"product_id":@(self.loanType+1)};
    
    [[AFHTTPSessionManager manager] GET:[BASE_API stringByAppendingString:@"product/getProductInformation"] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (CODE == 2) {
            
            [SVProgressHUD dismiss];
            _applyModel = [BBDHomeApplyModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self setChildView];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

-(void)setChildView{
    
    
    __weak typeof(self) target = self;
    // 利用 SDWebImage 框架提供的功能下载图片
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *url = [NSURL URLWithString:_applyModel.flowchart_img];
    [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        // 图片保存到磁盘上
        [[SDImageCache sharedImageCache] storeImage:image forKey:_applyModel.flowchart_img toDisk:YES];
        
        // 延迟在主线程更新 cell 的高度
        [target performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:NO];
    }];
    
    
    self.bottomButton.enabled = YES;
    [self.bottomButton setTitle:@"立即申请" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BBDHomeApplyCell class] forCellReuseIdentifier:NSStringFromClass([BBDHomeApplyCell class])];
    [self.tableView registerClass:[BBDHomeApplyOtherCell class] forCellReuseIdentifier:NSStringFromClass([BBDHomeApplyOtherCell class])];
    
}

#pragma mark - 刷新tableView
- (void)refreshTableView{
    [self.tableView reloadData];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row>= _dataArr.count-1) {
        
        BBDHomeApplyOtherCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDHomeApplyOtherCell class])];
        cell.titleLabel.text = _dataArr[indexPath.row];
        [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:_applyModel.flowchart_img] placeholderImage:[UIImage imageNamed:@"detail"]];
        
        return cell;
        
    }else{
        
        BBDHomeApplyCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDHomeApplyCell class])];
        
        cell.titleLabel.text = _dataArr[indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                cell.detailLabel.text = _applyModel.feature;
                break;
            case 1:
                cell.detailLabel.text = _applyModel.condition;
                break;
            case 2:
                cell.detailLabel.text = _applyModel.des;
                break;
        }
        
        return cell;
    }
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row>=_dataArr.count-1) {
        
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: _applyModel.flowchart_img];
        
        if (!image)
            image = [UIImage imageNamed:@"detail"];
        
        CGFloat imageHeight =  SCREEN_WIDTH * image.size.height / image.size.width;
        
        return imageHeight+45;
        
    }else{
        
        NSString *title;
        switch (indexPath.row) {
            case 0:
                title = _applyModel.feature;
                break;
            case 1:
                title = _applyModel.condition;
                break;
            case 2:
                title = _applyModel.des;
                break;
        }
        
        // UIlabel自适应高度
        CGSize size = [title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                          context:nil].size;
        return size.height+50;
    }
    
}

#pragma mark - 立即申请
-(void)apply{
    
//    NSArray *array = @[@"BBDFastLoanApplyController",
//                       @"BBDCarLoanApplyController",
//                       @"BBDCommonLoanApplyController"];
//    
//    [self.navigationController pushViewController:[[NSClassFromString(@"BBDCommonLoanApplyController") alloc] init] animated:YES];
    BBDSelectMoneyViewController * vc = [[BBDSelectMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
