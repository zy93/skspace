//
//  WOTActivityModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTActivityModel.h"

@implementation WOTActivityModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTActivityModel_list
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTActivityModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTMyActivityModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTMyActivityModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
