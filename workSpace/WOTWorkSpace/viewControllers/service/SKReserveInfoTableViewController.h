//
//  SKReserveInfoTableViewController.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSpaceModel.h"
#import "SKMyEnterModel.h"
typedef NS_ENUM(NSInteger,ENTER_INTERFACE_TYPE) {
    ENTER_INTERFACE_TYPE_SHOW,
    ENTER_INTERFACE_TYPE_EDIT,
};
@interface SKReserveInfoTableViewController : UIViewController
@property(nonatomic,strong)WOTSpaceModel *spaceModel;
@property(nonatomic,strong)SKMyEnterModel *enterModel;
@property(nonatomic,assign)ENTER_INTERFACE_TYPE enterInterfaceType;
@end
