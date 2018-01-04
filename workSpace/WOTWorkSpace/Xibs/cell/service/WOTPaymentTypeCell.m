//
//  WOTPaymentTypeCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTPaymentTypeCell.h"

@implementation WOTPaymentTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.enterpriseBtn.layer.borderWidth = 1.f;
    self.enterpriseBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    [self.enterpriseBtn setTitleColor:UICOLOR_MAIN_LINE forState:UIControlStateSelected];
    self.enterpriseBtn.selected = YES;
    self.personBtn.layer.borderWidth = 1.f;
    self.personBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
    
    [self.enterpriseBtn setTitleColor:UICOLOR_MAIN_LINE forState:UIControlStateNormal];
    [self.enterpriseBtn setTitleColor:UICOLOR_MAIN_LINE forState:UIControlStateSelected];
    [self.personBtn setTitleColor:UICOLOR_MAIN_LINE forState:UIControlStateNormal];
    [self.personBtn setTitleColor:UICOLOR_MAIN_LINE forState:UIControlStateSelected];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEnterprise:(BOOL)enterprise
{
    _enterprise = enterprise;
    if (enterprise) {
        self.enterpriseBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
        self.personBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
        self.enterpriseBtn.selected = YES;
        self.personBtn.selected = NO;
    }
    else {
        self.enterpriseBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
        self.personBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
        self.enterpriseBtn.selected = NO;
        self.personBtn.selected = YES;
    }
}
- (IBAction)clickPersonBtn:(id)sender {
    self.enterprise = NO;
}
- (IBAction)clickEnterpriseBtn:(id)sender {
    self.enterprise = YES;
}

@end
