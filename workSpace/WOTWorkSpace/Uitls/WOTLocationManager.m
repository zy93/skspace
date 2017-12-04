//
//  WOTLocationManager.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface WOTLocationManager () <CLLocationManagerDelegate>
{
    LocationBlock locationBlock;
}


@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation WOTLocationManager

+(WOTLocationManager *)shareLocation
{
    static WOTLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WOTLocationManager alloc] init];
    });
    
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self load];
    }
    return self;
}

-(void)load
{
    //创建定位对象
    _locationManager =[[CLLocationManager alloc] init];
    //设置定位属性
    _locationManager.desiredAccuracy =kCLLocationAccuracyBest;
    //设置定位更新距离militer
    _locationManager.distanceFilter=10.0;
    //绑定定位委托
    _locationManager.delegate=self;
    //取出当前应用的定位服务状态(枚举值)
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    
    //如果未授权则请求
    if(status==kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //开始定位
//    [_locationManager startUpdatingLocation];
}




-(void)getLocationWithBlock:(LocationBlock)block
{
    locationBlock = block;
    //开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate

//定位后的返回结果
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //locations数组中存储的是CLLocation
    CLLocation *location =[locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
//    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    //2017-9-25 东添加start
    
    //2017-9-25 东添加end
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //NSMutableString *cityName = [[NSMutableString alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        
        
        for (CLPlacemark *place in placemarks) {
            NSLog(@"name,%@",place.name);                      // 位置名
            
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            
            NSLog(@"locality,%@",place.locality);              // 市
            
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            
            NSLog(@"country,%@",place.country);                // 国家
//            if ([JudgeIDAndBankCard isEmptyOrNull:_gpsCityName]) {
//                _gpsCityName=@"定位失败";
//            }
//            WRITE_DATA(place.locality,@"CITY_JC_NAME");
            if (locationBlock) {
                locationBlock(coordinate.latitude, coordinate.longitude,place.locality);
            }
        }
        
    }];
    
    
}



@end
