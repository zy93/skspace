//
//  WOTServiceProvidersApplicationCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/6/30.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTServiceProvidersApplyCell.h"

@implementation WOTServiceProvidersApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
