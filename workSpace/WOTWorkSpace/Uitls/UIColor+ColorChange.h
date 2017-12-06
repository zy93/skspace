//
//  UIColor+ColorChange.h
//  ColorDemo
//
//  Created by 编程 on 2017/11/10.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
