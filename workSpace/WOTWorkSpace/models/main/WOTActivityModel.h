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

@property(nonatomic,strong)NSString *activityDescribe ;
@property(nonatomic,strong)NSNumber *activityId;
@property(nonatomic,strong)NSNumber *activityState;
@property(nonatomic,strong)NSNumber *activityType;
@property(nonatomic,strong)NSString *appId ;
@property(nonatomic,strong)NSString *endTime ;
@property(nonatomic,strong)NSString *htmlLocation;
@property(nonatomic,strong)NSNumber *issueCompanyId;
@property(nonatomic,strong)NSString *issueTime ;
@property(nonatomic,strong)NSNumber *issueUserId ;
@property(nonatomic,strong)NSNumber *peopleNum ;
@property(nonatomic,strong)NSString *pictureSite ;
@property(nonatomic,strong)NSString *principalName ;
@property(nonatomic,strong)NSString *principalTel ;
@property(nonatomic,strong)NSNumber *spaceId ;
@property(nonatomic,strong)NSString *spaceName ;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;
@property(nonatomic,strong)NSString *starTime;
@property(nonatomic,strong)NSString *title ;



@end

@interface WOTActivityModel_list:JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property(nonatomic,strong)NSArray <WOTActivityModel> *list;
@end

@interface WOTActivityModel_msg:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTActivityModel_list *msg;

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
