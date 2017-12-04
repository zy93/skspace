//
//  WOTActivitiesListCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTActivitiesListCell.h"

@implementation WOTActivitiesListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[WOTConfigThemeUitls shared]setLabelColorss:[NSArray arrayWithObjects:self.activityTitle,self.activityLocation,self.activityState, nil] withColor:HighTextColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
