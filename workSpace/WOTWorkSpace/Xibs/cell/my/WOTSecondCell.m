//
//  WOTSecondCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSecondCell.h"

@implementation WOTSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.textColor = UICOLOR_GRAY_66;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
