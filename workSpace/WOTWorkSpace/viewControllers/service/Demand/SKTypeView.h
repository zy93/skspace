//
//  SKTypeView.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kATTR_VIEW_HEIGHT kScreenH * 0.7
@interface SKTypeView : UIView
@property (nonatomic, copy) void (^sureBtnsClick)(NSString *typeString);
- (void)showInView:(UIView *)view;
@end
