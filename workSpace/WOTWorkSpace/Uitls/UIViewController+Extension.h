//
//  UIViewController+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WOTRefreshControlUitls.h"

typedef void(^searchBlock)(NSString* searchString);
typedef void(^clearSearchBlock)();

@interface UIViewController(Extension) <UISearchBarDelegate>

@property (nonatomic, strong) searchBlock block; //该属性需要与VC中定义相同。
@property (nonatomic, strong) clearSearchBlock clearBlock; //该属性需要与VC中定义相同。

///**
// *	@brief 添加下拉刷新View
// *
// *	@param scrollView 需要添加下拉刷新view的滚动视图 
// */
//-(void)instenceWithScrollView:(UIScrollView *)scrollView;
-(void)configNaviBackItem;
-(void)configNaviView:(NSString *)searchTitle searchBlock:(searchBlock)block clearBlock:(clearSearchBlock)clearBlock;
-(void)configNaviRightItemWithImage:(UIImage *)image;
-(void)configNaviRightItemWithTitle:(NSString *)title textColor:(UIColor *)textColor;


-(void)rightItemAction; //右button响应方法

@end
