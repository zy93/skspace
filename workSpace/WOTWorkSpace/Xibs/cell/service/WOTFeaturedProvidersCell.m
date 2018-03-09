//
//  WOTFeaturedProvidersCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTFeaturedProvidersCell.h"

@implementation WOTFeaturedProvidersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIV.layer.borderWidth = 1.f;
    self.iconIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.type1Lab.layer.cornerRadius = 2.f;
    self.type1Lab.backgroundColor = UIColorFromRGB(0xf0f0f0);
    self.type2Lab.layer.cornerRadius = 2.f;
    self.type2Lab.backgroundColor = UIColorFromRGB(0xf0f0f0);
    self.type3Lab.layer.cornerRadius = 2.f;
    self.type3Lab.backgroundColor = UIColorFromRGB(0xf0f0f0);
    self.type4Lab.layer.cornerRadius = 2.f;
    self.type4Lab.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    self.contentIV.layer.borderWidth = 1.f;
    self.contentIV.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    
    self.detailBtn.layer.cornerRadius = 3.f;
    self.detailBtn.backgroundColor = UIColorFromRGB(0x333333);
    self.subtitle2Lab.textColor = UICOLOR_GRAY_CC;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(featuredProvidersCell:selectIndex:)]) {
        [_delegate featuredProvidersCell:self selectIndex:self.index];
    }
}


@end
