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
#import "WOTSiteModel.h"

@class WOTReservationsMeetingCell;

@protocol WOTReservationsMeetingCellDelegate <NSObject>

-(void)submitReservationsCell:(WOTReservationsMeetingCell*)cell;
-(void)selectTimeWithCell:(WOTReservationsMeetingCell*)cell Time:(CGFloat)time;

@end


@interface WOTReservationsMeetingCell : UITableViewCell <WOTSelectScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *meetingImg;
@property (weak, nonatomic) IBOutlet UILabel *meetingNameLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingPriceLab;
@property (weak, nonatomic) IBOutlet WOTSelectScrollView *selectTimeScroll;
@property (weak, nonatomic) IBOutlet UIButton *subTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *addTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *TimeStatisticLab;
@property (weak, nonatomic) IBOutlet UILabel *timeStatisticsLab;
@property (weak, nonatomic) IBOutlet UILabel *timeScopeLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingOpenTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *meetingImgBGView;
@property (weak, nonatomic) IBOutlet UIView *selectIndicationView;
//@property (weak, nonatomic) IBOutlet UILabel *meetingOpenTime;

@property (weak, nonatomic) id <WOTReservationsMeetingCellDelegate> delegate;

//设置数据
@property (nonatomic, strong) WOTMeetingListModel *meetingModel;
@property (nonatomic, strong) WOTSiteModel *siteModel;
@property (nonatomic, strong) NSString *inquireTime;//查询日期;
@property (nonatomic, strong) NSIndexPath *index;

@property (nonatomic, assign)CGFloat allTime ;

-(void)setupView;

@end
