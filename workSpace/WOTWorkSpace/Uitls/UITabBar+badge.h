//
//  UITabBar+badge.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/6/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(NSInteger)index; // 显示小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index; // 隐藏小红点
@end
