//
//  BBDItemModel.h
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

#import <Foundation/Foundation.h>

@interface BBDItemModel : NSObject

/**图片*/
@property (nonatomic,copy) NSString * image;
/**标题*/
@property (nonatomic,copy) NSString * title;
/**跳转控制器*/
@property (nonatomic,strong) Class className;

-(instancetype)initWithImage:(NSString *)image title:(NSString *)title class:(Class)class;

@end

/**cell 行模型*/
@interface BBDApplyItem : NSObject

typedef enum{
    BBDApplyItemTypeDefault,
    BBDApplyItemTypeTitle,
    BBDApplyItemTypeOneImage,
    BBDApplyItemTypeFourImage
}BBDApplyItemType;

@property (nonatomic,copy) NSString * nameStr;

@property (nonatomic,copy) NSString * detailStr;

@property (nonatomic,copy) NSString * keyStr;

@property (nonatomic,assign) BBDApplyItemType type;

-(instancetype)initWithKey:(NSString *)key type:(BBDApplyItemType)type;

+(NSMutableArray *)itemArrayWithType:(int)type;

+(NSMutableArray *)userDataArray;

@end

/**cell 组模型*/
@interface BBDApplyGroup : NSObject

@property (nonatomic,strong) NSArray * itemArray;

@property (nonatomic,copy) NSString * title;

-(instancetype)initWithItemArray:(NSArray *)itemArray title:(NSString *)title;

@end
