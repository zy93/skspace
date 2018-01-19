//
//  WOTOrderForPaymentCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WOTOrderForPaymentCellDelegate <NSObject>

-(void)choosePayWay:(NSString *)payWayStr;

@end

@interface WOTOrderForPaymentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *alipayButton;
@property (weak, nonatomic) IBOutlet UIButton *wxpayButton;

@property (nonatomic, weak) id <WOTOrderForPaymentCellDelegate> delegate;

@end
