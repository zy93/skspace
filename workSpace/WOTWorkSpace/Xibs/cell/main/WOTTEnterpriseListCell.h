//
//  WOTTEnterpriseListCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTTEnterpriseListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *enterpriseLogo;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;

@property (weak, nonatomic) IBOutlet UILabel *enterpriseInfo;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
