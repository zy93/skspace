//
//  WOTFileUitls.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTFileUitls.h"

@implementation WOTFileUitls


+(NSDictionary *)readPlistFileForFileName:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //    //添加一项内容
    //    //获取应用程序沙盒的Documents目录
    //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString *plistPath1 = [paths objectAtIndex:0];
    return dataDic;
    
}

+(NSArray *)readArrayPlistFileForFileName:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //    //添加一项内容
    //    //获取应用程序沙盒的Documents目录
    //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString *plistPath1 = [paths objectAtIndex:0];
    return dataArr;
    
}

//获取Documents目录
+(NSString *)documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

//创建目录
+(BOOL)createDirectoryWithPath:(NSString *)directoryPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //创建目录
    BOOL res=[fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (res)
    {
        NSLog(@"目录创建成功：%@",directoryPath);
    }else
    {
        NSLog(@"目录创建失败：%@",directoryPath);
    }
    return res;
}

//创建文件
+(BOOL)createFileWithPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
    }else
        NSLog(@"文件创建失败: %@" ,filePath);
    return res;
}

//删除文件
+(BOOL)deleteFileWithPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager removeItemAtPath:filePath error:nil];
    if (res) {
        NSLog(@"文件删除成功: %@",filePath);
    }else
        NSLog(@"文件删除失败: %@",filePath);
    return res;
}

//文件是否存在
+(BOOL)existFileAtPath:(NSString *)filePath
{
    NSFileManager * fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

@end
