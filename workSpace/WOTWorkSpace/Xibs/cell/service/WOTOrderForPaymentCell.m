//
//  WOTOrderForPaymentCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForPaymentCell.h"

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

-(void)setAlipay:(BOOL)alipay
{
    _alipay = alipay;
    if (_alipay) {
        [self.iconImg setImage:[UIImage imageNamed:@"alipay_icon"]];
        [self.titleLab setText:@"支付宝支付"];
    }
    else {
        [self.iconImg setImage:[UIImage imageNamed:@"wechat_icon"]];
        [self.titleLab setText:@"微信支付"];
    }
}

-(void)setSelect:(BOOL)select
{
    _select = select;
    if (_select) {
        [self.selectImg setImage:[UIImage imageNamed:@"select_green"]];
    }
    else {
        [self.selectImg setImage:[UIImage imageNamed:@"unselect_white"]];
    }
}

@end
