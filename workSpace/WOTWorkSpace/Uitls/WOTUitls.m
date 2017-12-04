//
//  WOTUitls.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUitls.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIDevice+Resolutions.h"

@implementation WOTUitls



+ (NSString *)md5HexDigestByString:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
   	return [self md5HexDigestByData:data];
}

+ (NSString *)md5HexDigestByData:(NSData*)input
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( input.bytes, (CC_LONG)input.length, result );
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}


+(CGFloat) GetLengthAdaptRate
{
    CGFloat rate = 1;
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4 ||
       [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
    {
        rate = 320/375.0;
    }
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47)
    {
        rate = 1;
        
        //rate = 0.91;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55)
    {
        rate = 414/375.0;
        //rate = 1.18;
    }
    /*else if(([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4||[[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35) && [BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.0] && (![BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.1]))
     {
     //rate = 375.0/414.0;
     rate = 320.0/414.0;
     rate = 1;
     }*/
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina )
    {
        return 768.0/320.0;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
    {
        return 768.0/320.0;
    }
    return rate;
}


+(NSData *)StringToByte:(NSString *)str
{
    unsigned char temp[1024] ;
    int i ;
    for (i=0; i < str.length/2; i++) {
        NSRange _range = NSMakeRange(i*2, 2);
        temp[i] = strtoul([[str substringWithRange:_range] UTF8String], 0, 16);
    }
    NSData *data = [NSData dataWithBytes:&temp length:str.length/2];
    return data;
}


@end
