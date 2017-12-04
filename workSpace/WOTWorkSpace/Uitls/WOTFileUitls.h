//
//  WOTFileUitls.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTFileUitls : NSObject

//读取程序开发时配置plist文件
+(NSDictionary *)readPlistFileForFileName:(NSString *)fileName;
+(NSArray *)readArrayPlistFileForFileName:(NSString *)fileName;


//获取沙盒Documents文件夹路径
+(NSString *)documentsPath;
//创建目录，若父目录不存在则会连同父目录一起创建
+(BOOL)createDirectoryWithPath:(NSString *)directoryPath;
//创建文件，若文件已经存在则返回YES，若不存在则创建文件，创建成功返回YES，创建失败返回NO
+(BOOL)createFileWithPath:(NSString *)filePath;
//文件是否存在
+(BOOL)existFileAtPath:(NSString *)filePath;
//删除文件，若删除成功 或 文件不存在，则返回YES，否则返回NO
+(BOOL)deleteFileWithPath:(NSString *)filePath;
@end
