//
//  SKPayDelegateModel.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/16.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKPayDelegateModel.h"

@implementation SKPayDelegateModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

@implementation SKPayDelegateModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
