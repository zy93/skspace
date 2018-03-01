//
//  WOTBookStationListModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol WOTBookStationListModel <NSObject>

@end

@interface WOTBookStationListModel : JSONModel


//@property(nonatomic,strong)NSNumber* spaceId;
//@property(nonatomic,strong)NSString *spaceName;
//@property(nonatomic,strong)NSString *spaceDescribe;
//@property(nonatomic,strong)NSString *city;
//@property(nonatomic,strong)NSString *spaceSite;
//@property(nonatomic,strong)NSString *fixPhone;
//@property(nonatomic,strong)NSString *relationTel;
//@property(nonatomic,strong)NSNumber *spaceState;
//@property(nonatomic,strong)NSString *creationTime;
//@property(nonatomic,strong)NSString *spacePicture;
//@property(nonatomic,strong)NSNumber *lat;
//@property(nonatomic,strong)NSNumber *lng;
//@property(nonatomic,strong)NSNumber *leaseConditions; //长短租
//@property(nonatomic,strong)NSNumber *shortRent;
//@property(nonatomic,strong)NSNumber *longRent;
//@property(nonatomic,strong)NSString *spaceStar;
//@property(nonatomic,strong)NSString *spaceUrl;


@property(nonatomic,strong)NSNumber* spaceId;
@property(nonatomic,strong)NSNumber* rentType;
@property(nonatomic,strong)NSNumber* stationId;
@property(nonatomic,strong)NSNumber* stationPrice;
@property(nonatomic,strong)NSNumber* stationState;
@property(nonatomic,strong)NSNumber* stationType;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *openTime;
@property(nonatomic,strong)NSString *stationPicture;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;

@end

@protocol WOTBookStationListModel_msg_List <NSObject>

@end

@protocol WOTBookStationListModel_msg_dic <NSObject>

@end

@interface WOTBookStationListModel_msg_List : JSONModel
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSArray <WOTBookStationListModel> *cityList;

@end


@interface WOTBookStationListModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray  <WOTBookStationListModel> *msg;
//@property(nonatomic,strong)NSArray  <WOTBookStationListModel_msg_List> *msg;

@end
