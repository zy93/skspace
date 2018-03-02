//
//  SKMyActivityModel.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKMyActivityModel.h"

@implementation SKMyActivityModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation SKMyActivityModel_list
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation SKMyActivityModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
