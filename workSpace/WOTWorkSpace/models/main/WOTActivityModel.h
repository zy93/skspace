//
//  WOTActivityModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTActivityModel

@end

@interface WOTActivityModel : JSONModel
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSNumber *activityId;
@property(nonatomic,strong)NSNumber *activityState;
@property(nonatomic,strong)NSNumber *activityType;
@property(nonatomic,strong)NSNumber *issueCompanyId;
@property(nonatomic,strong)NSString *issueTime;
@property(nonatomic,strong)NSNumber *issueUserId;
@property(nonatomic,strong)NSNumber *peopleNum;
@property(nonatomic,strong)NSString *pictureSite;
@property(nonatomic,strong)NSString *principalName;
@property(nonatomic,strong)NSString *principalTel;
@property(nonatomic,strong)NSString *activityDescribe;
@property(nonatomic,strong)NSString *starTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;

-(instancetype)initWithTitle:(NSString *)title activityId:(NSNumber *)activityId activityState:(NSNumber *)activityState activityType:(NSNumber *)activityType issueCompanyId:(NSNumber *)issueCompanyId issueTime:(NSString *)issueTime issueUserId:(NSNumber *)issueUserId peopleNum:(NSNumber *)peopleNum pictureSite:(NSString *)pictureSite principalName:(NSString *)principalName principalTel:(NSString *)principalTel activityDescribe:(NSString *)activityDescribe starTime:(NSString *)starTime endTime:(NSString *)endTime spaceId:(NSNumber *)spaceId spaceName:(NSString *)spaceName spared1:(NSString *)spared1 spared2:(NSString *)spared2 spared3:(NSString *)spared3;
@end

@interface WOTActivityModel_msg:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTActivityModel> *msg;

@end



@protocol WOTMyActivityModel

@end

@interface WOTMyActivityModel:JSONModel
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)WOTActivityModel *content;

@end

@interface WOTMyActivityModel_msg:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTMyActivityModel> *msg;

@end
