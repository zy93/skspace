//
//  WOTMyOrderCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyOrderCell.h"
#import "WOTConstants.h"



@implementation WOTOrderButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更改image的中心坐标
    CGPoint imageCenter = self.imageView.center;
    imageCenter.x = self.frame.size.width/2;
    imageCenter.y = (self.frame.size.height-self.imageView.frame.size.height)/2+5 ;
    self.imageView.center = imageCenter;
    
    // 更改label的中心坐标
    CGRect labelFrame = self.titleLabel.frame;
    labelFrame.origin.x = 0;
    labelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + 5;
    labelFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = labelFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end


@implementation WOTMyOrderCell


- (void)awakeFromNib {
    [super awakeFromNib];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)allBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(myOrderCell:showOrder:)]) {
        [_delegate myOrderCell:self showOrder:((UIButton *)sender).titleLabel.text];
    }
}

- (IBAction)btn:(id)sender {
    if ([_delegate respondsToSelector:@selector(myOrderCell:showOrder:)]) {
        [_delegate myOrderCell:self showOrder:((UIButton *)sender).titleLabel.text];
    }
}



@end
