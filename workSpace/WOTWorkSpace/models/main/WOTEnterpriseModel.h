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
@property(nonatomic,assign)NSNumber* companyId;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *companyPicture;
@property(nonatomic,strong)NSString *companyProfile;
@property(nonatomic,strong)NSString *companyType;
@property(nonatomic,strong)NSString *contacts;
@property(nonatomic,strong)NSString *mailbox;
@property(nonatomic,assign)NSNumber *peopleNum;
@property(nonatomic,assign)NSNumber *companyState;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *tel;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;

@end

@interface WOTEnterpriseModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTEnterpriseModel> *msg;
@end
