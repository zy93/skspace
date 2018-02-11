//
//  WOTSurplusTimeCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTSurplusTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookstationTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *bookstationValueLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingValueLab;

@end
