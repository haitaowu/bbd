//
//  BBDItemModel.m
//  bbd

/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */

//  Created by Mr.Wang on 16/12/29.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDItemModel.h"

#define BBDItemInit [BBDApplyItem alloc]initWithKey
#define BBDGroupInit [BBDApplyGroup alloc]initWithItemArray

@implementation BBDItemModel

-(instancetype)initWithImage:(NSString *)image title:(NSString *)title class:(Class)class
{
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.className = class;
    }
    return self;
}

@end

@implementation BBDApplyItem

-(instancetype)initWithKey:(NSString *)key type:(BBDApplyItemType)type
{
    self = [super init];
    if (self) {
        self.keyStr = key;
        self.type = type;
    }
    return self;
}

+(NSMutableArray *)itemArrayWithType:(int)type
{
    NSMutableArray * array = [NSMutableArray array];
    
    BBDApplyGroup * defaultGroup = [BBDGroupInit:@[[BBDItemInit:nil type:BBDApplyItemTypeDefault]]
                                           title:nil];
    [array addObject:defaultGroup];
    
    if (type == 1) {//普通贷
        
        //个人信息
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"education" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"marriage" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"phone" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"cart_number" type:BBDApplyItemTypeTitle]]
                                 title:@"个人信息"]];
        
        //征信验证
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"credit" type:BBDApplyItemTypeTitle]]
                                 title:@"征信验证"]];
        
        //资料
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"idCardNumber" type:BBDApplyItemTypeFourImage],
                                         [BBDItemInit:@"wages_img" type:BBDApplyItemTypeOneImage],
                                         [BBDItemInit:@"credit_report" type:BBDApplyItemTypeOneImage]]
                                 title:@"资料"]];
        
        //工作信息
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"work_unit" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"work_address" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"work_tel" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"work_post" type:BBDApplyItemTypeTitle]]
                                 title:@"工作信息"]];
        
        //联系人信息
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"contacts_name" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"contacts_phone" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"contacts_address" type:BBDApplyItemTypeTitle]]
                                 title:@"联系人信息"]];
        
        //放款账号
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"advance_number" type:BBDApplyItemTypeTitle]]
                                 title:@"放款账号"]];
        
    }else if (type == 0){//汽车贷
        
        //汽车信息
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"car_type" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"car_date" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"vin_number" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"phone" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"cart_number" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"idCardNumber" type:BBDApplyItemTypeFourImage]]
                                 title:@"汽车信息"]];
        
        //放款账号
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"advance_number" type:BBDApplyItemTypeTitle]]
                                 title:@"放款账号"]];
        
    }else if (type == 2){//极速贷
        
        //个人信息
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"name" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"cart_number" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"idCardNumber" type:BBDApplyItemTypeFourImage],
                                         [BBDItemInit:@"cart_address" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"birthday" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"address" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"phone" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"taobao_account" type:BBDApplyItemTypeTitle],
                                         [BBDItemInit:@"alipay_account" type:BBDApplyItemTypeTitle]]
                                 title:@"个人信息"]];
        
        //放款账号
        [array addObject:[BBDGroupInit:@[[BBDItemInit:@"bank_no" type:BBDApplyItemTypeTitle]]
                                 title:@"放款账号"]];
        
    }
    
    return array;
}

+(NSMutableArray *)userDataArray
{
    NSMutableArray * array = [NSMutableArray array];

    [array addObject:[BBDGroupInit:@[[BBDItemInit:@"nickname" type:0],
                                     [BBDItemInit:@"cart_number" type:0],
                                     [BBDItemInit:@"birthday" type:0],
                                     [BBDItemInit:@"address" type:0]]
                             title:@"个人信息"]];
    
    [array addObject:[BBDGroupInit:@[[BBDItemInit:@"phone" type:0],
                                     [BBDItemInit:@"password" type:0],
                                     [BBDItemInit:@"gesture" type:0]]
                             title:@"账号信息"]];
    
    return array;
}

@end

@implementation BBDApplyGroup

-(instancetype)initWithItemArray:(NSArray *)itemArray title:(NSString *)title
{
    self = [super init];
    if (self) {
        
        self.itemArray = itemArray;
        self.title = title;
    }
    return self;
}

@end
