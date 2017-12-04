//
//  WOTMeetingReservationsModel.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMeetingReservationsModel.h"


@implementation WOTReservationsResponseModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTReservationsResponseModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end


@implementation WOTMeetingReservationsModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end


@implementation WOTMeetingReservationsModel_msg

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
