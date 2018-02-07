//
//  StationOrderInfoViewController.h
//  LoginDemo
//
//  Created by wangxiaodong on 2017/12/4.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTWXPayModel.h"
#import "WOTMeetingListModel.h"
#import "SKBookStationOrderModel.h"

@interface StationOrderInfoViewController : UIViewController


@property (nonatomic, strong) WOTWXPayModel *model;
@property (nonatomic, strong) SKBookStationOrderModel_object *bookStationModel;
//@property (nonatomic, strong) WOTMeetingListModel *meetingModel;
//@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSString *orderString;
@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *durationTime;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSNumber *productNum;
@property (nonatomic, strong) NSString *facilityStr;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSNumber *payType;

@end
