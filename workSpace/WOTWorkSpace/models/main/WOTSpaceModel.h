//
//  WOTSpaceModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTSpaceModel

@end
@interface WOTSpaceModel : JSONModel
@property(nonatomic,assign)NSNumber* spaceId;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *spaceDescribe;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *spaceSite;//位置
@property(nonatomic,strong)NSString *fixPhone;
@property(nonatomic,strong)NSString *relationTel;
@property(nonatomic,assign)NSNumber *spaceState;
@property(nonatomic,strong)NSString *creationTime;
@property(nonatomic,strong)NSString *spacePicture;
@property(nonatomic,assign)NSNumber *lat;
@property(nonatomic,assign)NSNumber *lng;
@property(nonatomic,assign)NSNumber *leaseConditions; //长短租
@property(nonatomic,assign)NSNumber *shortRent;
@property(nonatomic,strong)NSString *spaceStar;
@property(nonatomic,strong)NSString *spaceUrl;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;
//新添加的接口
@property(nonatomic,strong)NSNumber *stationNum;
@property(nonatomic,strong)NSNumber *alreadyTakenNum;
@property(nonatomic,strong)NSNumber *stationPrice;
-(instancetype)initWithSpaceId:(NSNumber *)spaceId spaceName:(NSString *)spaceName spaceDescribe:(NSString *)spaceDescribe  city:(NSString *)city spaceSite:(NSString *)spaceSite fixPhone:(NSString *)fixPhone relationTel:(NSString *)relationTel spaceState:(NSNumber *)spaceState creationTime:(NSString *)creationTime spacePicture:(NSString *)spacePicture;
@end

@interface WOTSpaceModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTSpaceModel> *msg;

@end
