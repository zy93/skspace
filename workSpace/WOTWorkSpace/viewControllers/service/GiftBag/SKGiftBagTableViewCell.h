//
//  SKGiftBagTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/26.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKGiftBagTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *giftBagImageView;
@property (nonatomic,strong)UILabel *giftNameLabel;
@property (nonatomic,strong)UILabel *giftPriceLabel;
@property (nonatomic,strong)UIButton *buyButton;

@end
