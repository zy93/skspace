//
//  WOTMyAppointmentCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyAppointmentCell.h"

@implementation WOTMyAppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[WOTConfigThemeUitls shared] setLabelColorss:[NSArray arrayWithObjects:self.appintmentTimeLabel,self.appointmentTimeValue,self.appontmentObjectLabel,self.appointmentObjectValue,self.appointmentReasionLabel,self.appointmentReasionValue,self.appointmentCommunityLabel,self.appointmentCommunityValue,nil] withColor:HighTextColor];
    [_remindmeBtn setTitleColor:MainOrangeColor forState:UIControlStateNormal];
    [_remindmeBtn setCorenerRadius:10 borderColor:MainOrangeColor];
    self.contentView.backgroundColor = CLEARCOLOR;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)settingReming:(id)sender {
    
    [_remindmeBtn setSelected:!_remindmeBtn.isSelected];
    if (!_remindmeBtn.isSelected) {
        [_remindmeBtn setTitle:@"提醒我" forState:UIControlStateNormal];
    } else {
        [_remindmeBtn setTitle:@"取消提醒" forState:UIControlStateNormal];
    }
    
    if ([_delegate respondsToSelector:@selector(settingRemindWithIndex:isRemind:)]) {
        [_delegate settingRemindWithIndex:_index isRemind:_remindmeBtn.isSelected];
    }
}

@end
