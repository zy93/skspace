//
//  WOTServiceProvidersView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTServiceProvidersView.h"

@interface WOTServiceProvidersView()

@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subtitleLab;
@property (nonatomic, strong) UILabel *projectNameLab;

@end


@implementation WOTServiceProvidersView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
        self.layer.borderWidth = 1.f;
        self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        self.topBgView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
        [self addSubview:self.topBgView];
        
        self.iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(22, 22, 55, 55)];
        [self.iconIV setImage:[UIImage imageNamed:@"placeholder_logo"]];
        self.iconIV.layer.cornerRadius = _iconIV.size.height/2;
        self.iconIV.clipsToBounds = YES;
        [self.topBgView addSubview:self.iconIV];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconIV.frame)+15, 22, 200, 18)];
        [self.titleLab setText:@"易联港"];
        [self.titleLab setFont:[UIFont boldSystemFontOfSize:16.f]];
        [self.topBgView addSubview:self.titleLab];
        
        self.subtitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconIV.frame)+15, CGRectGetMaxY(self.titleLab.frame)+7, 4*13.f, 18)];
        [self.subtitleLab setText:@"物联网"];
        [self.subtitleLab setFont:[UIFont systemFontOfSize:12.f]];
        [self.subtitleLab setTextAlignment:NSTextAlignmentCenter];
        [self.subtitleLab.layer setCornerRadius:5.f];
        [self.subtitleLab setBackgroundColor:[UIColor whiteColor]];
        [self.topBgView addSubview:self.subtitleLab];
        
        self.projectNameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.topBgView.frame)+15, 120, 18)];
        [self.projectNameLab setText:@"服务项目"];
        [self.projectNameLab setTextColor:UICOLOR_MAIN_BACKGROUND];
        [self addSubview:self.projectNameLab];
        
        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.projectNameLab.frame), CGRectGetMaxY(self.projectNameLab.frame)+13, 5*17, 25)];
        [la setTextAlignment:NSTextAlignmentCenter];
        [la setTextColor:UICOLOR_MAIN_BACKGROUND];
        [la.layer setCornerRadius:25/2];
        [la.layer setBorderColor:UICOLOR_MAIN_BACKGROUND.CGColor];
        [la.layer setBorderWidth:1.f];
        [la setFont:[UIFont systemFontOfSize:13.f]];
        [la setText:@"代理记账"];
        [self addSubview:la];
    }
    return self;
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
