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

@property(nonatomic,strong)NSNumber *accessState;
@property(nonatomic,strong)NSNumber *accessType;
@property(nonatomic,strong)NSString *feedback;
@property(nonatomic,strong)NSNumber *papersType;
@property(nonatomic,strong)NSNumber *peopleNum;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *visitInfo;
@property(nonatomic,strong)NSString *visitTime;
@property(nonatomic,strong)NSNumber *visitorId;
@property(nonatomic,strong)NSString *visitorName;
@property(nonatomic,strong)NSString *visitorPicture;
@property(nonatomic,strong)NSString *visitorTel;

@end

@interface WOTAppointmentModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTAppointmentModel> *msg;

@end
