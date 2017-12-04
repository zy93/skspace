//
//  UIImage+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Extension)
//设置圆角图片
- (UIImage *)circleImage;

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

/**
 *  根据颜色生成一张尺寸为1*1的相同颜色图片
 *
 *  @param color   传入颜色
 *
 *  @return 根据颜色生成一张尺寸为1*1的相同颜色图片
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end
