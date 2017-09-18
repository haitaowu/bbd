//
//  BBDIdentityMessageController.m
//  bbd
//
//  Created by Lei Xu on 2016/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDFastLoanApplyController.h"
#import "BBDIDPictureView.h"
#import "BBDYCTableViewCell.h"
#import "UIAlertController+Category.h"
#import "BBDPhoneVerifyController.h"
#import "XLNetworking.h"
#import "UIImage+Category.h"

@interface BBDFastLoanApplyController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,KeyBoardHideDelegate>
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UIImagePickerController *imagePicker;
@property(nonatomic,weak)  BBDIDPictureView *pictureView;
@property(nonatomic,strong) NSMutableArray *messageArray;
@property(nonatomic,strong) NSMutableArray *imageArray;


@end

@implementation BBDFastLoanApplyController

-(NSMutableArray *)imageArray{
    
    if (_imageArray == nil) {
        
        /** 
         *   创建二维数组
         *   @[@[1,2],
         *     @[3,4]]
         */

        NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"",@"",nil];
        NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"",@"",nil];
        _imageArray = [NSMutableArray arrayWithObjects:array1,array2,nil];
        
    }
    
    return _imageArray;
}

-(NSMutableArray *)messageArray{
    
    if (_messageArray == nil) {
        
        _messageArray = [NSMutableArray arrayWithObjects:@"",@"",self.imageArray,@"",@"",@"", nil];
    }
    
    return _messageArray;
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
    
    _dataArr = @[@{@"title":@"真实姓名",
                   @"placeholder":@"与身份证上姓名一致"},
                 @{@"title":@"身份证号",
                   @"placeholder":@""},
                 @{@"title":@"身份证照",
                   @"placeholder":@""},
                 @{@"title":@"身份证地址",
                   @"placeholder":@"身份证显示地址"},
                 @{@"title":@"出身年月日",
                   @"placeholder":@"与身份证上一致"},
                 @{@"title":@"实际居住地址",
                   @"placeholder":@""},];

    [self setupUI];
    
}


-(void)setupUI{
    
    self.navigationItem.title = @"身份信息申请";
    self.keyboardNote = YES;
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
    static NSString *const cellID = @"cell";
    
    BBDYCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell){
        cell = [[BBDYCTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 2) {
            
            BBDIDPictureView *pictureView = [[BBDIDPictureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.52, 200)];
            
            pictureView.items = @[@[@"home_apply_id1_icon",@"home_apply_id2_icon"],
                                  @[@"home_apply_id3_icon",@"home_apply_id4_icon"]];
            
            pictureView.textLabel.text = @"提醒：身份证上的所有信息清晰可见；照片需免冠，手持证件人的五官清晰可见；照片内容真实有效，不得做任何修改；支持jpg,jpge,png格式照片,大小不超过5M";
            
            pictureView.edgeInsets = UIEdgeInsetsMake(5, -SCREEN_WIDTH*0.4, 0, 0);
            
            [pictureView addTarget:self action:@selector(chooseIDPictrue:) forControlEvents:UIControlEventTouchUpInside];
            
            _pictureView = pictureView;
            
            cell.accessoryView = pictureView;
            cell.cellType = OtherType;
            
        }else{
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.52, 30)];
            [textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
            textField.placeholder = _dataArr[indexPath.row][@"placeholder"];
            textField.backgroundColor = [UIColor whiteColor];
            textField.font = [UIFont systemFontOfSize:13];
            textField.borderStyle = UITextBorderStyleBezel;
            
            // 为textField弹出键盘在上面添加自定义view;
            textField.inputAccessoryView = self.hideToolBar;
            
            cell.accessoryView = textField;
            cell.cellType = TextFieldType;
        }
        
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_apply_%ld_icon",indexPath.row+1]];
    cell.textLabel.text =_dataArr[indexPath.row][@"title"];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row == 2 ? 200 : 60;

}


-(void)changeText:(UITextField *)textField{
    
    // 通过textField获取 cell
    BBDYCTableViewCell *cell = (BBDYCTableViewCell*)[textField superview];
    
    // 通过cell获取 indexPath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    self.messageArray[indexPath.row] = textField.text;
    
    [self judgeFillMessageFinsh];
    
}


#pragma mark - 下一步
-(void)next{

    BBDPhoneVerifyController *phoneVerifyVC = [[BBDPhoneVerifyController alloc] init];
    phoneVerifyVC.fastLoanApplyArr = self.messageArray;
    [self.navigationController pushViewController:phoneVerifyVC animated:YES];
}

-(void)chooseIDPictrue:(BBDIDPictureView*)view{
    
    UIAlertController *alert = [UIAlertController getImagePickerAlert:self.imagePicker withTarget:self];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [_pictureView.selectBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *newImage = [UIImage imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    
    NSData *imageData = UIImagePNGRepresentation(newImage) == nil?UIImageJPEGRepresentation(newImage, 1):UIImagePNGRepresentation(newImage);

    
    //  pictureView 选中的button复制给btn上传图片，并显示进度，防止因为线程问题导致selectBtn对应的信息错乱
    UIButton *btn = _pictureView.selectBtn;
    
    //  上传图片就将图片数组对应的index清除 (为重复上传做准备)
    self.imageArray[btn.tag/10-1][btn.tag%10-1] = @"";
    
    self.bottomButton.enabled = NO;
    
    [XLNetworking uploadFileData:imageData andFileType:PhotosFile progress:^(double progress) {
        
        // btn 显示上传进度
        [btn setTitle:[NSString stringWithFormat:@"%.0f%%",progress] forState:UIControlStateNormal];
        
    } success:^(NSString *url, BOOL success) {
        if (success) {
            
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            
            //  button的tag = (row+1*10)+(col+1) 从11开始，及对应第1行第1列
            self.imageArray[btn.tag/10-1][btn.tag%10-1] = url;
            
            // self.imageArray 有改变就判断信息是否全部填写
            [self judgeFillMessageFinsh];
            
        }else{
            [btn setTitle:@"上传失败" forState:UIControlStateNormal];
        }
    }];
}



/** 判断信息是否全部填写 */
-(void)judgeFillMessageFinsh{
    
    
    // 筛选是否有未填写的内容，有就返回，若没有 “下一步”则打开
    
    for (int i = 0; i<self.messageArray.count; i++) {
        if (i == 2) {
            for (int j = 0; j<self.imageArray.count; j++) {
                for (NSString *title in self.imageArray[j]) {
                    if (title.length<=0) {
                        self.bottomButton.enabled = NO;
                        return;
                    }
                }
            }
        }else{
            if ([self.messageArray[i] length]<=0) {
                self.bottomButton.enabled = NO;
                return;
            }
        }
    }
    
    self.bottomButton.enabled = YES;
    
}

@end
