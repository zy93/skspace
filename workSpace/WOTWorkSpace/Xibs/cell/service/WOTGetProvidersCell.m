//
//  WOTGetProvidersCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTGetProvidersCell.h"

@implementation WOTGetProvidersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btn1.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn1.layer.borderWidth = 1.f;
    [self.btn1 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn1 setTitle:@"金融服务" forState:UIControlStateNormal];
    
    self.btn2.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn2.layer.borderWidth = 1.f;
    [self.btn2 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn2 setTitle:@"人力资源&党建" forState:UIControlStateNormal];
    
    self.btn3.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn3.layer.borderWidth = 1.f;
    [self.btn3 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn3 setTitle:@"品牌营销推广" forState:UIControlStateNormal];
    
    self.btn4.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn4.layer.borderWidth = 1.f;
    [self.btn4 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn4 setTitle:@"智能信息化" forState:UIControlStateNormal];
    
    self.btn5.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn5.layer.borderWidth = 1.f;
    [self.btn5 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn5 setTitle:@"政府事务" forState:UIControlStateNormal];
    
    self.btn6.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn6.layer.borderWidth = 1.f;
    [self.btn6 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn6 setTitle:@"工商财税注册" forState:UIControlStateNormal];
    
    self.btn7.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn7.layer.borderWidth = 1.f;
    [self.btn7 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn7 setTitle:@"其他" forState:UIControlStateNormal];
    
    self.btn8.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.btn8.layer.borderWidth = 1.f;
    [self.btn8 setTitleColor:UICOLOR_MAIN_TEXT forState:UIControlStateNormal];
    [self.btn8 setTitle:@"更多" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(getProvidersCell:selectType:)]) {
        [_delegate getProvidersCell:self selectType:((UIButton*)sender).titleLabel.text];
    }
}


@end
