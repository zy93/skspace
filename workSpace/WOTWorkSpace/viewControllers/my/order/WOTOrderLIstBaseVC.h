//
//  WOTOrderLIstBaseVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTEnums.h"
#import "WOTTableViewBaseVC.h"
@interface WOTOrderLIstBaseVC : UIViewController

@property(nonatomic,strong)NSArray *datasource;
@property(nonatomic,assign)WOTPageMenuVCType orderlisttype;

@end
