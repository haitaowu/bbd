//
//  BBDCommonLoanApplyController.m
//  bbd
//
//  Created by Lei Xu on 2017/1/5.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDCommonLoanApplyController.h"
#import "BBDCarFillBankCardController.h"
#import "BBDCommonPhoneVerifyController.h"
#import "BBDCommonLoanApplySectionView.h"
#import "BBDCommonLoanApplyTextFieldCell.h"
#import "BBDCommonLoanApplyTextFieldOtherCell.h"
#import "BBDCommonLoanApplySegmentCell.h"
#import "BBDCommonLoanApplyPictureCell.h"
#import "BBDCommonLoanApplyModel.h"
#import <MJExtension.h>
#import "UIAlertController+Category.h"
#import "XLNetworking.h"
#import "UIImage+Category.h"

@interface BBDCommonLoanApplyController ()<UITableViewDelegate,UITableViewDataSource,KeyBoardHideDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIImagePickerController *imagePicker;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,weak) BBDIDPictureView *pictureView;
@property(nonatomic,strong) NSMutableArray *messageArr;
@property(nonatomic,strong) NSMutableArray *imageArr;

@end

@implementation BBDCommonLoanApplyController


/*
 * 三维数组（图片） (对应tableView的 section 和 row)
 *   样式 :
 *   @[@[@[@"",@""],
 *     @[@"",@""]],
 *     @[@[@""]],
 *     @[@[@""]]]
 */

-(NSMutableArray *)imageArr{
    if (_imageArr == nil) {
    
        NSMutableArray *array00 = [NSMutableArray arrayWithObjects:@"",@"",nil];
        NSMutableArray *array01 = [NSMutableArray arrayWithObjects:@"",@"",nil];
        NSMutableArray *array0 = [NSMutableArray arrayWithObjects:array00,array01,nil];
        
        NSMutableArray *array10 = [NSMutableArray arrayWithObjects:@"", nil];
        NSMutableArray *array1 = [NSMutableArray arrayWithObjects:array10, nil];
        
        NSMutableArray *array20 = [NSMutableArray arrayWithObjects:@"", nil];
        NSMutableArray *array2 = [NSMutableArray arrayWithObjects:array20, nil];
        
        _imageArr = [NSMutableArray arrayWithObjects:array0,array1,array2,nil];
        
    }
    return _imageArr;
}

/*
 * 所有填写信息
 */
-(NSMutableArray *)messageArr{
    if (_messageArr == nil) {
        
        NSMutableArray *array0 = [NSMutableArray arrayWithObjects:@"3",@"0", nil];
        NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"", nil];
        NSMutableArray *array3 = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
        NSMutableArray *array4 = [NSMutableArray arrayWithObjects:@"",@"",@"",nil];
        
        _messageArr = [NSMutableArray arrayWithObjects:array0,array1,self.imageArr,array3,array4,nil];
    }
    
    return _messageArr;
}

-(UIImagePickerController *)imagePicker{
    
    if (_imagePicker == nil) {
        
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    
    return _imagePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"身份信息申请";

    [self loadData];
    [self setupUI];
    
}

-(void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CommonLoanPlist" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _dataArray = [BBDCommonLoanApplyModel mj_objectArrayWithKeyValuesArray:array];
}


-(void)setupUI{
    
    self.keyboardNote = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];

    [self.tableView registerClass:[BBDCommonLoanApplySegmentCell class] forCellReuseIdentifier:NSStringFromClass([BBDCommonLoanApplySegmentCell class])];
    
    [self.tableView registerClass:[BBDCommonLoanApplyTextFieldCell class] forCellReuseIdentifier:NSStringFromClass([BBDCommonLoanApplyTextFieldCell class])];
    
    [self.tableView registerClass:[BBDCommonLoanApplyPictureCell class] forCellReuseIdentifier:NSStringFromClass([BBDCommonLoanApplyPictureCell class])];
    
    [self.tableView registerClass:[BBDCommonLoanApplyTextFieldOtherCell class] forCellReuseIdentifier:NSStringFromClass([BBDCommonLoanApplyTextFieldOtherCell class])];

    

    
}

#pragma mark -  下一步
-(void)next{
    
    BBDCarFillBankCardController *fillBankCardVC = [[BBDCarFillBankCardController alloc] init];
    fillBankCardVC.className = [BBDCommonPhoneVerifyController class];
    fillBankCardVC.carLoanApplyArr = self.messageArr;
    fillBankCardVC.moneyID = self.moneyID;
    [self.navigationController pushViewController:fillBankCardVC animated:YES];
    
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    BBDCommonLoanApplyModel *model = _dataArray[section];
    return model.body.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBDCommonLoanApplyModel *model = _dataArray[indexPath.section];
    Body *body = model.body[indexPath.row];
    
    if (indexPath.section == 0) {
        
        BBDCommonLoanApplySegmentCell *segmentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCommonLoanApplySegmentCell class])];
        
        segmentCell.titleLabel.text = body.subTitle;
        segmentCell.segmented.itmes = body.data;

        CGFloat right = indexPath.row == 0?0:-80;
        
        segmentCell.segmented.edgeInsets = UIEdgeInsetsMake(0, 0, 0, right);
        
        [segmentCell.segmented addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventTouchUpInside];
        
        segmentCell.segmented.selectIndex = indexPath.row == 0 ? 3:0;
                
        return segmentCell;
        
    }else if (indexPath.section == 1){
        BBDCommonLoanApplyTextFieldOtherCell *textFieldOtherCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCommonLoanApplyTextFieldOtherCell class])];
        
        textFieldOtherCell.titleLabel.text = body.subTitle;
        
        // 为textField弹出键盘在上面添加自定义view;
        textFieldOtherCell.textField.inputAccessoryView = self.hideToolBar;
        
        [textFieldOtherCell.textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
        
        return textFieldOtherCell;
        
    }else if (indexPath.section == 2){
        
        BBDCommonLoanApplyPictureCell *pictureCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCommonLoanApplyPictureCell class])];
        pictureCell.contentView.backgroundColor = [UIColor whiteColor];

        pictureCell.titleLabel.text = body.subTitle;
        pictureCell.pictureView.items = body.data;
        [pictureCell.pictureView addTarget:self action:@selector(chooseIDPictrue:) forControlEvents:UIControlEventTouchUpInside];
        pictureCell.detalLabel.text = body.detail;
        
        return pictureCell;
        
    }else{
        
        BBDCommonLoanApplyTextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBDCommonLoanApplyTextFieldCell class])];

        textFieldCell.titleLabel.text = body.subTitle;

        // 为textField弹出键盘在上面添加自定义view;
        textFieldCell.textField.inputAccessoryView = self.hideToolBar;
        
        [textFieldCell.textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
        textFieldCell.textField.text =self.messageArr[indexPath.section][indexPath.row];
        
        return textFieldCell;
    }
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return section == _dataArray.count-1?0:5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBDCommonLoanApplyModel *model = _dataArray[indexPath.section];
    Body *body = model.body[indexPath.row];
    
    return [body.height intValue];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BBDCommonLoanApplySectionView *headerView = [[BBDCommonLoanApplySectionView alloc] init];
    
    headerView.backgroundColor = [UIColor whiteColor];
    BBDCommonLoanApplyModel *model = _dataArray[section];
    headerView.titleLabe.text = model.title;
    headerView.detailLabel.text = model.detail;
    headerView.imageView.image = [UIImage imageNamed:@"home_extreme_arrow_icon"];
    
    return headerView;
}



-(void)changeText:(UITextField *)textField{
    
    UITableViewCell *cell = (UITableViewCell*)[[textField superview] superview];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.messageArr[indexPath.section][indexPath.row] = textField.text;
    
    [self judgeFillMessageFinsh];
}

/** segment监听 */
- (void) changeSegment:(BBDSegmented *)segment {
    
    BBDCommonLoanApplySegmentCell *cell = (BBDCommonLoanApplySegmentCell*)[[segment superview] superview];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSLog(@"%ld",segment.selectIndex);
    
    self.messageArr[indexPath.section][indexPath.row] = [NSString stringWithFormat:@"%ld",segment.selectIndex];

    [self judgeFillMessageFinsh];
}

-(void)chooseIDPictrue:(BBDIDPictureView*)view{
    
    _pictureView = view;
    UIAlertController *alert = [UIAlertController getImagePickerAlert:self.imagePicker withTarget:self];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    BBDCommonLoanApplyPictureCell *cell = (BBDCommonLoanApplyPictureCell*)[[[_pictureView superview] superview] superview];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    [_pictureView.selectBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *newImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    
    NSData *imageData = UIImagePNGRepresentation(newImage) == nil?UIImageJPEGRepresentation(newImage, 1):UIImagePNGRepresentation(newImage);
    
    
    //  pictureView 选中的button复制给btn上传图片，并显示进度，防止因为线程问题导致selectBtn对应的信息错乱
    UIButton *btn = _pictureView.selectBtn;
    
    //  上传图片就将图片数组对应的index清除 (为重复上传就清除)
    self.imageArr[indexPath.row][btn.tag/10-1][btn.tag%10-1] = @"";
    
    self.bottomButton.enabled = NO;
    
    [XLNetworking uploadFileData:imageData andFileType:PhotosFile progress:^(double progress) {
        
        // btn 显示上传进度
        [btn setTitle:[NSString stringWithFormat:@"%.0f%%",progress] forState:UIControlStateNormal];
        
    } success:^(NSString *url, BOOL success) {
        if (success) {
            
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            
            //  button的tag = (row+1*10)+(col+1) 从11开始，及对应第1行第1列
            self.imageArr[indexPath.row][btn.tag/10-1][btn.tag%10-1] = url;

            // self.imageArray 有改变就判断信息是否全部填写
            [self judgeFillMessageFinsh];
            
        }else{
            [btn setTitle:@"上传失败" forState:UIControlStateNormal];
        }
    }];
}

-(void)judgeFillMessageFinsh{


    for (int i = 0; i<self.messageArr.count; i++) {
        if (i == 2) {
            int imageCount = 0;
            for (int j = 0; j<self.imageArr.count; j++) {
                BOOL imageBool = YES;
                NSArray *array1 = self.imageArr[j];
                for (int k = 0; k<array1.count; k++) {
                    NSArray *array2 = array1[k];
                    for (NSString *title in array2) {
                        if (title.length<=0) {
                            imageBool = NO;
                            break;
                        }
                    }
                }
                if (imageBool == YES) {
                    imageCount++;
                }
            }
            if (imageCount<=0) {
                self.bottomButton.enabled = NO;
                return;
            }
        }else{
            NSArray *array0 = self.messageArr[i];
            for (NSString *text in array0) {
                if (text.length<=0) {
                    self.bottomButton.enabled = NO;
                    return;
                }
            }
        }
    }
    
    self.bottomButton.enabled = YES;
    
}

@end
