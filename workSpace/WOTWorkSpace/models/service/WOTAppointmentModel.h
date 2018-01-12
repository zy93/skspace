//
//  WOTAppointmentModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/24.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTAppointmentModel

@end


@interface WOTAppointmentModel : JSONModel

@property(nonatomic,strong)NSString *accessType;
@property(nonatomic,strong)NSString *appointmentTime;
@property(nonatomic,strong)NSString *appointmentVisitTime ;
@property(nonatomic,strong)NSString *infoState;
@property(nonatomic,strong)NSNumber *peopleNum ;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSNumber *spaceId ;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *targetAlias;
@property(nonatomic,strong)NSNumber *targetId;
@property(nonatomic,strong)NSString *targetName;
@property(nonatomic,strong)NSString *visitTime;
@property(nonatomic,strong)NSString *visitorAlias;
@property(nonatomic,strong)NSNumber *visitorId;
@property(nonatomic,strong)NSString *visitorInfo ;
@property(nonatomic,strong)NSString *visitorName ;
@property(nonatomic,strong)NSString *visitorTel;
@property(nonatomic,strong)NSNumber *visitorUserId;

@end


@interface WOTAppointmentModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <WOTAppointmentModel> *list;
@end


@interface WOTAppointmentModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTAppointmentModel_list *msg;
@end


//访客预约
@interface WOTVisitorsModel : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *msg;

@end

