//
//  WOTOrderCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTOrderCell.h"

@implementation WOTOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[WOTConfigThemeUitls shared]setLabelColorss:[NSArray arrayWithObjects:self.placeLabel,self.placeValue,self.dateLabel,self.dateValue,self.timeLabel,self.timeValue,self.moneyLabel,self.moneyValue, nil] withColor:MiddleTextColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
