//
//  SKDemandInfoViewController.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DEMAND_INTERFACE_TYPE) {
    DEMAND_INTERFACE_TYPE_SHOW,
    DEMAND_INTERFACE_TYPE_EDIT,
};

@interface SKDemandInfoViewController : UIViewController

@property(nonatomic,strong)NSString *typeString;
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic,assign)DEMAND_INTERFACE_TYPE interfaceType;
@end
