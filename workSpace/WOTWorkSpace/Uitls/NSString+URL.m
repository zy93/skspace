//
//  NSString+URL.m
//  IMAPswift
//
//  Created by Bjyn21 on 15/1/13.
//  Copyright (c) 2015年 bjyn. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)
-(NSString *)UrlEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self ,NULL ,CFSTR("!$&'()*+,-./:;=?@_~%#[]") ,kCFStringEncodingUTF8));
    return result;
}

-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

@end
