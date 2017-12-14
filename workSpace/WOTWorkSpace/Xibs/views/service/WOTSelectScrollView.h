//
//  WOTSelectScrollView.h
//  scrollTest
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef struct Time{
//    int hour;
//    int minute;
//};

@interface WOTScrollButton : UIButton
@property (nonatomic, assign) CGFloat time;
@end


@protocol WOTSelectScrollViewDelegate <NSObject>

-(void)selectButton:(WOTScrollButton*)button;

@end


@interface WOTSelectScrollView : UIScrollView

{
    NSMutableArray *buttonArr;
    NSMutableArray *titleArr;
    
    CGFloat openStartTime; //开放时间的开始时间
    CGFloat openEndTime;  //开放时间的结束时间
    
    
    CGFloat selectBeginTime; //选择时间的开始时间
    CGFloat selectEndTime;  //选择时间的结束时间
    
}

@property (nonatomic, weak) id <WOTSelectScrollViewDelegate> mDelegate;

-(void)setOpenTime:(NSString *)openTime;
-(void)setBeginTime:(CGFloat)begin endTime:(CGFloat)end;
//-(void)setSelectBtnTimeList:(NSArray *)tagList;
-(void)setInvalidBtnTimeList:(NSArray *)tagList;
-(void)setupView;
-(void)setScrollOffsetX:(CGFloat)x;
@end
