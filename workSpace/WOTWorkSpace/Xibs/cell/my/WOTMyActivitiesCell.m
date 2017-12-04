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
   [[WOTConfigThemeUitls shared] setLabelColorss:[NSArray arrayWithObjects:self.activityLocation,self.activityTitle,_activityTime,_locationTitle,_activityLocation, nil] withColor:HighTextColor];
    [_activityBtn setTitleColor:MainOrangeColor forState:UIControlStateNormal];
    [_activityBtn setCorenerRadius:10 borderColor:MainOrangeColor];
    self.contentView.backgroundColor = CLEARCOLOR;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
