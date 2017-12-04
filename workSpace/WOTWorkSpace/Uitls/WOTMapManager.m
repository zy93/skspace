//
//  WOTMapManager.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMapManager.h"

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
@interface WOTMapManager(){
    
}

@end



@implementation WOTMapManager
+(WOTMapManager *)shared{
    static WOTMapManager *instence;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[WOTMapManager alloc]init];
    });
    
    return instence;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self configMap];
    }
    return self;
}
-(void)configMap{
    self.mapmanager = [[AMapLocationManager alloc]init];

    [self.mapmanager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    [self.mapmanager setPausesLocationUpdatesAutomatically:NO];
    
    
    [self.mapmanager setLocationTimeout:DefaultLocationTimeout];
    
    [self.mapmanager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}





@end
