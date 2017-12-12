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
        self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        self.topBgView.backgroundColor = UIColorFromRGB(0xf0f0f0);
        [self addSubview:self.topBgView];
        
        self.iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(22, 22, 55, 55)];
        [self.iconIV setImage:[UIImage imageNamed:@"zhanwei"]];
        self.iconIV.layer.cornerRadius = 55/2;
        [self.topBgView addSubview:self.iconIV];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconIV.frame)+15, 22, 200, 18)];
        [self.titleLab setText:@"易联港"];
        [self.topBgView addSubview:self.titleLab];
        
        self.subtitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconIV.frame)+15, CGRectGetMaxY(self.titleLab.frame)+7, 120, 18)];
        [self.subtitleLab setText:@"物联网"];
        [self.topBgView addSubview:self.subtitleLab];
        
        self.projectNameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.topBgView.frame)+15, 120, 18)];
        [self.subtitleLab setText:@"物联网"];
        [self.topBgView addSubview:self.subtitleLab];
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
