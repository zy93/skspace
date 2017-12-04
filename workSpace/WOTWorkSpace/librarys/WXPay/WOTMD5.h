//
//  WOTMD5.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTMD5 : NSObject
+ (NSString *)md5:(NSString *)input;

+ (NSString *)sha1:(NSString *)input;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (NSDictionary *)getIPAddresses;
@end
