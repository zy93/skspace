//
//  WOTFacilitiesView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTFacilitiesView.h"

@implementation WOTFacilitiesView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

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
    self.image = [[UIImageView alloc] init];
    [self addSubview:self.image];
    self.lab = [[UILabel alloc] init];
    self.lab.font = [UIFont systemFontOfSize:11.f];
    self.lab.textColor = UICOLOR_GRAY_99;
    [self addSubview:self.lab];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(33);
    }];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.image.mas_bottom).with.offset(5);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
