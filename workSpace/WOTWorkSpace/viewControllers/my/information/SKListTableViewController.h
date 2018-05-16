//
//  SKListTableViewController.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,NOTIFICATION_TYPE) {
    NOTIFICATION_TYPE_DEMAND,//需求
    NOTIFICATION_TYPE_ENTER,//入驻
};

@interface SKListTableViewController : UITableViewController

@property(nonatomic,assign)NOTIFICATION_TYPE notificationType;

@end
