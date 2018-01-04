//
//  SKSupportTypeView.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/3.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kViewScreenW [UIScreen mainScreen].bounds.size.width*0.7
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kATTR_VIEW_HEIGHT kScreenH * 0.7
@interface SKSupportTypeView : UIView

@property (nonatomic,copy)void(^sureBtnsClick)(NSString *typeString);

/**
 显示视图

 @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;

@end
