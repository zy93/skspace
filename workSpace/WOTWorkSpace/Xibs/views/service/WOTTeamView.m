//
//  WOTTeamView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTTeamView.h"

@implementation WOTTeamView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    [self addSubview:self.bgView];
    self.iconIV = [[UIImageView alloc] init];
    self.iconIV.layer.cornerRadius = 55/2;
    self.iconIV.clipsToBounds = YES;
    [self.iconIV setImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
    [self.bgView addSubview:self.iconIV];
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.text = @"张三";
    self.titleLab.font = [UIFont systemFontOfSize:12.f];
    [self.bgView addSubview:self.titleLab];
    self.subtitleLab = [[UILabel alloc] init];
    
    self.subtitleLab.text = @"社区经理";
    self.subtitleLab.font = [UIFont systemFontOfSize:12.f];
    self.subtitleLab.textColor = UICOLOR_GRAY_66;
    [self.bgView addSubview:self.subtitleLab];
    self.contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.contactBtn.backgroundColor = [UIColor blackColor];
    self.contactBtn.layer.cornerRadius = 2.5f;
    [self.contactBtn setTitle:@"联系他" forState:UIControlStateNormal];
    [self.contactBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [self.contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bgView addSubview:self.contactBtn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(55);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIV.mas_bottom).with.offset(13);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
    [self.subtitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom).with.offset(-10);
//        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(28);
        make.left.mas_equalTo(16);
        make.right.equalTo(self.bgView.mas_right).with.offset(-16);
    }];
    
}

@end
