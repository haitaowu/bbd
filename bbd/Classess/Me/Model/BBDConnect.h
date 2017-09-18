//
//  BBDConnect.h
//  bbd
//
//  Created by Mr.Wang on 2017/5/23.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface BBDConnect : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;

+(NSArray *)connectArray;

@end
