//
//  WOTOrderForInfoCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface WOTOrderForInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *infoTitle;
@property (weak, nonatomic) IBOutlet UILabel *dailyRentLabel;

@end
