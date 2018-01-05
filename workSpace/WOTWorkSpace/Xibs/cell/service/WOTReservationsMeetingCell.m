//
//  WOTReservationsMeetingCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTReservationsMeetingCell.h"
#import "WOTReservationsMeetingVC.h"
#import "WOTMeetingReservationsModel.h"

@implementation WOTReservationsMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = YES;
    [self.meetingImgBGView setBackgroundColor:RGBA(40, 43, 50, 0.6)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setMeetingModel:(WOTMeetingListModel *)meetingModel
{
   // NSLog(@"测试：%@",meetingModel);
    _meetingModel = meetingModel;
    [self.meetingNameLab setText:_meetingModel.conferenceName];
    [self.meetingInfoLab setText:_meetingModel.conferenceDescribe];
    [self.meetingImg sd_setImageWithURL:[_meetingModel.conferencePicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
    [self.meetingPriceLab setText:[NSString stringWithFormat:@"%.2f元/小时",[_meetingModel.conferencePrice floatValue]]];
}
@end
