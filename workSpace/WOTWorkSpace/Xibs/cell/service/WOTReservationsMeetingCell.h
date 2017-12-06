//
//  WOTReservationsMeetingCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSelectScrollView.h"
#import "WOTMeetingListModel.h"
@class WOTReservationsMeetingCell;


@interface WOTReservationsMeetingCell : UITableViewCell <WOTSelectScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *meetingImg;
@property (weak, nonatomic) IBOutlet UILabel *meetingNameLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingPriceLab;
@property (weak, nonatomic) IBOutlet UIView *meetingImgBGView;

//设置数据
@property (nonatomic, strong) WOTMeetingListModel *meetingModel;

@end
