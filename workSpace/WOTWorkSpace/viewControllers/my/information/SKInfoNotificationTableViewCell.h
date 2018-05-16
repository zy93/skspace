//
//  SKInfoNotificationTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKInfoNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIImageView *redDotImageView;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *notifationTimeLabel;

@end
