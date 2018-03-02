//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//



@interface UILabel (ChangeLineSpaceAndWordSpace)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
