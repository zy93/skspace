//
//  WOTMyActivitiesBaseVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTableViewBaseVC.h"
@interface WOTMyActivitiesBaseVC : WOTTableViewBaseVC

@property(nonatomic,strong)NSArray *datasource;
@property(nonatomic,assign)NSString *vctype;
-(void)getActivityDataSourceFromWeb:(NSString *)state;
@end
