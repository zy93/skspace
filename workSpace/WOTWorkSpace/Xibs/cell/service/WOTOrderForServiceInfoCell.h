//
//  WOTOrderForServiceInfoCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTOrderForServiceInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *addressValueLab;
@property (weak, nonatomic) IBOutlet UILabel *peopleLab;
@property (weak, nonatomic) IBOutlet UILabel *peopleValueLab;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *openTimeValueLab;
@property (weak, nonatomic) IBOutlet UILabel *storeyHeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaseAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *architectureAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPliesLabel;

@end
