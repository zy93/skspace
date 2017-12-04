//
//  WOTBueToothManager.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface WOTBueToothManager : NSObject
//中心管理者 必须创建一个中心管理着
@property (nonatomic,retain) CBCentralManager *cMgr;
//连接到的外设  
@property (nonatomic,strong) CBPeripheral *peripheral;
@end
