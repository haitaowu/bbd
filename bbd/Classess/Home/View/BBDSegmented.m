//
//  BBDSegmented.m
//  bbd
//
//  Created by Lei Xu on 2017/1/3.
//  Copyright © 2017年 韩加宇. All rights reserved.
//

#import "BBDSegmented.h"

@interface BBDSegmented()
@property(nonatomic,weak) UIButton *selectBtn;
@end

@implementation BBDSegmented


-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    
    return _contentView;
}


-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    
    _edgeInsets = edgeInsets;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(edgeInsets.top);
        make.right.mas_equalTo(edgeInsets.right);
        make.left.mas_equalTo(edgeInsets.left);
        make.bottom.mas_equalTo(edgeInsets.bottom);
        
    }];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.selectIndex = -1;
    }
    
    return self;
}



-(void)setItmes:(NSArray *)itmes{
    
    _itmes = itmes;
    
    for (int i = 0; i<itmes.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:itmes[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage imageNamed:@"home_button_icon_click"] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage imageNamed:@"home_car_buttom_icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat gap = 10;
    
    CGFloat width = (self.contentView.width - gap*(self.itmes.count-1))/self.itmes.count;
    
    for (int i = 0 ; i<self.itmes.count; i++) {
        
        UIButton *button = self.contentView.subviews[i];
        
        button.frame = CGRectMake((width+10)*i, 0, width, self.height);
        
        if (i == self.selectIndex) {
            
            [self changeBtn:button];
            
        }
    }
    
}


-(void)changeBtn:(UIButton*)btn{
    
    for (int i = 0; i<self.contentView.subviews.count; i++) {
        if ([btn isEqual:self.contentView.subviews[i]]) {
            self.selectIndex = i;
            break;
        }
    }
    _selectBtn.enabled = YES;
    _selectBtn = btn;
    _selectBtn.enabled = NO;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];

}

@end
