//
//  SKCompanyRemainingTimeModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/4/26.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//
//@property(nonatomic,strong)NSNumber *;
//@property(nonatomic,copy)NSString *;
#import <JSONModel/JSONModel.h>

@interface SKCompanyRemainingTimeModel : JSONModel
@property(nonatomic,copy)NSString *accountName;
@property(nonatomic,copy)NSString *administrative;
@property(nonatomic,copy)NSString *administrativeMail;
@property(nonatomic,copy)NSString *administrativeTel;
@property(nonatomic,strong)NSNumber *artisanNum;
@property(nonatomic,copy)NSString *background;
@property(nonatomic,copy)NSString *bankAccount;
@property(nonatomic,copy)NSString *business;
@property(nonatomic,copy)NSString *businessNum;
@property(nonatomic,copy)NSString *businessPlan;
@property(nonatomic,copy)NSString *businessScope;
@property(nonatomic,copy)NSString *busnissTerm;
@property(nonatomic,copy)NSString *companyEmil;
@property(nonatomic,copy)NSString *companyId;
@property(nonatomic,copy)NSString *companyName;
@property(nonatomic,copy)NSString *companyPicture;
@property(nonatomic,copy)NSString *companyProfile;
@property(nonatomic,copy)NSString *companySite;
@property(nonatomic,strong)NSNumber *companyState;
@property(nonatomic,copy)NSString *companyType;
@property(nonatomic,copy)NSString *contacts;
@property(nonatomic,copy)NSString *contacts2;
@property(nonatomic,copy)NSString *creditNum;
@property(nonatomic,copy)NSString *dateApproval;
@property(nonatomic,copy)NSString *debt;
@property(nonatomic,strong)NSNumber *developmentExpenses;
@property(nonatomic,strong)NSNumber *employeesNum;
@property(nonatomic,copy)NSString *englishName;
@property(nonatomic,copy)NSString *enterpriseBank;
@property(nonatomic,copy)NSString *enterprisePhone;
@property(nonatomic,copy)NSString *finance;
@property(nonatomic,copy)NSString *financeMail;
@property(nonatomic,copy)NSString *financeTel;
@property(nonatomic,copy)NSString *financing;
@property(nonatomic,copy)NSString *financingNum;
@property(nonatomic,strong)NSNumber *givingRemainingTime;
@property(nonatomic,strong)NSNumber *givingTimeTotal;
@property(nonatomic,copy)NSString *givingTimeType;
@property(nonatomic,copy)NSString *highTech;
@property(nonatomic,strong)NSNumber *highTechNum;
@property(nonatomic,strong)NSNumber *meetLength;
@property(nonatomic,strong)NSNumber *meetingType;
@property(nonatomic,strong)NSNumber *patentNum;
@property(nonatomic,strong)NSNumber *peopleNum;
@property(nonatomic,strong)NSNumber *profit;
@property(nonatomic,strong)NSNumber *ratepaying;
@property(nonatomic,strong)NSNumber *researchNum;
@property(nonatomic,strong)NSNumber *revenue;
@property(nonatomic,strong)NSNumber *setUpmeetLength;
@property(nonatomic,strong)NSNumber *socialNum;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSNumber *turnover;
@property(nonatomic,strong)NSNumber *workNum;
@property(nonatomic,copy)NSString *industry;
@property(nonatomic,copy)NSString *intention;
@property(nonatomic,copy)NSString *internetEnterprises;
@property(nonatomic,copy)NSString *joinDate;
@property(nonatomic,copy)NSString *legalPerson;
@property(nonatomic,copy)NSString *lettersUrl;
@property(nonatomic,copy)NSString *mailbox;
@property(nonatomic,copy)NSString *mailbox2;
@property(nonatomic,copy)NSString *organization;
@property(nonatomic,copy)NSString *organizingNum;
@property(nonatomic,copy)NSString *other;
@property(nonatomic,copy)NSString *otherDuty;
@property(nonatomic,copy)NSString *otherMail;
@property(nonatomic,copy)NSString *otherTel;
@property(nonatomic,copy)NSString *registeredAddress;
@property(nonatomic,copy)NSString *registeredCapital;
@property(nonatomic,copy)NSString *registrationAuthority;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *share;
@property(nonatomic,copy)NSString *softwareCopyright;
@property(nonatomic,copy)NSString *softwareEnterprise;
@property(nonatomic,copy)NSString *spaceName;
@property(nonatomic,copy)NSString *stockRights;
@property(nonatomic,copy)NSString *tatepayerNum;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *tel2;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *typeEnterprise;
@property(nonatomic,copy)NSString *website;
@end


@interface SKCompanyRemainingTimeModel_msg : JSONModel

@property(nonatomic,copy)NSString *code;
@property(nonatomic,strong)SKCompanyRemainingTimeModel *msg;
@property(nonatomic,copy)NSString *result;

@end
