//
//  NSString+Extension.h
//  LYFaultDiagnosis
//
//  Created by YNKJMACMINI2 on 15/11/20.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//时间格式 字符串
#define kDateFormatString1 @"yyyy-MM-dd HH:mm:ss"
#define kDateFormatString2 @"yyyy-MM-dd a HH:mm:ss"
#define kDateFormatString3 @"yyyy-MM-dd a HH:mm:ss EEEE"
//.....

@interface NSString (Size)
//获取在特定字体下，单行显示该字符串所需要的宽度
-(CGFloat)widthWithFont:(UIFont *)f;
//获取在特定字体、特定宽度下，多行显示该字符串所需要的高度
-(CGFloat)heightWithFont:(UIFont *)f maxWidth:(CGFloat)mWidth;

- (CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
-(NSArray<NSString *>*)separatedWithString:(NSString *)separatedString;
-(NSURL *)ToUrl;
@end

@interface NSString (Date)
//将NSString类型的时间 根据格式字符串 转换为NSDate类型
+(NSDate *)dataWithFormat:(NSString *)format;

//获取年、月、日、时、分、秒数组 传入： 2017/07/18 12:20:59, 传出：@[@(2017),@(7),@(18),@(12),@(20),@(59)]
-(NSArray*)getYearToSecondArray;
//获取时、分、秒数组 //传入：12:20:59, 传出：@[@(12),@(20),@(59)]
-(NSArray*)getHourToSecondArray;
//获取10进制时间，0.5=30分钟  //传入: 09:30:00-20:00:00 传出:@[@(9.5),@(20)]
-(NSArray*)getDECTime;
//获取开始与结束时间范围内时间数组.
+(NSArray*)getReservationsTimesWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
//获取后台所需预约时间格式
+(NSArray*)getReservationsTimesWithDate:(NSString*)date StartTime:(CGFloat)startTime endTime:(CGFloat)endTime;
//数字时间转文字时间  input:9.5  output:9:30
+(NSString*)floatTimeConvertStringTime:(CGFloat)time;

//判断电话格式
+ (BOOL)valiMobile:(NSString*)mobile;



@end
