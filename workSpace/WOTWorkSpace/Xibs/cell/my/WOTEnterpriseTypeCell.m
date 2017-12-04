//
//  WOTEnterpriseTypeCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseTypeCell.h"

@implementation WOTEnterpriseTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = White;
    [_selectedImage setCorenerRadius:_selectedImage.frame.size.width/2 borderColor:CLEARCOLOR];
    // Initialization code
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.selectedImage.image = selected ==YES?[UIImage imageNamed:@""]:[UIImage imageNamed:@""];
}
@end
