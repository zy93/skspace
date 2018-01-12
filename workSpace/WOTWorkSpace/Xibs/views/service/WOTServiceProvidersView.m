//
//  WOTServiceProvidersView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTServiceProvidersView.h"

@interface WOTServiceProvidersView()

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
        [self.subtitleLab setText:@"物联网"];//经营范围
        [self.subtitleLab setFont:[UIFont systemFontOfSize:12.f]];
        [self.subtitleLab setTextAlignment:NSTextAlignmentCenter];
        [self.subtitleLab.layer setCornerRadius:5.f];
        [self.subtitleLab setBackgroundColor:[UIColor whiteColor]];
        [self.topBgView addSubview:self.subtitleLab];
        
        self.projectNameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.topBgView.frame), 120, 18)];//+15
        [self.projectNameLab setText:@"服务项目"];//类别
        [self.projectNameLab setTextColor:UICOLOR_GRAY_99];
        [self addSubview:self.projectNameLab];
        
        
    }
    return self;
}

-(void)setData:(SKFacilitatorInfoModel *)facilitatorInfoModel
{
    CGFloat labelWith = 0;
    CGFloat labelHeight = 0;
    NSArray  *array = [facilitatorInfoModel.facilitatorType componentsSeparatedByString:@","];
    for (int i = 0; i<array.count; i++) {
        if (i == 3) {
            UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.projectNameLab.frame), CGRectGetMaxY(self.projectNameLab.frame)+13+labelHeight+5, 5*17, 25)];
            [la setTextAlignment:NSTextAlignmentCenter];
            [la setTextColor:UICOLOR_GRAY_66];
            [la.layer setCornerRadius:25/2];
            [la.layer setBorderColor:UICOLOR_GRAY_66.CGColor];
            [la.layer setBorderWidth:1.f];
            [la setFont:[UIFont systemFontOfSize:13.f]];
            [la setText:array[i]];
            labelWith = la.frame.size.width;
            labelHeight = la.frame.size.height;
            [self addSubview:la];
        }else
        {
            UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.projectNameLab.frame)+(labelWith +10)*i, CGRectGetMaxY(self.projectNameLab.frame)+13, 5*17, 25)];
            [la setTextAlignment:NSTextAlignmentCenter];
            [la setTextColor:UICOLOR_GRAY_66];
            [la.layer setCornerRadius:25/2];
            [la.layer setBorderColor:UICOLOR_GRAY_66.CGColor];
            [la.layer setBorderWidth:1.f];
            [la setFont:[UIFont systemFontOfSize:13.f]];
            [la setText:array[i]];
            labelWith = la.frame.size.width;
            labelHeight = la.frame.size.height;
            [self addSubview:la];
        }
        
    }
   
}


@end
