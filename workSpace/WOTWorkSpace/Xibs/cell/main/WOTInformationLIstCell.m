//
//  WOTInformationLIstCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTInformationLIstCell.h"

@implementation WOTInformationLIstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.infoTime.textColor = HighTextColor;
    self.infoValue.textColor = HighTextColor;
    self.infoValue.userInteractionEnabled = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
