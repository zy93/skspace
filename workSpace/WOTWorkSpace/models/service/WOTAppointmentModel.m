//
//  WOTAppointmentModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/24.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTAppointmentModel.h"

@implementation WOTAppointmentModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTAppointmentModel_list
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTAppointmentModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTVisitorsModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
