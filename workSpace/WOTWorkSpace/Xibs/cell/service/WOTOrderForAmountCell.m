//
//  WOTOrderForAmountCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForAmountCell.h"

@implementation WOTOrderForAmountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self setSeparatorInset:UIEdgeInsetsZero];
//    }
    self.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
