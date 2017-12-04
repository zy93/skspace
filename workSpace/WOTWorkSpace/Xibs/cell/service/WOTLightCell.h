//
//  WOTLightCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WOTLightCell;

@protocol WOTLightCellDelegate <NSObject>

-(void)lightcellOfSwitch:(NSInteger)index option:(BOOL)isOn;
-(void)cellOfSlider:(WOTLightCell*)cell value:(NSInteger)value;

@end

@interface WOTLightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UISwitch *switchSW;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic, strong) id <WOTLightCellDelegate> delegate;
@property (nonatomic, assign) NSInteger index;
@end
