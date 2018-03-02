//
//  SKMyActivityModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKMyActivityModel
@end

@protocol SKMyActivityModel_list
@end

@interface SKMyActivityModel : JSONModel

@property(nonatomic,copy)NSString *activityDescribe;
@property(nonatomic,strong)NSNumber *activityId;
@property(nonatomic,strong)NSNumber *activityState;
@property(nonatomic,strong)NSNumber *activityType;
@property(nonatomic,copy)NSString *appId;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *htmlLocation;
@property(nonatomic,strong)NSNumber *issueCompanyId;
@property(nonatomic,copy)NSString *issueTime;
@property(nonatomic,strong)NSNumber *issueUserId;
@property(nonatomic,strong)NSNumber *peopleNum;
@property(nonatomic,copy)NSString *pictureSite;
@property(nonatomic,copy)NSString *principalName;
@property(nonatomic,copy)NSString *principalTel;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,copy)NSString *spaceName;
@property(nonatomic,copy)NSString *spared1;
@property(nonatomic,copy)NSString *spared2;
@property(nonatomic,copy)NSString *spared3;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *title;
@end

@interface SKMyActivityModel_list : JSONModel
@property(nonatomic,strong)SKMyActivityModel *content;
@property(nonatomic,copy)NSString *state;
@end

@interface SKMyActivityModel_msg : JSONModel
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSArray <SKMyActivityModel_list>*msg;
@property(nonatomic,copy)NSString *result;
@end
