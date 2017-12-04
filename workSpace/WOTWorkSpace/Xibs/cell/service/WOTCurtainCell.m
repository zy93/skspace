//
//  WOTCurtainCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTCurtainCell.h"

@implementation WOTCurtainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentBGView.backgroundColor=[UIColor whiteColor];
    self.contentBGView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentBGView.layer.shadowRadius = 4.f;
    self.contentBGView.layer.shadowOpacity = 0.2f;
    self.contentBGView.layer.shadowOffset = CGSizeMake(1, 1);
    self.contentBGView.layer.cornerRadius = 4.f;
    
    [self.openBtn setImage:[[UIImage imageNamed:@"curtain_on_icon"] imageWithColor:UIColor_gray_90] forState:UIControlStateNormal];
    [self.openBtn setImage:[[UIImage imageNamed:@"curtain_on_icon"] imageWithColor:UIColor_green_37] forState:UIControlStateSelected];
    [self.openBtn setTitleColor:UIColor_gray_90  forState:UIControlStateNormal];
    [self.openBtn setTitleColor:UIColor_green_37 forState:UIControlStateSelected];
    
    
    [self.stopBtn setImage:[[UIImage imageNamed:@"stop_icon"] imageWithColor:UIColor_gray_90] forState:UIControlStateNormal];
    [self.stopBtn setImage:[[UIImage imageNamed:@"stop_icon"] imageWithColor:UIColor_green_37] forState:UIControlStateSelected];
    [self.stopBtn setTitleColor:UIColor_gray_90  forState:UIControlStateNormal];
    [self.stopBtn setTitleColor:UIColor_green_37 forState:UIControlStateSelected];
    
    [self.offBtn setImage:[[UIImage imageNamed:@"curtain_off_icon"] imageWithColor:UIColor_gray_90] forState:UIControlStateNormal];
    [self.offBtn setImage:[[UIImage imageNamed:@"curtain_off_icon"] imageWithColor:UIColor_green_37] forState:UIControlStateSelected];
    [self.offBtn setTitleColor:UIColor_gray_90  forState:UIControlStateNormal];
    [self.offBtn setTitleColor:UIColor_green_37 forState:UIControlStateSelected];
    
    self.openBtn.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchChangeValue:(id)sender {
    [self.switchSW setOn:!self.switchSW.on];
    if ([_delegate respondsToSelector:@selector(curtaincellOfSwitch:option:)]) {
        [_delegate curtaincellOfSwitch:self option:((UISwitch*)sender).isOn];
    }
}
- (IBAction)clickOnBtn:(id)sender {
    self.openBtn.selected = YES;
    self.stopBtn.selected = NO;
    self.offBtn.selected = NO;
    if ([_delegate respondsToSelector:@selector(cellOfState:value:)]) {
        [_delegate cellOfState:self value:0];
    }
}
- (IBAction)clickStopBtn:(id)sender {
    self.openBtn.selected = NO;
    self.stopBtn.selected =YES;
    self.offBtn.selected = NO;
    if ([_delegate respondsToSelector:@selector(cellOfState:value:)]) {
        [_delegate cellOfState:self value:1];
    }
}
- (IBAction)clickOffBtn:(id)sender {
    self.openBtn.selected = NO;
    self.stopBtn.selected = NO;
    self.offBtn.selected = YES;
    if ([_delegate respondsToSelector:@selector(cellOfState:value:)]) {
        [_delegate cellOfState:self value:2];
    }
}

@end
