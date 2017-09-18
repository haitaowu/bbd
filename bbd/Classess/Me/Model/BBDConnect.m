//
//  BBDConnect.m
//  bbd
//
//  Created by Mr.Wang on 2017/5/23.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDConnect.h"

@implementation BBDConnect

+(NSArray *)connectArray
{
    NSMutableArray * array = [NSMutableArray array];
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus != kABAuthorizationStatusAuthorized) {
        NSLog(@"没有授权");
        return nil;
    }
    
    // 2. 获取所有联系人
    CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(ABAddressBookCreate());
    long count = CFArrayGetCount(arrayRef);
    for (int i = 0; i < count; i++) {
        //获取联系人对象的引用
        ABRecordRef people = CFArrayGetValueAtIndex(arrayRef, i);
         [array addObject:[[BBDConnect alloc]initWithPeople:people]];
    }
    return array;
}

-(instancetype)initWithPeople:(ABRecordRef)people
{
    self = [super init];
    if (self) {
        
        //获取当前联系人名字
        NSString *firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        
        //获取当前联系人姓氏
        NSString *lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        //获取当前联系人的电话数组
        NSMutableArray *phoneArray = [[NSMutableArray alloc]init];
        ABMultiValueRef phones = ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            [phoneArray addObject:phone];
        }
        
        self.name = [NSString stringWithFormat:@"%@%@",firstName == nil? @"" : [NSString stringWithFormat:@"%@  ",firstName],lastName == nil? @"" : lastName];
        if (phoneArray.count>0) {
            self.phone = phoneArray[0];
        }
        
    }
    return self;
}

@end
