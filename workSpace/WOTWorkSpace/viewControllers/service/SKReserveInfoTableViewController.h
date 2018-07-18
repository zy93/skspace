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
#import "SKFacilitatorModel.h"
typedef NS_ENUM(NSInteger,ENTER_INTERFACE_TYPE) {
    ENTER_INTERFACE_TYPE_SHOW,
    ENTER_INTERFACE_TYPE_EDIT,
};

typedef NS_ENUM(NSInteger,TYPE_INFO) {
    TYPE_INFO_FACILITATOR,//服务商
    TYPE_INFO_OTHER,
};
@interface SKReserveInfoTableViewController : UIViewController
@property(nonatomic,strong)WOTSpaceModel *spaceModel;
@property(nonatomic,strong)SKMyEnterModel *enterModel;
@property(nonatomic,assign)ENTER_INTERFACE_TYPE enterInterfaceType;
@property(nonatomic,assign)TYPE_INFO typeInfo;
@property(nonatomic,strong) SKFacilitatorInfoModel *facilitatorModel;

@end
