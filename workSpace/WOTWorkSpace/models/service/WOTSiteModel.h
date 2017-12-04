//
//  WOTSiteModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/8/3.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTSiteModel <NSObject>


@end

@interface WOTSiteModel : JSONModel

@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *openTime;
@property(nonatomic,strong)NSNumber *peopleNum;
@property(nonatomic,strong)NSString *siteDescribe;
@property(nonatomic,strong)NSNumber *siteId;
@property(nonatomic,strong)NSString *siteName;
@property(nonatomic,strong)NSString *sitePicture;
@property(nonatomic,strong)NSNumber *sitePrice;
@property(nonatomic,strong)NSNumber *siteState;
@property(nonatomic,strong)NSNumber *siteType;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;
//新添加字段
@property(nonatomic,strong)NSString *facility;//设备

@end



@interface WOTSiteModel_Msg : JSONModel
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSArray<WOTSiteModel> *msg;

@end
