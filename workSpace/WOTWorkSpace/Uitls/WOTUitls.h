//
//  WOTUitls.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTUitls : NSObject

+ (NSString *)md5HexDigestByString:(NSString*)input;//返回 长度为32字节的字符串
+ (NSString *)md5HexDigestByData:(NSData*)input;    //返回 长度为32字节的字符串

//获取屏幕比率
+(CGFloat) GetLengthAdaptRate;
+(NSData *)StringToByte:(NSString *)str;


@end
