//
//  WOTLocationModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol WOTLocationModel <NSObject>

@end

@interface WOTLocationModel : JSONModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *creationTime;
@property (nonatomic, strong) NSString *fixPhone;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *leaseConditions;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *longRent;
@property (nonatomic, strong) NSString *relationTel;
@property (nonatomic, strong) NSString *shortRent;
@property (nonatomic, strong) NSString *spaceDescribe;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName;
@property (nonatomic, strong) NSString *spacePicture;
@property (nonatomic, strong) NSString *spaceSite;
@property (nonatomic, strong) NSString *spaceStar;
@property (nonatomic, strong) NSString *spaceState;
@property (nonatomic, strong) NSString *spaceUrl;
@property (nonatomic, strong) NSString *spared1;
@property (nonatomic, strong) NSString *spared2;
@property (nonatomic, strong) NSString *spared3;

@end


@interface WOTLocationModel_Msg : JSONModel
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) WOTLocationModel <WOTLocationModel>*msg;
@end
