//
//  WOTUserSingleton.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserSingleton.h"
#import <objc/runtime.h>
static WOTUserSingleton *shareUser;
static dispatch_once_t token;
@implementation WOTUserSingleton

-(id)initSingleton{
    if ((self = [super init])) {
        [self setValues];
    }
    return self;
}


+(instancetype)shareUser{
    
    dispatch_once(&token, ^{
        shareUser = [[self alloc] initSingleton];
    });
    
    return shareUser;
}

+ (void)destroyInstance {
    
    shareUser=nil;
    token=0l;
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

-(void)deletePlistFile{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
        
    }
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
