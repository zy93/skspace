//
//  WOTLocationManager.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^LocationBlock)(CGFloat lat, CGFloat lon, NSString *cityName);

//定位管理

@interface WOTLocationManager : NSObject

+(WOTLocationManager *)shareLocation;

-(void)getLocationWithBlock:(LocationBlock)block;
//根据经纬度获取城市名称
-(NSString *)getCityNameWithLat:(CGFloat)lat Lon:(CGFloat)lon;
@end
