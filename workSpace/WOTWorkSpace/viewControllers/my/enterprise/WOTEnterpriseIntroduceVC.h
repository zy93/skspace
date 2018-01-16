//
//  WOTEnterpriseIntroduceVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTableViewBaseVC.h"
#import "WOTEnterpriseModel.h"
#import "SKFacilitatorModel.h"

typedef NS_ENUM(NSInteger, INTRODUCE_VC_TYPE) {
    INTRODUCE_VC_TYPE_Enterprise = 0, //企业
    INTRODUCE_VC_TYPE_Providers,     //服务商
};

@interface WOTEnterpriseIntroduceVC : WOTTableViewBaseVC
@property (nonatomic, strong) WOTEnterpriseModel *model;
@property (nonatomic, strong) SKFacilitatorInfoModel *facilitatorModel;
@property (nonatomic, assign) INTRODUCE_VC_TYPE  vcType;

@end
