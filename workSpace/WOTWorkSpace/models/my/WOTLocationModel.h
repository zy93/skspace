//
//  WOTLocationModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WOTSpaceModel.h"

@protocol WOTLocationModel <NSObject>

@end

@interface WOTLocationModel : JSONModel

//@property (nonatomic, strong) NSString *appId ;
//@property (nonatomic, strong) NSString *city;
//@property (nonatomic, strong) NSString *creationTime;
//@property (nonatomic, strong) NSString *facility;
//@property (nonatomic, strong) NSString *fixPhone ;
//@property (nonatomic, strong) NSString *lat;
//@property (nonatomic, strong) NSString *lng ;
//@property (nonatomic, strong) NSNumber *onlineLocationPrice ;
//@property (nonatomic, strong) NSString *relationName ;
//@property (nonatomic, strong) NSNumber *relationTel ;
//@property (nonatomic, strong) NSString *spaceDescribe;
//@property (nonatomic, strong) NSNumber *spaceId ;
//@property (nonatomic, strong) NSString *spaceName;
//@property (nonatomic, strong) NSString *spacePicture;
//@property (nonatomic, strong) NSString *spaceSite ;
//@property (nonatomic, strong) NSNumber *spaceState ;
//@property (nonatomic, strong) NSString *spaceUrl ;
//@property (nonatomic, strong) NSString *valueAdded ;
@property(nonatomic,strong)NSString *appId;//集团编号
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *creationTime;
@property(nonatomic,strong)NSString *facility;
@property(nonatomic,strong)NSString *fixPhone;
@property(nonatomic,strong)NSNumber *lat;
@property(nonatomic,strong)NSNumber *lng;
@property(nonatomic,strong)NSNumber *manNum;
@property(nonatomic,strong)NSString *manualSite;//项目手册地址
@property(nonatomic,strong)NSNumber *onlineLocationPrice;//线上预订工位价
@property(nonatomic,strong)NSString *openingHours;
@property(nonatomic,strong)NSString *relationName;//经理联系姓名
@property(nonatomic,strong)NSString *relationTel;
@property(nonatomic,strong)NSString *sourcecode;
@property(nonatomic,strong)NSString *spaceDescribe;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *spacePicture;
@property(nonatomic,strong)NSString *spaceSite;//位置
@property(nonatomic,strong)NSNumber *spaceState;
@property(nonatomic,strong)NSString *spaceUrl;
@property(nonatomic,strong)NSString *valueAdded;//增值服务
@property(nonatomic,strong)NSNumber *stationNum;

@end


@interface WOTLocationModel_Msg : JSONModel
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) WOTSpaceModel *msg;
@end
