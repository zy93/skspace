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
#import "WOTSpaceModel.h"
//#import ""

@interface WOTOrderVC : UIViewController

@property (nonatomic, strong) WOTBookStationListModel *model;
@property (nonatomic, strong) WOTMeetingListModel *meetingModel;
@property (nonatomic, strong) WOTSpaceModel *spaceModel;

//账单费用
@property (nonatomic, assign) CGFloat costNumber;
//已选时间记录
@property (nonatomic,assign) CGFloat beginTime;
@property (nonatomic,assign) CGFloat endTime;

@end
