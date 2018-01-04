//
//  WOTMyActivitiesCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyActivitiesCell.h"

@implementation WOTMyActivitiesCell

- (void)awakeFromNib {
    [super awakeFromNib];
   [[WOTConfigThemeUitls shared] setLabelColorss:[NSArray arrayWithObjects:self.activityLocation,self.activityTitle,_activityTime,_locationTitle,_activityLocation, nil] withColor:UICOLOR_MAIN_BLACK];
    [_activityBtn setTitleColor:UICOLOR_GRAY_66 forState:UIControlStateNormal];
    [_activityBtn setCorenerRadius:10 borderColor:UICOLOR_GRAY_66];
    self.contentView.backgroundColor = UICOLOR_CLEAR;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
