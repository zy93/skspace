//
//  WOTApplyCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTApplyCell.h"

@implementation WOTApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconIV.layer.cornerRadius = CGRectGetWidth(self.iconIV.frame)/2;
    self.iconIV.clipsToBounds = YES;
    NSLog(@"%lf",CGRectGetWidth(self.iconIV.frame)/2);
    self.agreeBtn.layer.cornerRadius = 2.f;
    self.agreeBtn.layer.borderWidth = 0.5f;
    self.agreeBtn.layer.borderColor = UIColor_gray_89.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(cell:clickBtn:)]) {
        [_delegate cell:self clickBtn:sender];
    }
}

@end
