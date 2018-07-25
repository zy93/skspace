//
//  WORTMyEnterpriseVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTEnterpriseModel.h"

@interface WOTMyEnterpriseVC : UIViewController

@property (nonatomic, assign, getter=isSelectEnterprise) BOOL selectEnterprise;
@property (nonatomic, copy) void(^selectEnterpriseBlock)(WOTEnterpriseModel *model);

@property(nonatomic,copy)NSString *firstString;
@end
