//
//  WOTEnterpriseModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTEnterpriseModel

@end

@interface WOTEnterpriseModel : JSONModel

@property(nonatomic,strong)NSString* accountName ;
@property(nonatomic,strong)NSString* administrative ;
@property(nonatomic,strong)NSString* administrativeMail ;
@property(nonatomic,strong)NSString* administrativeTel ;
@property(nonatomic,strong)NSString* bankAccount ;
@property(nonatomic,strong)NSString* businessNum ;
@property(nonatomic,strong)NSString* businessPlan ;
@property(nonatomic,strong)NSString* businessScope ;
@property(nonatomic,strong)NSString* busnissTerm ;
@property(nonatomic,assign)NSNumber* companyId ;
@property(nonatomic,strong)NSString* companyName ;
@property(nonatomic,strong)NSString* companyPicture ;
@property(nonatomic,strong)NSString* companyProfile;
@property(nonatomic,assign)NSNumber* companyState;
@property(nonatomic,strong)NSString* companyType;
@property(nonatomic,strong)NSString* contacts ;
@property(nonatomic,strong)NSString* creditNum ;
@property(nonatomic,strong)NSString* dateApproval ;
@property(nonatomic,assign)NSNumber* developmentExpenses ;
@property(nonatomic,assign)NSNumber* employeesNum ;
@property(nonatomic,strong)NSString* englishName ;
@property(nonatomic,strong)NSString* enterpriseBank ;
@property(nonatomic,strong)NSString* enterprisePhone ;
@property(nonatomic,strong)NSString* finance ;
@property(nonatomic,strong)NSString* financeMail ;
@property(nonatomic,strong)NSString* financeTel ;
@property(nonatomic,strong)NSString* financingNum ;
@property(nonatomic,assign)NSNumber* givingRemainingTime ;
@property(nonatomic,assign)NSNumber* givingTimeTotal ;
@property(nonatomic,strong)NSString* givingTimeType ;
@property(nonatomic,assign)NSNumber* highTech ;
@property(nonatomic,assign)NSNumber* highTechNum ;
@property(nonatomic,strong)NSString* industry ;
@property(nonatomic,strong)NSString* internetEnterprises ;
@property(nonatomic,strong)NSString* joinDate ;
@property(nonatomic,strong)NSString* legalPerson ;
@property(nonatomic,strong)NSString* lettersUrl ;
@property(nonatomic,strong)NSString* mailbox;
@property(nonatomic,strong)NSString* organizingNum ;
@property(nonatomic,strong)NSString* other ;
@property(nonatomic,strong)NSString* otherDuty ;
@property(nonatomic,strong)NSString* otherMail ;
@property(nonatomic,strong)NSString* otherTel ;
@property(nonatomic,assign)NSNumber* patentNum ;
@property(nonatomic,assign)NSNumber* peopleNum ;
@property(nonatomic,assign)NSNumber* ratepaying ;
@property(nonatomic,strong)NSString* registeredAddress ;
@property(nonatomic,strong)NSString* registeredCapital ;
@property(nonatomic,strong)NSString* registrationAuthority ;
@property(nonatomic,assign)NSNumber* researchNum ;
@property(nonatomic,assign)NSNumber* revenue ;
@property(nonatomic,assign)NSNumber* socialNum ;
@property(nonatomic,strong)NSString* softwareCopyright ;
@property(nonatomic,strong)NSString* softwareEnterprise ;
@property(nonatomic,assign)NSNumber* spaceId;
@property(nonatomic,strong)NSString* tatepayerNum ;
@property(nonatomic,strong)NSString* tel ;
@property(nonatomic,strong)NSString* typeEnterprise ;
@property(nonatomic,assign)NSNumber* workNum ;

@end



@interface WOTEnterpriseModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property(nonatomic,strong)NSArray <WOTEnterpriseModel> *list;
@end


@interface WOTEnterpriseModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTEnterpriseModel_list *msg;
@end
