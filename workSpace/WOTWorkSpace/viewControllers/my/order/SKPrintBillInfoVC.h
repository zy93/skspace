//
//  SKPrintBillInfoVC.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 14/8/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTWorkStationHistoryModel.h"

@interface SKPrintBillInfoVC : UIViewController

@property (nonatomic,copy) NSString *printBillState;
@property (nonatomic, strong) WOTWorkStationHistoryModel * model;

@end
