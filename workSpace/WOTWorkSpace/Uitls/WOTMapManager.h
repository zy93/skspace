//
//  WOTMapManager.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "AMapLocationKit/AMapLocationKit.h"
@interface WOTMapManager : NSObject
@property( nonatomic,strong)AMapLocationManager *mapmanager;

@property(nonatomic,strong)AMapLocationReGeocode *locationReocode;
+(WOTMapManager *)shared;

@end
