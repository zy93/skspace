//
//  WOTOrderForSelectTimeCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSelectScrollView.h"

@class WOTOrderForSelectTimeCell;

@protocol WOTOrderForSelectTimeCellDelegate <NSObject>
-(void)selectTimeWithCell:(WOTOrderForSelectTimeCell*)cell Time:(CGFloat)time;
@end

@interface WOTOrderForSelectTimeCell : UITableViewCell <WOTSelectScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgview1;
@property (weak, nonatomic) IBOutlet UIView *bgview2;
@property (weak, nonatomic) IBOutlet UIView *bgview3;
@property (weak, nonatomic) IBOutlet UIView *ico1;
@property (weak, nonatomic) IBOutlet UIView *ico2;
@property (weak, nonatomic) IBOutlet UIView *ico3;
@property (weak, nonatomic) IBOutlet WOTSelectScrollView *selectTimeScroll;
@property (nonatomic, strong) id <WOTOrderForSelectTimeCellDelegate> delegate;

@property (nonatomic, strong) NSString *inquireTime;//查询日期;
@property (nonatomic, strong) NSIndexPath *index;

@property (nonatomic, assign)CGFloat allTime;


@end
