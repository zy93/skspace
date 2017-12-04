//
//  WOTBookStationCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTBookStationCell.h"

@implementation WOTBookStationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.spaceName.textColor = HighTextColor;
    [[WOTConfigThemeUitls shared]setLabelColorss:[NSArray arrayWithObjects:self.stationPrice,self.stationNum, nil] withColor:MiddleTextColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goTobookStation:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(gotoOrderVC:)]) {
        [_delegate gotoOrderVC:self];
    }
    
}



@end
