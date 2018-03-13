//
//  WOTMyOrderCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTOrderButton : UIButton

@end

@class WOTMyOrderCell;
@protocol WOTOrderCellDelegate <NSObject>


@required
-(void)myOrderCell:(WOTMyOrderCell *)cell showOrder:(NSString *)type;
@end
@interface WOTMyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *allOrderBtn;
@property (weak, nonatomic) IBOutlet UIView *orderTypeBGView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet WOTOrderButton *meetingBtn;
@property (weak, nonatomic) IBOutlet WOTOrderButton *stationBtn;
@property (weak, nonatomic) IBOutlet WOTOrderButton *siteBtn;
@property (weak, nonatomic) IBOutlet WOTOrderButton *giftBagBtn;

@property(nonatomic, strong) id <WOTOrderCellDelegate> delegate;

@end
