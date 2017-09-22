//
//  BBDAuthenPhoneSuccController.m
//  bbd
//
//  Created by taotao on 2017/9/22.
//  Copyright © 2017年 WT. All rights reserved.
//

#import "BBDAuthenPhoneSuccController.h"

@interface BBDAuthenPhoneSuccController ()

@end

@implementation BBDAuthenPhoneSuccController

#pragma mark - override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
}

#pragma mark - selectors
- (IBAction)clickBackBtn:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end
