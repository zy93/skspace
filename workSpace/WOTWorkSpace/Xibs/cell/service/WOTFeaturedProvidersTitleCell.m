//
//  WOTFeaturedProvidersTitleCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTFeaturedProvidersTitleCell.h"

@implementation WOTFeaturedProvidersTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(-1, CGFLOAT_MAX, 0, 0)];
    }
    self.subtitleLab.textColor = UICOLOR_MAIN_ORANGE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
