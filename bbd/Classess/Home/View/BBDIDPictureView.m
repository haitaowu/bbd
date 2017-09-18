//
//  BBDIDPictureView.m
//  bbd
//
//  Created by Lei Xu on 2016/12/30.
//  Copyright © 2016年 韩加宇. All rights reserved.
//

#import "BBDIDPictureView.h"

@implementation BBDIDPictureView


-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        // 默认为{0，0，0，0}
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    return self;
}


-(UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor darkGrayColor];
        _textLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_textLabel];
    }
    
    return _textLabel;
}

-(UIView *)contentView{
    
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
        }];
    }
    return _contentView;
}


-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    
    _edgeInsets = edgeInsets;
    
    CGSize size = [self.textLabel sizeThatFits:CGSizeMake(self.width - _edgeInsets.left, MAXFLOAT)];
    
    [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(_edgeInsets.top);
        make.right.mas_equalTo(_edgeInsets.right);
        make.left.mas_equalTo(_edgeInsets.left);
        make.bottom.mas_equalTo(_edgeInsets.bottom);
        make.height.mas_equalTo(size.height);
    }];
    
}


-(void)setItems:(NSArray *)items{
    _items = items;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    CGFloat gap = 10;
    CGFloat width = (self.contentView.height - gap*(_items.count-1))/_items.count;
    CGFloat height = width;
    [_items enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger i, BOOL * _Nonnull stop1) {
        [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger j, BOOL * _Nonnull stop2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            
            // btn.tag 代表了btn的位置，从 11-->(1，1）开始
            btn.tag = (i+1)*10+(j+1);
            
            [btn setBackgroundImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(buttonpress:) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat x =(width+gap)*j;
            CGFloat y = (width+gap)*i;
            btn.width = width;
            btn.height = height;
            btn.x = x;
            btn.y = y;
            [self.contentView addSubview:btn];

            
        }];
        
    }];
    
}

-(void)buttonpress:(UIButton*)btn{
    
    BtnIndex index = {btn.tag/10,btn.tag%10};
    self.btnIndex = index;
    self.selectBtn = btn;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    BtnIndex index = {0,0};
    self.btnIndex = index;
    self.selectBtn = nil;
}

@end
