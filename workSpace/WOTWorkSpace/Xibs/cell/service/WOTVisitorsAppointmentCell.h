//
//  WOTVisitorsAppointmentCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTVisitorsAppointmentCell;


@protocol WOTVisitorsAppointmentCellDelegate <NSObject>

-(void)textFiledEndEnter:(WOTVisitorsAppointmentCell *)cell text:(NSString *)text;

@end

@interface WOTVisitorsAppointmentCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIButton *womBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (nonatomic, strong) NSIndexPath *index;

@property (nonatomic, strong) id <WOTVisitorsAppointmentCellDelegate> delegate;

@end
