//
//  WOTPageMenuParentVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTEnums.h"
#import "XXPageTabView.h"
#import "XXPageTabItemLable.h"
@interface WOTPageMenuParentVC : UIViewController
@property(assign)WOTPageMenuVCType vctype;
@property (nonatomic, strong) XXPageTabView *pageTabView;

@end
