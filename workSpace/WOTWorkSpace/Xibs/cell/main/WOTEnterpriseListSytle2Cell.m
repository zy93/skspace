//
//  WOTEnterpriseListSytle2Cell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/5.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseListSytle2Cell.h"

@implementation WOTEnterpriseListSytle2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.subtitleLab1.layer.cornerRadius = 4.f;
    self.subtitleLab1.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.subtitleLab1.layer.borderWidth = 1.f;
    self.subtitleLab2.layer.cornerRadius = 4.f;
    self.subtitleLab2.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.subtitleLab2.layer.borderWidth = 1.f;
    self.subtitleLab3.layer.cornerRadius = 4.f;
    self.subtitleLab3.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.subtitleLab3.layer.borderWidth = 1.f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
