//
//  WOTDeviceListRequestTool.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^WOTDeviceBlock)(NSArray *arr);
@interface WOTDeviceListRequestTool : NSObject

//获取所有设备-请不要用单例调用
#warning 请不要用单例调用
-(void)sendRequestToGetAllDeviceWithGroupId:(NSNumber*)groupId Response:(WOTDeviceBlock)deviceBlock;

@end
