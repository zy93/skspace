//
//  SKCommunityServiceTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/6/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKCommunityServiceTableViewCell.h"

@implementation SKCommunityServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reserveButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickReserveButton:)]) {
        [self.delegate clickReserveButton:sender];
    }
}


@end
