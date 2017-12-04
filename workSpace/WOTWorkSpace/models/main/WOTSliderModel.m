//
//  WOTSliderModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSliderModel.h"

@implementation WOTSliderModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID",
                                                       }];
}
@end

@implementation WOTSliderModel_msg


@end
