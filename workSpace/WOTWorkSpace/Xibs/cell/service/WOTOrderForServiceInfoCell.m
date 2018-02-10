//
//  WOTOrderForServiceInfoCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForServiceInfoCell.h"

@implementation WOTOrderForServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    self.addressLab.textColor = UICOLOR_GRAY_99;
    self.peopleLab.textColor  = UICOLOR_GRAY_99;
    self.openTimeLab.textColor= UICOLOR_GRAY_99;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
