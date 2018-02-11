//
//  WOTFirstCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTFirstCell.h"

@implementation WOTFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIV.layer.cornerRadius = 10.f;
    self.iconIV.clipsToBounds = YES;
    
    self.subtitle1Lab.textColor = UICOLOR_MAIN_TEXT;
    self.subtitle1Lab.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.subtitle1Lab.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.subtitle1Lab.layer.borderWidth=1.f;
    self.subtitle1Lab.clipsToBounds = YES;
    self.subtitle1Lab.layer.cornerRadius = 3.f;
    
    self.subtitle2Lab.textColor = UICOLOR_MAIN_TEXT;
    self.subtitle2Lab.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.subtitle2Lab.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.subtitle2Lab.layer.borderWidth=1.f;
    self.subtitle2Lab.clipsToBounds = YES;
    self.subtitle2Lab.layer.cornerRadius = 3.f;
    
    self.subtitle3Lab.textColor = UICOLOR_MAIN_TEXT;
    self.subtitle3Lab.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.subtitle3Lab.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.subtitle3Lab.layer.borderWidth=1.f;
    self.subtitle3Lab.clipsToBounds = YES;
    self.subtitle3Lab.layer.cornerRadius = 3.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
