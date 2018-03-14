//
//  WOTRepairHistoryModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/13.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTRepairHistoryModel

@end

@interface WOTRepairHistoryModel : JSONModel
@property (nonatomic, strong) NSString * address ;
@property (nonatomic, strong) NSString * alias;
@property (nonatomic, strong) NSString * appointmentTime;
@property (nonatomic, strong) NSString * evaluation ;
@property (nonatomic, strong) NSString * evaluationTime;
@property (nonatomic, strong) NSString * finishTime;
@property (nonatomic, strong) NSString * info ;
@property (nonatomic, strong) NSNumber * infoId ;
@property (nonatomic, strong) NSString * orderOverTime ;
@property (nonatomic, strong) NSString * orderTime;
@property (nonatomic, strong) NSString * phone ;
@property (nonatomic, strong) NSNumber * pickUpUserID;
@property (nonatomic, strong) NSString * pictureFour;
@property (nonatomic, strong) NSString * pictureOne;
@property (nonatomic, strong) NSString * pictureThree;
@property (nonatomic, strong) NSString * pictureTwo ;
@property (nonatomic, strong) NSString * sorderTime ;
@property (nonatomic, strong) NSString * spaceId ;
@property (nonatomic, strong) NSString * star ;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * state ;
@property (nonatomic, strong) NSString * statuscode ;
@property (nonatomic, strong) NSString * type ;
@property (nonatomic, strong) NSNumber * userId ;
@property (nonatomic, strong) NSString * userName ;
@end

@interface WOTRepairHistoryModel_msg :JSONModel
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *result;
@property(nonatomic,copy)NSArray <WOTRepairHistoryModel>*msg;


@end
