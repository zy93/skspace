//
//  SKRoomDiscountsTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKRoomDiscountsTableViewCellDelegate <NSObject>

-(void)payDiscountsBag:(UIButton *)button;

@end

@interface SKRoomDiscountsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monthPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultPriceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *quarterPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultPriceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *halfAYearPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultPriceLabel3;
@property (weak, nonatomic) IBOutlet UILabel *yearPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultPriceLabel4;

@property (weak, nonatomic) IBOutlet UIButton *oneMonthButton;
@property (weak, nonatomic) IBOutlet UIButton *twoMonthButton;
@property (weak, nonatomic) IBOutlet UIButton *threeMonthButton;
@property (weak, nonatomic) IBOutlet UIButton *fourMonthButton;

@property(nonatomic,weak)id <SKRoomDiscountsTableViewCellDelegate> delegate;

@end
