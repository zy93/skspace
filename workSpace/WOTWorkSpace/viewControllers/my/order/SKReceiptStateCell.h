//
//  SKReceiptStateCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 14/8/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKUIButton.h"

@interface SKReceiptStateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SKUIButton *receiptState;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
