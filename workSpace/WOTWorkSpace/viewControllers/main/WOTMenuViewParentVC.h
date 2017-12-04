//
//  WOTMenuViewParentVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTMenuView.h"
@interface WOTMenuViewParentVC : UIViewController
@property (nonatomic, strong) WOTMenuView *menuView1;
@property (nonatomic, strong) WOTMenuView *menuView2;
@property (nonatomic, strong) NSMutableArray *menu1Array;
@property (nonatomic, strong) NSMutableArray *menu2Array;
@end
