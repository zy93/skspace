//
//  WOTVisitorsMemberCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/27.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTVisitorsMemberCell.h"

@implementation WOTVisitorsMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headIV.layer.cornerRadius = CGRectGetWidth(self.headIV.frame)/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
