//
//  WOTMyOrderInfoCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTMyOrderInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgIV;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;

-(void)setupViews;

@end
