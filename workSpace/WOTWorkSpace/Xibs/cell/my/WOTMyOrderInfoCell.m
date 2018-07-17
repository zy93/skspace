//
//  WOTMyOrderInfoCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyOrderInfoCell.h"

@implementation WOTMyOrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UICOLOR_CLEAR;
    [self.bgIV setContentMode:UIViewContentModeScaleAspectFill];
    
    
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //弧形背景
    self.bgIV.clipsToBounds = YES;
    CGRect rect=  CGRectMake(self.bgIV.bounds.origin.x, self.bgIV.bounds.origin.y, SCREEN_WIDTH-40, self.bgIV.bounds.size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners: UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    //mask
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgIV.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    self.bgIV.layer.mask = maskLayer;
    
    self.shadeView.clipsToBounds = YES;
    CGRect rect1=  CGRectMake(self.shadeView.bounds.origin.x, self.shadeView.bounds.origin.y, SCREEN_WIDTH-40, self.shadeView.bounds.size.height);
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:rect1 byRoundingCorners: UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    //mask
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.shadeView.bounds;
    maskLayer1.path = maskPath1.CGPath;
    maskLayer1.strokeColor = [UIColor clearColor].CGColor;
    self.shadeView.layer.mask = maskLayer1;
    //self.shadeView.layer = maskLayer;
}

-(void)setupViews
{
    [self setNeedsLayout];
}

@end
