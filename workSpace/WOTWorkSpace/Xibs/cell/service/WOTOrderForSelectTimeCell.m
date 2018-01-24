//
//  WOTOrderForSelectTimeCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForSelectTimeCell.h"

@implementation WOTOrderForSelectTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgview1.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.bgview1.layer.borderWidth = 1.f;
    self.bgview2.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.bgview2.layer.borderWidth = 1.f;
    self.bgview3.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.bgview3.layer.borderWidth = 1.f;
    
    self.ico1.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.ico1.layer.borderWidth = 1.f;
    self.ico2.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.ico2.layer.borderWidth = 1.f;
    self.ico3.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
    self.ico3.layer.borderWidth = 1.f;
    
    self.selectTimeScroll.mDelegate = self;
    self.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度

}

-(void)setReservationList:(NSArray *)reservationList
{
    _reservationList = reservationList;
    NSString *newTime =[NSDate getNewTime];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:reservationList];
    if ([newTime containsString:[_selectDate substringToIndex:10]]) {
        //选择日期是今天，需要禁用当前时间之前的时间选项。
        CGFloat fl = [newTime getNextTopOfHour];
        [arr addObject:@[@(0.f),@(fl)]];
    }
    [self.selectTimeScroll setInvalidBtnTimeList:arr];
}

#pragma mark - scroll delegate
-(void)selectButton:(WOTScrollButton *)button
{
    if ([_delegate respondsToSelector:@selector(selectTimeWithCell:Time:)]) {
        [_delegate selectTimeWithCell:self Time:button.time];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
