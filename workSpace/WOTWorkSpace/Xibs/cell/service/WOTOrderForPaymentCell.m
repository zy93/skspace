//
//  WOTOrderForPaymentCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForPaymentCell.h"

@interface WOTOrderForPaymentCell()

@end

@implementation WOTOrderForPaymentCell

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

- (IBAction)choosePayWay:(UIButton *)sender {
    if (sender.tag == 0) {
        if ([self.delegate respondsToSelector:@selector(choosePayWay:)]) {
            [self.delegate choosePayWay:@"支付宝"];
        }
        [self.alipayButton setImage:[UIImage imageNamed:@"select_blue"] forState:UIControlStateNormal];
        [self.wxpayButton setImage:[UIImage imageNamed:@"unselect_white"] forState:UIControlStateNormal];
        
    }else
    {
        if ([self.delegate respondsToSelector:@selector(choosePayWay:)]) {
            [self.delegate choosePayWay:@"微信"];
        }
        [self.alipayButton setImage:[UIImage imageNamed:@"unselect_white"] forState:UIControlStateNormal];
        [self.wxpayButton setImage:[UIImage imageNamed:@"select_green"] forState:UIControlStateNormal];
    }
}



@end
