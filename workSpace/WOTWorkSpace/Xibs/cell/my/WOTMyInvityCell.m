//
//  WOTMyInvityCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyInvityCell.h"

@implementation WOTMyInvityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.subtitleLab.textColor = UICOLOR_GRAY_66;
    self.iconIV.layer.cornerRadius = 55/2;
    self.iconIV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
