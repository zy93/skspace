//
//  WOTAirconditioningCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WOTAirconditioningDelegate

@required
-(void)switchChangeState:(BOOL)switchState;
@end
@interface WOTAirconditioningCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIImageView *fanspeedImage;
@property (weak, nonatomic) IBOutlet UIImageView *heatingImage;
@property (weak, nonatomic) IBOutlet UIImageView *refrigerationImage;
@property (weak, nonatomic) IBOutlet UILabel *fanspeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *refrigerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *heatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UISlider *temperatureSlider;
@property (weak, nonatomic) IBOutlet UIImageView *autoControlImage;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *lowBtn;
@property (weak, nonatomic) IBOutlet UIButton *highBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoControlBtn;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@property(nonatomic,strong)id<WOTAirconditioningDelegate>delegate;
@end
