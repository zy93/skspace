//
//  WOTApplyCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTApplyJoinEnterpriseModel.h"


@class WOTApplyCell;

@protocol WOTApplyCellDelegate <NSObject>

-(void)cell:(WOTApplyCell *)cell clickAgreeBtn:(UIButton *)sender;

-(void)cell:(WOTApplyCell *)cell clickRefuseBtn:(UIButton *)sender;

@end

@interface WOTApplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;

@property (nonatomic, strong) WOTApplyModel *model;
@property (nonatomic, strong) id <WOTApplyCellDelegate> delegate;

@end
