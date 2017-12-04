//
//  WOTOrderVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTBookStationListModel.h"
#import "WOTMeetingReservationsModel.h"
#import "WOTBookStationListModel.h"
#import "WOTMeetingListModel.h"
#import "WOTSiteModel.h"
#import "WOTSpaceModel.h"
//#import ""

@interface WOTOrderVC : UIViewController

@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSNumber *conferenceOrSiteId;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) WOTBookStationListModel *model;
@property (nonatomic, strong) WOTMeetingListModel *meetingModel;
@property (nonatomic, strong) WOTSiteModel *siteModel;

//2017-9-26
@property (nonatomic, strong) WOTSpaceModel *spaceModel;

@property (nonatomic, assign) CGFloat costNumber;

@end
