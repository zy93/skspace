//
//  UIView+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(Extension)


@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;




//对指定角设置默认圆角
-(void)setDefaultRadiuWithCorners:(UIRectCorner)corners;
//对指定角设置圆角，并指定圆角弧度
-(void)setRadiuWithCorners:(UIRectCorner)corners radiu:(CGFloat)radiu;

/**
*设置边框和圆角
 *radiu  圆角的大小
 *borderColor 边框的颜色
*/
-(void)setCorenerRadius:(CGFloat)radiu borderColor:(UIColor *)borderColor;


-(UIImage *)toImage;

//设置view的阴影

-(void)setShadow:(UIColor *)shadowColor;

/**
 *  获取视图所在的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)GetSubordinateControllerForSelf;

@end
