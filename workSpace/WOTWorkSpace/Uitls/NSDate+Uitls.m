//
//  NSDate+Uitls.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "NSDate+Uitls.h"

@implementation NSDate (Uitls)

+(NSString *)getNewTimeZero
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY/MM/dd 00:00:00"];
    NSString *DateTime = [formatter stringFromDate:date];
//    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}

+(NSString *)getTomorrowTimeZero
{
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"YYYY/MM/dd 00:00:00"];
    NSString * DateTime =[dateday stringFromDate:beginningOfWeek];
//    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}


+(NSString *)timeDifference:(NSString *)dateStr
{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+8"]];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =kCFCalendarUnitYear |kCFCalendarUnitMonth |NSCalendarUnitDay |kCFCalendarUnitHour |kCFCalendarUnitMinute |kCFCalendarUnitSecond;
    NSDateComponents *compas = [calendar components:unit fromDate:date toDate:nowDate options:0];
    NSMutableString *result = nil;
    if (compas.year!=0) {
//        [result appendFormat:@"%ld年",(long)compas.year];
        result = [NSMutableString stringWithFormat:@"%ld年前",(long)compas.year];
    }
    else if (compas.month!=0) {
        result = [NSMutableString stringWithFormat:@"%ld个月前",(long)compas.month];
    }
    else if (compas.day!=0) {
        result = [NSMutableString stringWithFormat:@"%ld天前",(long)compas.day];
    }
    else if (compas.hour!=0) {
        result = [NSMutableString stringWithFormat:@"%ld小时前",(long)compas.hour];
    }
    else if (compas.minute!=0) {
        result = [NSMutableString stringWithFormat:@"%ld分钟前",(long)compas.minute];
    }
    return result;
}

@end
