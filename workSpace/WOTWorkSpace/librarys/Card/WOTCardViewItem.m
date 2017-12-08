//
//  WOTCardViewItem.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTCardViewItem.h"

@implementation WOTCardViewItem

-(void)awakeFromNib
{
    [super awakeFromNib];
    //init
    
    self.layer.cornerRadius = 5.f;
    //加阴影
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = 8;//阴影半径，默认3
    self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.titleBgView.backgroundColor = RGBA(1, 1, 1, 0.5);
    
}

-(void)addAlphaMaskView
{
}

-(void)removeAlphaMaskView
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
