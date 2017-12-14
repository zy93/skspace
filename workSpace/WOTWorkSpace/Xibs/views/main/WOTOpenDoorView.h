//
//  WOTOpenDoorView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTOpenDoorView : UIView
@property(nonatomic, strong) void (^btnClick)(NSString *str);

- (void)showWithController:(UIViewController *)fromController;
@end
