//
//  WOTMyAppointmentCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTAppointmentModel.h"
@class WOTMyAppointmentCell;


typedef NS_ENUM(NSInteger, APPOINTMENT_CELL_TYPE) {
    APPOINTMENT_CELL_TYPE_DEFAULT,
    APPOINTMENT_CELL_TYPE_BUTTON,
};


@protocol WOTMyAppointmentCellDelegate <NSObject>

-(void)cellAgree:(WOTMyAppointmentCell *)cell sender:(UIButton *)sender;
-(void)cellreject:(WOTMyAppointmentCell *)cell sender:(UIButton *)sender;

@end


@interface WOTMyAppointmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UILabel *threeLab;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBGViewConstraint;
@property (nonatomic, strong) WOTAppointmentModel *model;
@property (nonatomic, assign) APPOINTMENT_CELL_TYPE cellType;
@property (nonatomic, strong) id <WOTMyAppointmentCellDelegate> delegate;

@end
