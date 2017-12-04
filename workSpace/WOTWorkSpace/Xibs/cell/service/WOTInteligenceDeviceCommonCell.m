//
//  WOTInteligenceDeviceCommonCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTInteligenceDeviceCommonCell.h"

@implementation WOTInteligenceDeviceCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cellTitle.textColor = HighTextColor;
    [_cellSwitch setOn:NO];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
