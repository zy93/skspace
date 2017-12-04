//
//  WOTEnumUtils.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTEnumUtils.h"

#import "WOTEnums.h"

@implementation WOTEnumUtils
-(WOT3DBallVCType)Wot3DballVCtypeenumToString:(NSString *)ballTitle{
    WOT3DBallVCType type;
  
        
        if ([ballTitle isEqualToString:@"友邻"]) {
            type = WOTEnterprise;
           
        } else if([ballTitle isEqualToString:@"订工位"]) {
            type = WOTBookStation;
          
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
            
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
          
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
            
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
            
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
            
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
            
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
           
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
          
        }else if([ballTitle isEqualToString:@"订会议室"]) {
            type = WOTReservationsMeeting;
            
        }else {
            type = WOTOthers;
            
        }
    return  type;
}
-(NSString *)WOTFeedBackStateToString:(NSInteger)state{
    
    switch ([self intToEnum_FeedBackStateType:state]) {
        case WOTFeedBackUnRead:
            return @"未读";
            break;
        case WOTFeedBackRead:
            return @"已读";
        default:
            break;
    }
}

-(WOTFeedBackStateType)intToEnum_FeedBackStateType:(NSInteger)intstate{
    switch (intstate) {
        case 0:
            return WOTFeedBackUnRead;
            break;
        case 1:
            return WOTFeedBackRead;
            
        default:
            break;
    }
    return WOTFeedBackUnRead;
}
@end
