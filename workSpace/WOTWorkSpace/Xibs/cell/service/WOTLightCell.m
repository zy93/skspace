//
//  WOTLightCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTLightCell.h"

@interface WOTLightCell ()
{
    NSInteger val;
    UILabel *lab;
}

@end


@implementation WOTLightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentBGView.backgroundColor=[UIColor whiteColor];
    self.contentBGView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentBGView.layer.shadowRadius = 4.f;
    self.contentBGView.layer.shadowOpacity = 0.2f;
    self.contentBGView.layer.shadowOffset = CGSizeMake(1, 1);
    self.contentBGView.layer.cornerRadius = 4.f;
    
    //
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    
    lab = [[UILabel alloc] initWithFrame:CGRectZero];
    lab.font = [UIFont systemFontOfSize:13.f];
    lab.text = @"16";
    val = 16;
//    [lab setBackgroundColor:[UIColor blueColor]];
    [self.contentBGView addSubview:lab];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchChangeValue:(id)sender {
    [self.switchSW setOn:!self.switchSW.on];
    if ([_delegate respondsToSelector:@selector(lightcellOfSwitch:option:)]) {
        [_delegate lightcellOfSwitch:_index option:((UISwitch*)sender).isOn];
    }
}


- (IBAction)sliderChangeValue:(id)sender {
    val =  (NSInteger)(((UISlider*)sender).value+0.5);
//    NSLog(@"-----__%ld",val);
    if ([_delegate respondsToSelector:@selector(cellOfSlider:value:)]) {
        [_delegate cellOfSlider:self value:val];
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        [lab setFrame:CGRectMake(CGRectGetMinX(self.slider.frame)+((CGRectGetWidth(self.slider.frame)/100)*(val)), CGRectGetMinY(self.slider.frame)-20, 40, 14)];
    }];
    
    [lab setText:[NSString stringWithFormat:@"%d%",(int)val]];
    self.slider.value = val;
}

@end
