//
//  NSArray+ImageArray.m
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/2/1.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "NSArray+ImageArray.h"

@implementation NSArray (ImageArray)


+(NSMutableArray *)imageArrayWithString:(NSString *)imageStr
{
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (NSString *imageString in [imageStr componentsSeparatedByString:@","]) {
        [imageArray addObject:[imageString ToResourcesUrl]];
    }
    return imageArray;
}

@end
