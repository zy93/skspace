//
//  SKInfoNotificationTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKInfoNotificationTableViewCell.h"

@implementation SKInfoNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moreButton.layer.borderColor = UICOLOR_GRAY_DD.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
