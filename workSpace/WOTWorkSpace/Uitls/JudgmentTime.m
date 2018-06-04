//
//  JudgmentTime.m
//  ConstraintDemo
//
//  Created by 编程 on 2017/9/25.
//  Copyright © 2017年 wxd. All rights reserved.
//

#import "JudgmentTime.h"

@implementation JudgmentTime

-(BOOL)judgementTimeWithYear:(NSInteger) year month:(NSInteger)month day:(NSInteger)day
{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    BOOL isValidYear = [[formatter stringFromDate:date] intValue] > year;
    [formatter setDateFormat:@"MM"];
    BOOL isValidMonth1 = [[formatter stringFromDate:date] intValue] > month;
    BOOL isValidMonth2 = [[formatter stringFromDate:date] intValue] == month;
    [formatter setDateFormat:@"dd"];
    BOOL isValidDay = [[formatter stringFromDate:date] intValue] > day;
    if (isValidYear) {
        return NO;
    }
    if (isValidMonth1) {

        return NO;
    }
    if (isValidMonth2 && isValidDay) {
        return NO;
    }
    return YES;
}

//比较两个日期的大小
-(BOOL)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone: [NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *fromDate = [formatter dateFromString:aDate];
    NSDate *toDate = [formatter dateFromString:bDate];
    NSLog(@"%@,%@",fromDate,toDate);
    NSComparisonResult result = [fromDate compare:toDate];
    if (result==NSOrderedSame)//相等
    {
        return NO;
    }else if (result==NSOrderedAscending)//开始时间比结束时间小
    {
        return NO;
    }else if (result==NSOrderedDescending)//开始时间比结束时间大
    {
        return YES;
    }
    return NO;
}

//计算两个时间的字符串的相隔几天
-(NSInteger)numberOfDaysWithFromDate:(NSString *)fromDateString toDate:(NSString *)toDateString{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone: [NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [formatter dateFromString:fromDateString];
    NSDate *toDate = [formatter dateFromString:toDateString];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    *comp = [calendar components:NSCalendarUnitDay
                                            fromDate:fromDate
                                              toDate:toDate
                                             options:NSCalendarWrapComponents];
    return comp.day+1;
    
}

-(NSString *)activityStateWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];//当前时间
    if ([self compareDate:DateTime withDate:endTime]) {
        return @"已结束";
    }else if (![self compareDateWithStartTime:DateTime endTime:startTime])
    {
        return @"未开始";
    }else
    {
        return @"进行中";
    }
}

//比较两个日期的大小
-(BOOL)compareDateWithStartTime:(NSString*)startTime endTime:(NSString*)endTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //[formatter setTimeZone: [NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *fromDate = [formatter dateFromString:startTime];
    NSDate *toDate = [formatter dateFromString:endTime];
    NSLog(@"%@,%@",fromDate,toDate);
    NSComparisonResult result = [fromDate compare:toDate];
    if (result==NSOrderedSame)//相等
    {
        return YES;
    }else if (result==NSOrderedAscending)//开始时间比结束时间小
    {
        return NO;
    }else if (result==NSOrderedDescending)//开始时间比结束时间大
    {
        return YES;
    }
    return NO;
}


@end
