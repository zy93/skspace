//
//  WOTMyRepairdCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/13.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyRepairdCell.h"

@implementation WOTMyRepairdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btn.layer.cornerRadius = 5.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btnClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(repairdCell:btnClick:)]) {
        [_delegate repairdCell:self btnClick:self.index];
    }
}

@end
