//
//  SKCommunityServiceTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/6/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKCommunityServiceTableViewCellDelegate <NSObject>

-(void)clickReserveButton:(UIButton *)button;

@end

@interface SKCommunityServiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shortTimeBookStationImage;
@property (weak, nonatomic) IBOutlet UILabel *shortTimeBookStationNum;
@property (weak, nonatomic) IBOutlet UIImageView *longTimeBookStationImage;
@property (weak, nonatomic) IBOutlet UILabel *roomNum;
@property (weak, nonatomic) IBOutlet UILabel *monthPriceLabel;

@property (nonatomic,weak)id <SKCommunityServiceTableViewCellDelegate> delegate;

@end
