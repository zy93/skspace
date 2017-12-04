//
//  WOTDeviceInfoModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTDeviceInfoModel : NSObject
@property(nonatomic,strong) NSString *thingId;
@property(nonatomic,strong) NSString *templateId;
@property(nonatomic,strong) NSString *thingName;
@property(nonatomic,strong) NSString *harborIp;
@property(nonatomic,strong) NSString *picUrl;
@property(nonatomic,strong) NSNumber *state;
@property(nonatomic,strong) NSNumber *permission;
@end
