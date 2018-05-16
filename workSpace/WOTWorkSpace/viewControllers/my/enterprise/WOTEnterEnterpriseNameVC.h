//
//  WOTEnterEnterpriseNameVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTableViewBaseVC.h"
#import "WOTEnterCell.h"
#import "WOTMyEnterPriseCell.h"

@interface WOTEnterEnterpriseNameVC : WOTTableViewBaseVC

@property (nonatomic, strong) void (^enterpriseName)(NSString *enterpriseName);
@property (nonatomic, copy)NSString *titleStr;//Notice
@property (nonatomic, copy)NSString *noticeStr;
@property (nonatomic, assign)BOOL isShow;
@end
