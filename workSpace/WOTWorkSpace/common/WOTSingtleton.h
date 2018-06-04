//
//  WOTSingtleton.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WOTLocationModel.h"


//订单页面类型
typedef NS_ENUM(NSInteger, ORDER_TYPE) {
    ORDER_TYPE_BOOKSTATION,
    ORDER_TYPE_MEETING,
    ORDER_TYPE_SITE,
    ORDER_TYPE_SPACE, //空间详情
    ORDER_TYPE_LONGTIME_BOOKSTATION,
};

typedef NS_ENUM(NSInteger,SKTIMETYPE) {
    SKTIMETYPE_SHORTPERIOD,
    SKTIMETYPE_LONGTIME,
};

typedef NS_ENUM(NSInteger,PAY_TYPE){
    PAY_TYPE_WX,
    PAY_TYPE_ALI,
};

typedef NS_ENUM(NSInteger, BUTTON_TYPE) {
    BUTTON_TYPE_STARTTIME,
    BUTTON_TYPE_ENDTIME,
    BUTTON_TYPE_ADDBUTTON,
    BUTTON_TYPE_SUBBUTTON,
};

@interface WOTSingtleton : NSObject
+(instancetype)shared;
//@property(nonatomic,strong)NSMutableArray *spaceCityArray;
@property(nonatomic,strong)NSArray *ballTitle;
@property(nonatomic,strong)NSArray *ballImage;
@property(nonatomic,assign)bool isuserLogin;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *QRcodeStr;
@property(nonatomic,assign)CGFloat userLat;
@property(nonatomic,assign)CGFloat userLng;

//会议室页面跳转记录，因涉及页面较多，在此记录当前操作。
@property (nonatomic, assign) ORDER_TYPE orderType;

@property (nonatomic, assign) BUTTON_TYPE buttonType;

@property (nonatomic, assign) PAY_TYPE payType;
//距离最近的空间
@property (nonatomic, strong) WOTSpaceModel *nearbySpace;

@property (nonatomic, assign) SKTIMETYPE skTimeType;



@end
