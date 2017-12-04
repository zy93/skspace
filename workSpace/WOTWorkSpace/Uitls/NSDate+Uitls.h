//
//  NSDate+Uitls.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Uitls)
//获取今天零点时间
+(NSString *)getNewTimeZero;
//获取明天零点时间
+(NSString *)getTomorrowTimeZero;
//获取时间
//+(NSString *)getTomorrowTimeZero;

//计算传入时间与当前时间差 //2017/08/25 17:06:37
+(NSString *)timeDifference:(NSString *)dateStr;

@end
