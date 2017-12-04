//
//  WOTOrderForPaymentCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTOrderForPaymentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@property (nonatomic, assign, getter=isAlipay) BOOL alipay;
@property (nonatomic, assign, getter=isSelected) BOOL select;
@end
