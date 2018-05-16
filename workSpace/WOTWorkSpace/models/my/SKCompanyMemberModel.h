//
//  SKCompanyMemberModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKCompanyMemberModel

@end

@interface SKCompanyMemberModel : JSONModel
@property(nonatomic,copy)NSString *alias;
@property(nonatomic,strong)NSNumber *integral;
@property(nonatomic,copy)NSString *registerTime;
@property(nonatomic,copy)NSString *companyIdAdmin;
@property(nonatomic,copy)NSString *appId;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *meInvitationCode;
@property(nonatomic,copy)NSString *industry;
@property(nonatomic,copy)NSString *papersNum;
@property(nonatomic,copy)NSString *skill;
@property(nonatomic,copy)NSString *birthDate;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *site;
@property(nonatomic,copy)NSString *realName;
@property(nonatomic,copy)NSString *agreementState;
@property(nonatomic,copy)NSString *headPortrait;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *interest;
@property(nonatomic,copy)NSString *byInvitationCode;
@property(nonatomic,copy)NSString *papersType;
@property(nonatomic,copy)NSString *openid;
@property(nonatomic,copy)NSString *companyIdentity;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *constellation;
@property(nonatomic,copy)NSString *companyName;
@property(nonatomic,copy)NSString *rebateState;
@property(nonatomic,strong)NSNumber *state;
@property(nonatomic,strong)NSNumber *workHours;
@property(nonatomic,strong)NSNumber *meetingHours;
@property(nonatomic,strong)NSNumber *userType;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber *rebateSum;
@end

@interface SKCompanyMemberModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKCompanyMemberModel> *list;
@end

@interface SKCompanyMemberModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKCompanyMemberModel_list *msg;
@end
