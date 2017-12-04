//
//  WOTMyAppointmentCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WOTMyAppointRemindingDelegate<NSObject>

@required
-(void)settingRemindWithIndex:(NSInteger)index isRemind:(BOOL)isRemid;
@optional

@end

@interface WOTMyAppointmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *appointmentCommunityLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointmentCommunityValue;

@property (weak, nonatomic) IBOutlet UILabel *appontmentObjectLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointmentObjectValue;
@property (weak, nonatomic) IBOutlet UILabel *appintmentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *appointmentTimeValue;

@property (weak, nonatomic) IBOutlet UILabel *appointmentReasionLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentReasionValue;
@property (weak, nonatomic) IBOutlet UIButton *remindmeBtn;

@property NSInteger index;

@property (nonatomic,strong)id<WOTMyAppointRemindingDelegate>delegate;

@end
