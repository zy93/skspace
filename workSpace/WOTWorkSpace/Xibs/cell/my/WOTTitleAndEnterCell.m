//
//  WOTTitleAndEnterCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/29.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTTitleAndEnterCell.h"

@implementation WOTTitleAndEnterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = textField.text;
    str = [str stringByReplacingCharactersInRange:range withString:string];
    if ([_delegate respondsToSelector:@selector(enterCell:didEnterText:)]) {
        [_delegate enterCell:self didEnterText:str];
    }
    return YES;
}

@end
