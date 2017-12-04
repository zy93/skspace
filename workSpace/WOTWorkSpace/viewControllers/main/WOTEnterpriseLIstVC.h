//
//  WOTEnterpriseLIstVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTEnterpriseModel.h"
@interface WOTEnterpriseLIstVC : UIViewController
@property(nonatomic,strong)NSArray<WOTEnterpriseModel *> *dataSource;

-(void)getEnterpriseListDataFromWeb:(void(^)())complete;

@end
