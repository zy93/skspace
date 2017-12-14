//
//  WOTButton.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTButton.h"

@implementation WOTButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更改image的中心坐标
    CGPoint imageCenter = self.imageView.center;
    imageCenter.x = self.frame.size.width/2;
    imageCenter.y = (self.frame.size.height-self.imageView.frame.size.height)/2 +20;
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
