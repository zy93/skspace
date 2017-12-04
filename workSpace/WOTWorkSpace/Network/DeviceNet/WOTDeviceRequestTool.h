//
//  WOTDeviceRequestTool.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTP_HOST @"http://www.e-harbour.net/"
#define HTTP_Service @"http://www.yiliangang.net/"
#define SOCKET_HOST @"moblie.e-harbour.net:8999"




@class WOTDeviceRequestTool;
@protocol WOTRequestToolDelegate<NSObject>
-(void)requestTool:(WOTDeviceRequestTool*)requestTool isSuccess:(BOOL)isSuccess dict:(NSDictionary*)dict;
@end

@interface WOTDeviceRequestTool : NSObject

-(void)sendGetRequestWithExStr:(NSString*)exStr andParam:(NSDictionary<NSString*,NSString*>*)param;
-(void)sendPostRequestWithExStr:(NSString*)exStr andParam:(NSDictionary<NSString*,NSString*>*)param;
-(void)sendPostRequestWithUri:(NSString*)uri andParam:(NSDictionary<NSString*,NSString*>*)param;

-(void)sendPostJsonRequestWithExStr:(NSString*)exStr andParam:(NSDictionary<NSString*,NSString*>*)param;
@property(nonatomic,weak) id<WOTRequestToolDelegate> delegate;

@end
