//
//  SKRoomDiscountsTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKRoomDiscountsTableViewCell.h"

@implementation SKRoomDiscountsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reserveBookStation:(UIButton *)sender {
    if (sender.tag == 0) {
        [self.oneMonthButton setImage:[UIImage imageNamed:@"selectcircle"] forState:UIControlStateNormal];
        [self.twoMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.threeMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.fourMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    }
    
    if (sender.tag == 1) {
        [self.oneMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.twoMonthButton setImage:[UIImage imageNamed:@"selectcircle"] forState:UIControlStateNormal];
        [self.threeMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.fourMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    }
    
    if (sender.tag == 2) {
        [self.oneMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.twoMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.threeMonthButton setImage:[UIImage imageNamed:@"selectcircle"] forState:UIControlStateNormal];
        [self.fourMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    }
    
    if (sender.tag == 3) {
        [self.oneMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.twoMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.threeMonthButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self.fourMonthButton setImage:[UIImage imageNamed:@"selectcircle"] forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(payDiscountsBag:)]) {
        [self.delegate payDiscountsBag:sender];
    }
}

@end
