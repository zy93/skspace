//
//  WOTEnterpriseListSytle2Cell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/5.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTEnterpriseModel.h"

//@class WOTEnterpriseListSytle2Cell;
//@protocol WOTEnterpriseListSytle2CellDelegate <NSObject>
//-(void)cell
//@end

@interface WOTEnterpriseListSytle2Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UIImageView *locationIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab1;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab2;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subtitleLab1Constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subtitleLab2Constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subtitleLab3Constraint;

@property (nonatomic, strong) WOTEnterpriseModel *model;

@end
