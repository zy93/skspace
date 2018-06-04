//
//  SKRoomTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKRoomTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *roomImageView;
@property(nonatomic,strong)UILabel *roomNameLabel;
@property(nonatomic,strong)UILabel *bookStationNumLabel;
@property(nonatomic,strong)UILabel *bookStationInfoNumLabel;
@property(nonatomic,strong)UILabel *nowPriceLabel;
@property(nonatomic,strong)UILabel *formerlyPriceLabel;

@end
