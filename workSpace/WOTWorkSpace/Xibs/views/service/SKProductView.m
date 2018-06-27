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
    self.topIV = [[UIImageView alloc] init];
    self.topIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.topIV.layer.borderWidth =.5f;
    [self addSubview:self.topIV];
    self.iconIV = [[UIImageView alloc] init];
//    self.iconIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    
    self.iconIV.size = CGSizeMake(60, 60);
    self.iconIV.layer.cornerRadius=30.f;
    self.iconIV.clipsToBounds=YES;
    [self addSubview:self.iconIV];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.titleLab.textColor = UICOLOR_MAIN_TEXT;
    [self addSubview:self.titleLab];
    
    self.priceLab = [[UILabel alloc] init];
    self.priceLab.font = [UIFont systemFontOfSize:13.f];
    self.priceLab.textColor = UICOLOR_GRAY_66;
    [self addSubview:self.priceLab];
    
    [self.topIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        //        make.bottom.equalTo(self.iconIV.mas_top);
    }];

    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.height.mas_offset(60);
        make.width.mas_offset(60);
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIV.mas_bottom).with.offset(5);
        make.centerX.equalTo(self);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(5);
        make.centerX.equalTo(self);
    }];
}
@end
