//
//  NSString+Extension.m
//  LYFaultDiagnosis
//
//  Created by YNKJMACMINI2 on 15/11/20.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Size)
-(CGFloat)widthWithFont:(UIFont *)f
{
    NSDictionary *attribute = @{NSFontAttributeName:f};
    
    CGFloat stringWidth = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, f.lineHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.width;
    return stringWidth;
    
}
-(CGFloat)heightWithFont:(UIFont *)f maxWidth:(CGFloat)mWidth
{
    NSDictionary *attribute = @{NSFontAttributeName:f};
    CGFloat stringHeight = [self boundingRectWithSize:CGSizeMake(mWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
    return stringHeight;
}

- (CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}


-(NSArray<NSString *> *)separatedWithString:(NSString *)separatedString
{
    if ([self isEqualToString:@""]||self == nil) {
        return [[NSArray alloc]init];
    } else {
        NSArray<NSString *> *stringArray = [self componentsSeparatedByString:separatedString];
        return stringArray;
    }
   
}
@end

@implementation NSString (Date)
+(NSDate *)dataWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:self];
    return date;
}

-(NSURL *)ToUrl{
    NSString *base = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,self];
    return [NSURL URLWithString:base];
}

-(NSArray *)getYearToSecondArray
{
    NSArray *dateArr1 = [self componentsSeparatedByString:@" "];
    NSArray *dateArr2= [dateArr1.firstObject componentsSeparatedByString:@"/"];
    NSArray *dateArr3 = [dateArr1.lastObject componentsSeparatedByString:@":"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:dateArr2];
    [arr addObjectsFromArray:dateArr3];
    
    return arr;
}

-(NSArray *)getHourToSecondArray
{
    NSArray *dateArr1 = [self componentsSeparatedByString:@" "];
    NSArray *dateArr2 = [dateArr1.lastObject componentsSeparatedByString:@":"];
    return dateArr2;
}

-(NSArray*)getDECTime
{
    NSArray *openTimes = [self componentsSeparatedByString:@"-"];
    NSArray *beginTimes =[openTimes.firstObject componentsSeparatedByString:@":"];
    NSArray *endTimes =[openTimes.lastObject componentsSeparatedByString:@":"];
//    NSLog(@"---%@\n%@",beginTimes,endTimes);
    CGFloat begT = 0.f;
    if (beginTimes.count <2 || endTimes.count <2  ) {
        return @[@(9), @(23)];
    }
    
    if ([beginTimes[1] integerValue]>=30) {
        begT = [beginTimes.firstObject integerValue]+0.5;
    }
    else {
        begT = [beginTimes.firstObject integerValue];
    }
    
    CGFloat endT = 0.f;
    if ([endTimes[1] integerValue]>=30) {
        endT = [endTimes.firstObject integerValue]+0.5;
    }
    else {
        endT = [endTimes.firstObject integerValue];
    }
    
    return @[@(begT),@(endT)];
}

+(NSArray *)getReservationsTimesWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSArray *startArr = [startTime getYearToSecondArray];
    NSArray *endArr = [endTime getYearToSecondArray];
    CGFloat beginValue =0; //[startArr[3] floatValue];
    CGFloat endValue = 0;//[endArr[4] floatValue];
    
    if ([startArr[4] integerValue]>=30) {
        beginValue = [startArr[3] integerValue]+0.5;
    }
    else {
        beginValue = [startArr[3] integerValue];
    }
    
    if ([endArr[4] integerValue]>=30) {
        endValue = [endArr[3] integerValue]+0.5;
    }
    else {
        endValue = [endArr[3] integerValue];
    }
    
    return @[@(beginValue),@(endValue)];
}

+(NSArray *)getReservationsTimesWithDate:(NSString *)date StartTime:(CGFloat)startTime endTime:(CGFloat)endTime
{
    BOOL isInteger = startTime-(int)startTime>0?NO:YES;
    NSString *startT =[NSString stringWithFormat:@"%02d:%02d:00",(int)startTime,isInteger?0:30];
    isInteger = endTime-(int)endTime>0?NO:YES;
    NSString *endT   =[NSString stringWithFormat:@"%02d:%02d:00",(int)endTime,isInteger?0:30];
    startT = [date stringByReplacingOccurrencesOfString:@"00:00:00" withString:startT];
    endT   = [date stringByReplacingOccurrencesOfString:@"00:00:00" withString:endT];
    return @[startT,endT];
}

+(NSString *)floatTimeConvertStringTime:(CGFloat)time
{
    BOOL isInteger = time-(int)time>0?NO:YES;
    if (isInteger) {
        return [NSString stringWithFormat:@"%02d:00",(int)time];
    }
    else {
        return [NSString stringWithFormat:@"%02d:30",(int)time];
    }
    
}

+ (BOOL)valiMobile:(NSString*)mobile
{
    mobile = [mobile  stringByReplacingOccurrencesOfString:@" "withString:@""];
        if (mobile.length != 11)
            {
                    return NO;
                }else{
                        /**
                                  * 移动号段正则表达式
                                  */
                        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
                        /**
                                  * 联通号段正则表达式
                                  */
                        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
                        /**
                                  * 电信号段正则表达式
                                  */
                        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
                        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
                        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
                        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
                        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
                 
                        if (isMatch1 || isMatch2 || isMatch3) {
                                return YES;
                            }else{
                                    return NO;
                                }
                    }
}

@end
