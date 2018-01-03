//
//  WOTBaseDefaultStyleCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/3.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTBaseDefaultStyleCell.h"

@implementation WOTBaseDefaultStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIV.layer.cornerRadius = self.iconIV.frame.size.width/2;
    self.iconIV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
