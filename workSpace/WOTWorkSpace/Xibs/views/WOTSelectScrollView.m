//
//  WOTSelectScrollView.m
//  scrollTest
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "WOTSelectScrollView.h"
#import "WOTReservationsMeetingCell.h"

#define ButtonWith 40
#define ButtonHeight 50


@interface WOTScrollButton ()

@end


@implementation WOTScrollButton

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self setBackgroundColor:UIColor_blue_40];
        [self setImage:[UIImage imageNamed:@"select_white"]  forState:UIControlStateNormal];
        [self.layer setBorderColor:UIColor_blue_40.CGColor];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:UIColor_gray_d6.CGColor];
    }
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (!enabled) {
        [self setBackgroundColor:UIColor_gray_d6];
        [self setImage:[UIImage imageNamed:@"select_gray"]  forState:UIControlStateNormal];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage:nil  forState:UIControlStateNormal];
    }
        
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

@end


@interface WOTSelectScrollView ()
{
    UIView *topLine;
    
//    NSArray *selectList;
    NSArray *invalidList;
    
}

@end


@implementation WOTSelectScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self commonInit];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

-(void)setOpenTime:(NSString *)openTime
{
    NSArray *tims = [openTime getDECTime];
    openStartTime = [tims.firstObject floatValue];
    openEndTime   = [tims.lastObject  floatValue];
    [self commonInit];
}

-(void)setBeginTime:(CGFloat)begin endTime:(CGFloat)end
{
    selectBeginTime = begin;
    selectEndTime = end;
    [self setNeedsLayout];
}

//-(void)setSelectBtnTimeList:(NSArray *)tagList
//{
//    selectList = tagList;
//    [self setNeedsLayout];
//}

-(void)setupView
{
    for (UIView *vi in self.subviews) {
        [vi removeFromSuperview];
    }
}

-(void)setScrollOffsetX:(CGFloat)x
{
    CGPoint offset = self.contentOffset;
    offset.x = x;
    [self setContentOffset:offset];
}

-(void)setInvalidBtnTimeList:(NSArray *)tagList
{
    NSLog(@"失效时间：%@",tagList);
    invalidList = tagList;
    [self setNeedsLayout];
}

-(void)commonInit
{
    if (!buttonArr) {
        buttonArr = [[NSMutableArray alloc] init];
    }
    else {
        for (UIButton *button in buttonArr) {
            [button removeFromSuperview];
        }
        [buttonArr removeAllObjects];
    }
    if (!titleArr) {
        titleArr = [[NSMutableArray alloc] init];
    }
    else {
        for (UILabel *lab in titleArr) {
            [lab removeFromSuperview];
        }
        [titleArr removeAllObjects];
    }
    if (!topLine) {
        topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 1)];
    }
    [topLine setBackgroundColor:[UIColor grayColor]];
    [self addSubview:topLine];
    //NSLog(@"测试：%f,%f",openStartTime,openEndTime);
    
    for (float i = openStartTime; i< openEndTime; i+=0.5) {
        WOTScrollButton *btn = [self createButtonWithTitle:nil];
        btn.time = i;
        [buttonArr addObject:btn];
        [self addSubview:btn];
    }
    
    for (float i = openStartTime; i<=openEndTime; i++) {
        NSString *tit =  [NSString stringWithFormat:@"%d时",(int)(i+0.5)];
        UILabel *lab = [self createLabelWithTitle:tit];
        [titleArr addObject:lab];
        [self addSubview:lab];
    }
     /*
    for (float i = openStartTime; i<openEndTime; i+=0.5) {
        BOOL isInteger = i-((int)i)==0;
        NSString *tit = nil;
        if (isInteger) {
            tit = [NSString stringWithFormat:@"%d时",(int)i];
        }
        WOTScrollButton *btn = [self createButtonWithTitle:nil];
        btn.time = i;
        UILabel *lab = [self createLabelWithTitle:tit];
        [buttonArr addObject:btn];
        [titleArr addObject:lab];
        [self addSubview:btn];
        [self addSubview:lab];
    }
      */
    //NSLog(@"测试：%d",buttonArr.count);
    //NSLog(@"测试：%d",titleArr.count);
    [self setNeedsLayout];
}


-(WOTScrollButton *)createButtonWithTitle:(NSString *)title
{
    WOTScrollButton *button = [WOTScrollButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = UIColor_gray_d6.CGColor;
    button.layer.borderWidth = 1.f;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button setFrame:CGRectMake(0, 0, ButtonWith, ButtonHeight)];
    
    return button;
}

-(UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc] init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:13]];
    return lab;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"测试：%d",buttonArr.count);
    //NSLog(@"测试：%d",titleArr.count);
    CGRect btnRect = CGRectMake(10, 30, ButtonWith, ButtonHeight);
    for (int i = 0 ; i<buttonArr.count ; i++) {
        WOTScrollButton *btn = buttonArr[i];
//        NSLog(@"---Btn:%ld",btn.isEnabled);
        [btn setEnabled:YES];
        btn.selected = NO;
        [btn setFrame:btnRect];
        btnRect = CGRectMake(CGRectGetMaxX(btn.frame)-1, 30, ButtonWith, ButtonHeight);
       
        //整点
        if ((int)(btn.time+0.5)==(int)btn.time) {
            UILabel *lab = [titleArr objectAtIndex:i/2];
            //lab.backgroundColor = [UIColor blueColor];
           // [lab setFrame:CGRectMake(CGRectGetMinX(btn.frame), 15, 30, 13)];
            [lab setFrame:CGRectMake(CGRectGetMinX(btn.frame)-10, 15, 30, 13)];
        }
        //最后一个是否需要显示，以及位置
        if (i==buttonArr.count-1) {
            if ((int)(btn.time+0.5)-(int)btn.time!=0) {
                UILabel *lab = [titleArr objectAtIndex:(i+1)/2];
                //lab.backgroundColor = [UIColor blueColor];
                // [lab setFrame:CGRectMake(CGRectGetMinX(btn.frame), 15, 30, 13)];
                // [lab setFrame:CGRectMake(CGRectGetMinX(btn.frame)-10, 15, 30, 13)];
                [lab setFrame:CGRectMake(CGRectGetMaxX(btn.frame)-10, 15, 30, 13)];
            }
            
        }
        for (NSArray *times in invalidList) {
            CGFloat beginTime = [times.firstObject floatValue];
            CGFloat endTime = [times.lastObject floatValue];
            if (btn.time >= beginTime && btn.time < endTime) {
                [btn setEnabled:NO];
            }
            
        }
        if (btn.time >= selectBeginTime && btn.time < selectEndTime) {
            btn.selected = YES;
        }
        
    }
    
    
    //self.contentSize = CGSizeMake(btnRect.origin.x, 80);
    self.contentSize = CGSizeMake(btnRect.origin.x+20, 80);
    [topLine setFrame:CGRectMake(0, 0, btnRect.origin.x+20, 1)];
}

-(void)selectButton:(WOTScrollButton *)sender
{
    if (sender.isEnabled==NO) {
        return;
    }
    //检查选择的时间内是否被预定过
    if ([self checkTimeHasBeenBookedWithTime:sender.time] == YES) {
        
        return;
    }
    
    
    if ([_mDelegate respondsToSelector:@selector(selectButton:)]) {
        [_mDelegate selectButton:sender];
    }
}


-(BOOL)checkTimeHasBeenBookedWithTime:(CGFloat)time
{
    CGFloat tempBeginTime = selectBeginTime;
    CGFloat tempEndTime = selectEndTime;
    
    
    if (tempBeginTime == tempEndTime && tempEndTime == 0) {
        tempBeginTime = time;
        tempEndTime = tempBeginTime+0.5;
    }
    else if (time ==  tempBeginTime && tempBeginTime == tempEndTime-0.5) {
        tempBeginTime = tempEndTime = 0;
    }
    else if (time<tempBeginTime) {
        tempBeginTime = time;
    }
    else if (time>=tempEndTime) {
        tempEndTime = time+0.5;
    }
    else if (time>tempBeginTime && time<tempEndTime) {
        if (time == tempEndTime-0.5) {
            tempEndTime = time;
        }
        else {
            tempEndTime = time+0.5;
        }
    }
    
    for (NSArray *times in invalidList) {
        CGFloat beginTime = [times.firstObject floatValue];
        CGFloat endTime = [times.lastObject floatValue];
        
        if (tempBeginTime <beginTime && tempEndTime > endTime) {
            return YES;
        }
        
    }
    
    return NO;
}


@end
