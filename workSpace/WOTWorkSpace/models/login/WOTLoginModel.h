//
//  WOTLoginModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <Foundation/Foundation.h>

@protocol WOTLoginModel

@end


@interface WOTLoginModel : JSONModel
@property (nonatomic, strong) NSString *appId;//集团编号
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *companyId;    //公司id，员工身份
@property (nonatomic, strong) NSString *companyIdAdmin; //公司id，管理员身份
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *constellation;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *interest;
@property (nonatomic, strong) NSString *papersNum;
@property (nonatomic, strong) NSNumber *papersType;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *registerTime;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSNumber *state;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) NSNumber *userType;
@property (nonatomic, assign) NSNumber *meetingHours;
@property (nonatomic, assign) NSNumber *workHours;
@property (nonatomic, assign) NSNumber *integral;

@end


@interface WOTLoginModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTLoginModel<WOTLoginModel> *msg;
@end



@interface WOTSearchModel_msg : JSONModel

@property (nonatomic, strong) NSNumber *bottomPageNo;
@property(nonatomic,strong)NSArray <WOTLoginModel> *list;
@end



@interface WOTSearchModel_model : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTSearchModel_msg  *msg;
@end






