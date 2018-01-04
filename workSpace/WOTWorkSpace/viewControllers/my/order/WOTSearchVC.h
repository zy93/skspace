//
//  WOTSearchVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTableViewBaseVC.h"
#import "WOTEnterpriseModel.h"
#import "UIViewController+Extension.h"
@interface WOTSearchVC : WOTTableViewBaseVC

@property (nonatomic, strong)NSArray <WOTEnterpriseModel *> *dataSource;
@property (nonatomic, strong) searchBlock block;  //该属性需要与extension中定义相同。
@property (nonatomic, strong) clearSearchBlock clearBlock; //该属性需要与extension中定义相同。
@end

