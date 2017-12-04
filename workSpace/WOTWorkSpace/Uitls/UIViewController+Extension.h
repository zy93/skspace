//
//  UIViewController+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WOTRefreshControlUitls.h"
@interface UIViewController(Extension)


///**
// *	@brief 添加下拉刷新View
// *
// *	@param scrollView 需要添加下拉刷新view的滚动视图 
// */
//-(void)instenceWithScrollView:(UIScrollView *)scrollView;
-(void)configNaviBackItem;
-(void)configNaviView:(NSString *)searchTitle block:(void(^)())search;
-(void)configNaviRightItemWithImage:(UIImage *)image;
-(void)configNaviRightItemWithTitle:(NSString *)title textColor:(UIColor *)textColor;


@end
