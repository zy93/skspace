//
//  WOTUserSingleton.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserSingleton.h"
#import <objc/runtime.h>

@implementation WOTUserSingleton

-(id)initSingleton{
    if ((self = [super init])) {
        [self setValues];
    }
    return self;
}


+(instancetype)shareUser{
    static WOTUserSingleton *shareUser;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        shareUser = [[self alloc] initSingleton];
    });
    
    return shareUser;
}

-(void)setValues{
    NSDictionary *dic = [self readUserInfoFromPlist];
    NSError *error;
    _userInfo = [[WOTLoginModel alloc] initWithDictionary:dic error:&error];
}

-(void)saveUserInfoToPlistWithModel:(WOTLoginModel *)model
{
    NSDictionary *dic = [self buildDictionayByModel:model];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];

    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"userInfo.plist"];
    //输入写入
    NSLog(@"fileName:%@",filename);
    [dic writeToFile:filename atomically:YES];

    [self setValues];
    
}
-(NSDictionary *)readUserInfoFromPlist{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
       NSString *filename=[plistPath1 stringByAppendingPathComponent:@"userInfo.plist"];
    NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    NSLog(@"%@", user);
    return user;
}

-(NSDictionary *)buildDictionayByModel:(WOTLoginModel *)model
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    unsigned int outCount = 0;
    Class cl = [model class];
    objc_objectptr_t *properties = class_copyPropertyList(cl, &outCount);
    
    for (int i = 0; i<outCount; i++) {
        SEL selector;
        objc_objectptr_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        selector = NSSelectorFromString(propertyName);
        id propertyValue;
        if (![model respondsToSelector:selector]) {
            continue;
        }
        propertyValue = [model performSelector:selector];
        [dic setValue:propertyValue forKey:propertyName];
    }
    return [dic copy];
}

@end
