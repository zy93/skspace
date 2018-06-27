//
//  SKServiceProvidersView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/12.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKServiceProvidersView.h"

@implementation SKServiceProvidersView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.topIV = [[UIImageView alloc] init];
    self.topIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.topIV.layer.borderWidth =.5f;
    [self addSubview:self.topIV];
    
    self.iconIV = [[UIImageView alloc] init];
    self.iconIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.iconIV.layer.borderWidth = .5f;
    [self addSubview:self.iconIV];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15.f];
    self.titleLab.textColor = UICOLOR_MAIN_TEXT;
    [self addSubview:self.titleLab];
    
    self.subtitleLab = [[UILabel alloc] init];
    self.subtitleLab.font = [UIFont systemFontOfSize:13.f];
    self.subtitleLab.textColor = UICOLOR_GRAY_66;
    [self addSubview:self.subtitleLab];
    
    [self.topIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
//        make.bottom.equalTo(self.iconIV.mas_top);
    }];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topIV.mas_bottom).with.offset(10);
        make.left.equalTo(self.topIV.mas_left);
        make.height.mas_offset(50);
        make.width.mas_offset(50);
        make.bottom.mas_offset(0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIV.mas_top);
        make.left.equalTo(self.iconIV.mas_right).with.offset(10);
//        make.right.mas_offset(10);
//        make.bottom.mas_offset(10);
    }];
    
    [self.subtitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(10);
        make.left.equalTo(self.titleLab.mas_left);
//        make.right.mas_offset(10);
//        make.bottom.mas_offset(10);
    }];
}

@end
