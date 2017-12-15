//
//  WOTNewInformationModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTNewsModel.h"

@implementation WOTNewsModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation WOTNewsModel_list
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation WOTNewsModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
