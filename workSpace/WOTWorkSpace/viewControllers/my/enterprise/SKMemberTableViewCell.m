//
//  SKMemberTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKMemberTableViewCell.h"

@implementation SKMemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.memberHeadView.size = CGSizeMake(50, 50);
    self.memberHeadView.layer.masksToBounds=YES;
//    
    self.memberHeadView.layer.cornerRadius=self.memberHeadView.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
