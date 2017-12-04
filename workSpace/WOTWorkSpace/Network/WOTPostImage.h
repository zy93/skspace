//
//  WOTPostImage.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTPostImage : NSObject
// 请求成功回调block
typedef void(^Success)(id responseObject);
// 请求失败回调block
typedef void(^Failure)(NSError * error);

/** 创建网络请求管理类 */
+(instancetype)manager;

/**
 * ********************      向服务器上传图片       ********************
 *  urlStr  请求的网址
 *  params  发送请求的参数的字典
 *  imageArray  需要上传图片的数组
 *  file  接收上传文件的key的数组
 *  imageName  上传图片取什么名字的数组（自己取的）
 *
 */
-(void)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params imageArray:(NSArray *) imageArray file:(NSArray *)fileArray imageName:(NSArray *)imageNameArray Success :(Success)success andFailure:(Failure)failure;

@end
