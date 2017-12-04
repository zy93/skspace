//
//  WOTVisitorsAppointmentSubmitCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/24.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTVisitorsAppointmentSubmitCell.h"

@implementation WOTVisitorsAppointmentSubmitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.submitBtn.layer.cornerRadius = 5.f;
//    self.backgroundColor = UIColor_gray_d6;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)submitBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(submitVisitorInfo:)]) {
        [_delegate submitVisitorInfo:self];
    }
}

@end
