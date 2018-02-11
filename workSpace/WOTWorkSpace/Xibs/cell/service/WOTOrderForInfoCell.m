//
//  WOTOrderForInfoCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForInfoCell.h"

@implementation WOTOrderForInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
    self.scrollview.delegate = self;
    self.scrollview.pageDotColor = UICOLOR_GRAY_66;
    self.scrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;//dong删除默认居中
    self.scrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;  //设置图片填充格式;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
