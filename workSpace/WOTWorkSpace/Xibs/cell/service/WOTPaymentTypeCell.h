//
//  WOTPaymentTypeCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTPaymentTypeCell;

@protocol WOTPaymentTypeCellDelegate <NSObject>
-(void)paymentTypeCell:(WOTPaymentTypeCell*)cell selectPaymentType:(NSNumber *)paymentType;
@end

@interface WOTPaymentTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *enterpriseBtn;
@property (weak, nonatomic) IBOutlet UIButton *personBtn;

@property (nonatomic, assign, getter=isEnterprise) BOOL enterprise;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) id <WOTPaymentTypeCellDelegate> delegate;

@end
