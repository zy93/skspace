//
//  WOTMyAppointmentCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyAppointmentCell.h"

@implementation WOTMyAppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.agreeBtn.layer.cornerRadius = 4.f;
    self.agreeBtn.backgroundColor = UICOLOR_MAIN_ORANGE;
    self.rejectBtn.layer.cornerRadius = 4.f;
    self.rejectBtn.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.rejectBtn.layer.borderWidth = 1.f;
    self.rejectBtn.titleLabel.textColor = UICOLOR_MAIN_LINE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)agreeBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(cellAgree:sender:)]) {
        [_delegate cellAgree:self sender:sender];
    }
}

- (IBAction)rejectBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(cellreject:sender:)]) {
        [_delegate cellreject:self sender:sender];
    }
}

-(void)setCellType:(APPOINTMENT_CELL_TYPE)cellType
{
    _cellType = cellType;
    if (cellType == APPOINTMENT_CELL_TYPE_DEFAULT) {
        _contentBGViewConstraint.constant = 10;
        self.agreeBtn.hidden = YES;
        self.rejectBtn.hidden = YES;
    }
    else {
        _contentBGViewConstraint.constant = 50;
        self.agreeBtn.hidden = NO;
        self.rejectBtn.hidden = NO;
    }
}

@end
