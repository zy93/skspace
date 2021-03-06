//
//  WOTProvidersVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTTableViewBaseVC.h"
#import "SKFacilitatorModel.h"
#import "WOTEnterpriseModel.h"
typedef NS_ENUM(NSInteger, CompanyType)
{
    CompanyTypeFacilitator = 0,
    CompanyTypeEnterprise = 1
};

typedef NS_ENUM(NSInteger,SOURCE_TYPE) {
    SOURCE_TYPE_BANNER,
    SOURCE_TYPE_OTHER,
};

@interface WOTProvidersVC : WOTTableViewBaseVC
@property (nonatomic, strong) SKFacilitatorInfoModel *facilitatorModel;
@property (nonatomic, strong) WOTEnterpriseModel *enterpriseModel;
@property (nonatomic, assign) CompanyType companyType;
@property (nonatomic, assign) SOURCE_TYPE sourceType;
@property (nonatomic, strong) NSNumber *singleFacilitatorId;

@end
