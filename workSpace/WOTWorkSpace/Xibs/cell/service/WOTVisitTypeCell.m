//
//  WOTVisitTypeCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTVisitTypeCell.h"

@implementation WOTVisitTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    _buttonWidth.constant = (self.contentView.frame.size.width-40)/3;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.visitBtn.layer.borderColor = UIColor_blue_40.CGColor;
    self.visitBtn.layer.borderWidth = 1.f;
    self.visitBtn.layer.cornerRadius = 5.f;
    
    self.visitEnterpriseBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.visitEnterpriseBtn.layer.borderWidth = 1.f;
    self.visitEnterpriseBtn.layer.cornerRadius = 5.f;
    
    self.visitIndividualBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.visitIndividualBtn.layer.borderWidth = 1.f;
    self.visitIndividualBtn.layer.cornerRadius = 5.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)visitBtn:(id)sender {
    
    self.visitBtn.selected = YES;
    self.visitEnterpriseBtn.selected = NO;
    self.visitIndividualBtn.selected = NO;
    self.visitBtn.layer.borderColor = UIColor_blue_40.CGColor;
    self.visitEnterpriseBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.visitIndividualBtn.layer.borderColor = UIColor_gray_89.CGColor;
    if ([_delegate respondsToSelector:@selector(selectVisitType:type:)]) {
        [_delegate selectVisitType:self type:2];
    }
}
- (IBAction)businessBtn:(id)sender {
    
    self.visitBtn.selected = NO;
    self.visitEnterpriseBtn.selected = YES;
    self.visitIndividualBtn.selected = NO;
    self.visitBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.visitEnterpriseBtn.layer.borderColor = UIColor_blue_40.CGColor;
    self.visitIndividualBtn.layer.borderColor = UIColor_gray_89.CGColor;
    if ([_delegate respondsToSelector:@selector(selectVisitType:type:)]) {
        [_delegate selectVisitType:self type:0];
    }
}
- (IBAction)personalBtn:(id)sender {
    
    self.visitBtn.selected = NO;
    self.visitEnterpriseBtn.selected = NO;
    self.visitIndividualBtn.selected = YES;
    self.visitBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.visitEnterpriseBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.visitIndividualBtn.layer.borderColor = UIColor_blue_40.CGColor;
    if ([_delegate respondsToSelector:@selector(selectVisitType:type:)]) {
        [_delegate selectVisitType:self type:1];
    }
}

@end
