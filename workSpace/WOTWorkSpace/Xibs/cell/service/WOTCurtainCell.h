//
//  WOTCurtainCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>




@class WOTCurtainCell;

@protocol WOTCurtainCellDelegate <NSObject>

-(void)curtaincellOfSwitch:(WOTCurtainCell*)cell option:(BOOL)isOn;

/**
 开关停代理

 @param cell cell
 @param value 0-开; 1-停; 2-关;
 */
-(void)cellOfState:(WOTCurtainCell*)cell value:(NSInteger)value;

@end



@interface WOTCurtainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UISwitch *switchSW;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *offBtn;

@property (nonatomic, strong) id <WOTCurtainCellDelegate> delegate;


@end
