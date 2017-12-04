//
//  WOTworkSpaceLIstVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSpaceModel.h"
@interface WOTworkSpaceLIstVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (strong,nonatomic)NSMutableArray<WOTSpaceModel *> *dataSource;
@end
