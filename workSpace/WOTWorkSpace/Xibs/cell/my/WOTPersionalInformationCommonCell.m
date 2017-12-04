//
//  WOTPersionalInformationCommonCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTPersionalInformationCommonCell.h"
#import "UIView+Extension.h"
@implementation WOTPersionalInformationCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_valueImage setRadiuWithCorners:UIRectCornerAllCorners radiu:_valueImage.frame.size.width/2];
    [[WOTConfigThemeUitls shared]setLabelColorss:[NSArray arrayWithObjects:self.titleLabel,self.valueLabel, nil] withColor:HighTextColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
