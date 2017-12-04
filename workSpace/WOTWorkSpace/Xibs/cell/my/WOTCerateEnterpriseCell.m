//
//  WOTCerateEnterpriseCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTCerateEnterpriseCell.h"

@implementation WOTCerateEnterpriseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.textColor = HighTextColor;
    _textfield.textAlignment = NSTextAlignmentRight;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
