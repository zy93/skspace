//
//  WOTEnums.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#ifndef WOTEnums_h
#define WOTEnums_h


typedef NS_ENUM(NSInteger, WOTPageMenuVCType) {
    WOTPageMenuVCTypeAll = 0, //全部订单
    WOTPageMenuVCTypeMeeting, //会议室
    WOTPageMenuVCTypeStation, //工位
    WOTPageMenuVCTypeLongTimeStation,//长租工位
    WOTPageMenuVCTypeSite,    //场地
    WOTPageMenuVCTypeGiftBag, //礼包
};


typedef NS_ENUM(NSInteger, WOT3DBallVCType) {
    WOTEnterprise = 0,
    WOTBookStation,
    WOTReservationsMeeting,
    WOTOthers,

};

typedef NS_ENUM(NSInteger, WOTFeedBackStateType) {
    WOTFeedBackUnRead = 0,
    WOTFeedBackRead,
};


#endif /* WOTEnums_h */
