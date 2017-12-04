//
//  WOTAirconditioningCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTAirconditioningCell.h"
@interface WOTAirconditioningCell(){
   UILabel *lab;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;


@end

@implementation WOTAirconditioningCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnWidth.constant = (self.bgview.frame.size.width-60)/4;
    
    [self setTextColor:InteligenceDeviceSelectedColor middle:MiddleTextColor high:MiddleTextColor autoControl:MiddleTextColor];
    _progressView.progress = 0.333;
    _autoControlImage.image = [UIImage imageNamed:@"autoControl"];
    
  
    [_lowBtn setTitleColor:MiddleTextColor forState:UIControlStateNormal];
    [_middleBtn setTitleColor:MiddleTextColor forState:UIControlStateNormal];
    [_highBtn setTitleColor:MiddleTextColor forState:UIControlStateNormal];
    _temperatureLabel.textColor = MiddleTextColor;
    
    [_controlView setShadow:Black];
    
    lab = [[UILabel alloc] initWithFrame:CGRectZero];
    lab.font = [UIFont systemFontOfSize:16.f];
    lab.text = [NSString stringWithFormat:@"%.2f%@",_temperatureSlider.value,@"℃"];
    lab.textColor = MiddleTextColor;
    
    [self.controlView addSubview:lab];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchAction:(id)sender {
    
    [self.cellSwitch setOn:!self.cellSwitch.on];
  
    if (_delegate) {
        [self.delegate switchChangeState:_cellSwitch.on];
    }
    
}
- (IBAction)lowAction:(id)sender {
   
    [self setTextColor:InteligenceDeviceSelectedColor middle:MiddleTextColor high:MiddleTextColor autoControl:MiddleTextColor];
    _progressView.progress = 0.333;
     _autoControlImage.image = [UIImage imageNamed:@"autoControl"];
}
- (IBAction)middleAction:(id)sender {
    
      [self setTextColor:MiddleTextColor middle:InteligenceDeviceSelectedColor high:MiddleTextColor autoControl:MiddleTextColor];
    _progressView.progress = 0.666;
    _autoControlImage.image = [UIImage imageNamed:@"autoControl"];
}
- (IBAction)highAction:(id)sender {
    
      [self setTextColor:MiddleTextColor middle:MiddleTextColor high:InteligenceDeviceSelectedColor autoControl:MiddleTextColor];
    _progressView.progress = 1.0;
    _autoControlImage.image = [UIImage imageNamed:@"autoControl"];
}
- (IBAction)autoControlAction:(id)sender {
    
    [self setTextColor:MiddleTextColor middle:MiddleTextColor high:MiddleTextColor autoControl:InteligenceDeviceSelectedColor];
    _autoControlImage.image = [UIImage imageNamed:@"autoControl_selected"];
}
- (IBAction)refrigerationAction:(id)sender {
    [self setImageTextSelected:InteligenceDeviceSelectedColor fanspeed:MiddleTextColor heating:MiddleTextColor refrigerationImage:@"refrigeration_selected" fanspeedImage:@"fanspeed" heatingImage:@"heating"];
}

- (IBAction)fanspeedAction:(id)sender {
    [self setImageTextSelected:MiddleTextColor fanspeed:InteligenceDeviceSelectedColor heating:MiddleTextColor refrigerationImage:@"refrigeration" fanspeedImage:@"fanspeed_selected" heatingImage:@"heating"];
}

- (IBAction)heatingAction:(id)sender {
    [self setImageTextSelected:MiddleTextColor fanspeed:MiddleTextColor heating:InteligenceDeviceSelectedColor refrigerationImage:@"refrigeration" fanspeedImage:@"fanspeed" heatingImage:@"heating_selected"];
}

- (IBAction)temperatureControl:(id)sender {
    

    _temperatureLabel.text = [NSString stringWithFormat:@"当前室内温度:%.2f%@",_temperatureSlider.value,@"℃"];
    [self setNeedsLayout];
    lab.text = [NSString stringWithFormat:@"%.2f%@",_temperatureSlider.value,@"℃"];

}



-(void)setTextColor:(UIColor *)low middle:(UIColor *)middle high:(UIColor *)high autoControl:(UIColor *)autoControl{
    
    [_lowBtn setTitleColor:low forState:UIControlStateNormal];
    [_middleBtn setTitleColor:middle forState:UIControlStateNormal];
    [_highBtn setTitleColor:high forState:UIControlStateNormal];
    [_autoControlBtn setTitleColor:autoControl forState:UIControlStateNormal];
}

-(void)setImageTextSelected:(UIColor *)refrigeration fanspeed:(UIColor *)fanspeed heating:(UIColor *)heating refrigerationImage:(NSString *)refrigerationImage fanspeedImage:(NSString *)fanspeedImage heatingImage:(NSString *)heatingImage {
    
    _refrigerationImage.image = [UIImage imageNamed:refrigerationImage];
    _fanspeedImage.image = [UIImage imageNamed:fanspeedImage];
    _heatingImage.image = [UIImage imageNamed:heatingImage];
    _refrigerationLabel.textColor = refrigeration;
    _heatingLabel.textColor = heating;
    _fanspeedLabel.textColor = fanspeed;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        [lab setFrame:CGRectMake(CGRectGetMinX(self.temperatureSlider.frame)+((CGRectGetWidth(self.temperatureSlider.frame)/100)*(self.temperatureSlider.value)), CGRectGetMinY(self.temperatureSlider.frame)-10, 80, 14)];
        
    }];
    

}


@end
