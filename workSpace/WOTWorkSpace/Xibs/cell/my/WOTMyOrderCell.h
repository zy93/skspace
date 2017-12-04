//
//  WOTMyOrderCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WOTOrderCellDelegate <NSObject>


@required

-(void)showMettingRoomOrderList;
-(void)showStationOrderList;
-(void)showAllOrderList;
@end
@interface WOTMyOrderCell : UITableViewCell

@property(nonatomic,weak)id<WOTOrderCellDelegate> celldelegate;

@end
