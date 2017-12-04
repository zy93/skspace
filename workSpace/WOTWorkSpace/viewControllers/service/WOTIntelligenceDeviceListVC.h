//
//  WOTIntelligenceDeviceListVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTDeviceInfoModel.h"
#import "SRWebSocket.h"
@interface WOTIntelligenceDeviceListVC : UIViewController
@property(nonatomic,strong)WOTDeviceInfoModel *device;
@property(nonatomic,strong) SRWebSocket *webSocket;
-(void)sendWebSocketStringWithParam:(NSDictionary*)param;
-(NSString*)imageAddExStr:(NSString*)imageStr;
@end
