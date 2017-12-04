//
//  WOTBookStationCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTBookStationListModel.h"
#import "WOTSpaceModel.h"
@class WOTBookStationCell;

@protocol WOTBookStationCellDelegate <NSObject>

-(void)gotoOrderVC:(WOTBookStationCell *)cell;

@end


@interface WOTBookStationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *spaceName;
@property (weak, nonatomic) IBOutlet UILabel *stationNum;
@property (weak, nonatomic) IBOutlet UILabel *stationPrice;
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;
@property (weak, nonatomic) IBOutlet UIImageView *spaceImage;

@property (nonatomic, weak) id <WOTBookStationCellDelegate> delegate;
//@property (nonatomic, strong) WOTBookStationListModel *model;
@property (nonatomic, strong) WOTSpaceModel *model;

@end
