//
//  SKListTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *topInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeDetailsButton;


@end
