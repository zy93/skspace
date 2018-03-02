//
//  SKMapViewController.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSpaceModel.h"
//路线类型
typedef NS_ENUM(NSInteger, PATH_TYPE) {
    PATH_TYPE_BUS,
    PATH_TYPE_DRIVE,
    PATH_TYPE_CYCLING,
    PATH_TYPE_WALK,
};
@interface SKMapViewController : UIViewController
@property (nonatomic, assign) PATH_TYPE pathType;
@property (nonatomic, strong) WOTSpaceModel *spaceModel;
@end
