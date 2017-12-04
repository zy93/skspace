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


//@property(nonatomic,assign)NSNumber* spaceId;
//@property(nonatomic,strong)NSString *spaceName;
//@property(nonatomic,strong)NSString *spaceDescribe;
//@property(nonatomic,strong)NSString *city;
//@property(nonatomic,strong)NSString *spaceSite;
//@property(nonatomic,strong)NSString *fixPhone;
//@property(nonatomic,strong)NSString *relationTel;
//@property(nonatomic,assign)NSNumber *spaceState;
//@property(nonatomic,strong)NSString *creationTime;
//@property(nonatomic,strong)NSString *spacePicture;
//@property(nonatomic,assign)NSNumber *lat;
//@property(nonatomic,assign)NSNumber *lng;
//@property(nonatomic,assign)NSNumber *leaseConditions; //长短租
//@property(nonatomic,assign)NSNumber *shortRent;
//@property(nonatomic,assign)NSNumber *longRent;
//@property(nonatomic,strong)NSString *spaceStar;
//@property(nonatomic,strong)NSString *spaceUrl;


@property(nonatomic,assign)NSNumber* spaceId;
@property(nonatomic,assign)NSNumber* rentType;
@property(nonatomic,assign)NSNumber* stationId;
@property(nonatomic,assign)NSNumber* stationPrice;
@property(nonatomic,assign)NSNumber* stationState;
@property(nonatomic,assign)NSNumber* stationType;
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
