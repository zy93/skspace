//
//  WOTTEnterpriseListCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTTEnterpriseListCell.h"

@implementation WOTTEnterpriseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.enterpriseName.textColor = MiddleTextColor;
    self.enterpriseInfo.textColor = HighTextColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
