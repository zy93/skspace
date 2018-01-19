//
//  WOTMeetingReservationsModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//TODO:
@protocol WOTReservationsResponseModel <NSObject>

@end

@interface WOTReservationsResponseModel : JSONModel

@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *body;
@property(nonatomic,strong)NSString *commodityKind;
@property(nonatomic,strong)NSString *commodityNumList;
@property(nonatomic,strong)NSString *dealMode;
@property(nonatomic,strong)NSString *deductionTimes;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *evaluate;
@property(nonatomic,strong)NSString *finishTime;
@property(nonatomic,strong)NSString *orderNum;
@property(nonatomic,strong)NSString *orderState;
@property(nonatomic,strong)NSString *orderTime;
@property(nonatomic,strong)NSString *payObject;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *starTime;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userTel;
@property(nonatomic,strong)NSNumber *commodityNum;
@property(nonatomic,strong)NSNumber *contractMode;
@property(nonatomic,strong)NSNumber *deduction;
@property(nonatomic,strong)NSNumber *money;
@property(nonatomic,strong)NSNumber *payMode;
@property(nonatomic,strong)NSNumber *payType;
@property(nonatomic,strong)NSNumber *productNum;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber *conferenceDetailsId;
@end


@interface WOTReservationsResponseModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTReservationsResponseModel<WOTReservationsResponseModel> *msg;
@end



//TODO:会议室预定情况model
@protocol WOTMeetingReservationsModel <NSObject>

@end

@interface WOTMeetingReservationsModel : JSONModel
@property(nonatomic,strong)NSString *company;
@property(nonatomic,strong)NSString *conferenceDescribe;
@property(nonatomic,strong)NSNumber *conferenceDetailsId;
@property(nonatomic,strong)NSNumber *conferenceId;
@property(nonatomic,strong)NSString *conferenceName;
@property(nonatomic,strong)NSNumber *conferencePrice;
@property(nonatomic,strong)NSNumber *conferenceType;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *openTime;
@property(nonatomic,strong)NSString *people;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *startTime;
@end


@interface WOTMeetingReservationsModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray <WOTMeetingReservationsModel> *msg;

@end
