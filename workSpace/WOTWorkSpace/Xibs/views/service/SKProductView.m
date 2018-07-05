//
//  SKProductView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 26/6/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKProductView.h"

@implementation SKProductView

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
//    self.topIV = [[UIImageView alloc] init];
//    self.topIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
//    self.topIV.layer.borderWidth =.5f;
//    [self addSubview:self.topIV];
    self.iconIV = [[UIImageView alloc] init];
    
    self.iconIV.size = CGSizeMake(([[UIScreen mainScreen] bounds].size.width - 40)/2-80, ([[UIScreen mainScreen] bounds].size.width - 40)/2-80);
    self.iconIV.layer.cornerRadius=(([[UIScreen mainScreen] bounds].size.width - 40)/2-80)/2;
    self.iconIV.layer.borderColor = UICOLOR_E8.CGColor;
    self.iconIV.layer.borderWidth = 1.f;
    self.iconIV.clipsToBounds=YES;
    [self addSubview:self.iconIV];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
    self.titleLab.textColor = UICOLOR_MAIN_TEXT;
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    
    self.priceLab = [[UILabel alloc] init];
    self.priceLab.font = [UIFont systemFontOfSize:12.f];
    self.priceLab.textColor = UICOLOR_GRAY_66;
    [self addSubview:self.priceLab];
    
//    [self.topIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(0);
//        make.left.mas_offset(0);
//        make.right.mas_offset(0);
//    }];

    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.centerX.equalTo(self);
        make.left.equalTo(self).with.offset(40);
        make.right.equalTo(self).with.offset(-40);
        make.height.equalTo(self.iconIV.mas_width); 
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIV.mas_bottom).with.offset(5);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.centerX.equalTo(self);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(5);
        make.centerX.equalTo(self);
    }];
}
@end
