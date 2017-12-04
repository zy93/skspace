//
//  WOTVisitorsAppointmentSubmitCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/24.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTVisitorsAppointmentSubmitCell;

@protocol WOTVisitorsAppointmentSubmitCellDelegate <NSObject>

-(void)submitVisitorInfo:(WOTVisitorsAppointmentSubmitCell*)cell;

@end

@interface WOTVisitorsAppointmentSubmitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) id <WOTVisitorsAppointmentSubmitCellDelegate> delegate;
@end
