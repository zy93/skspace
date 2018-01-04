//
//  WOTEnterpriseIntroduceNameCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseIntroduceNameCell.h"

@implementation WOTEnterpriseIntroduceNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.applyJoinBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)applyJoinBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(enterpriseCellApplyJoin:)]) {
        [_delegate enterpriseCellApplyJoin:self];
    }
}

@end
