//
//  WOTWorkspaceListVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTSelectWorkspaceListVC : UIViewController//1
@property (nonatomic, copy) void(^selectSpaceBlock)(WOTSpaceModel *model);
@end
