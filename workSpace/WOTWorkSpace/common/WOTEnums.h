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
    WOTPageMenuVCTypeMetting = 0,
    WOTPageMenuVCTypeStation,
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
