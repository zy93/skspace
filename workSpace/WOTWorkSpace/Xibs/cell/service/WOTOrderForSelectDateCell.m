//
//  WOTOrderForSelectDateCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForSelectDateCell.h"

@implementation WOTOrderForSelectDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dateLab.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.dateLab.layer.borderWidth = 1.f;
    self.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
