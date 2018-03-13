//
//  WOTMyEnterPriseCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyEnterPriseCell.h"

@implementation WOTMyEnterPriseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[WOTConfigThemeUitls shared]setLabelColorss:[NSArray arrayWithObjects:self.enterpariseName,self.joinEnterpriseTime, nil] withColor:UICOLOR_MAIN_TEXT];
    // Initialization code
    self.enterpriseHeaderImage.layer.cornerRadius = 3.f;
    self.enterpriseHeaderImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
