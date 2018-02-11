//
//  WOTLoginModel.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTLoginModel.h"


@implementation WOTLoginModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation WOTLoginModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end



@implementation WOTSearchModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end


@implementation WOTSearchModel_model
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTMyInviteModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
@implementation WOTMyInviteModel_model
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

