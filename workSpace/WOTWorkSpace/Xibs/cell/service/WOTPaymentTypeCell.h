//
//  WOTPaymentTypeCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTPaymentTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *enterpriseBtn;
@property (weak, nonatomic) IBOutlet UIButton *personBtn;

@property (nonatomic, assign, getter=isEnterprise) BOOL enterprise;

@end
