//
//  SKFocusListTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMButton.h"

@interface SKFocusListTableViewCell : UITableViewCell

@property(nonatomic,strong)YMButton *cancelFocusButton;
@property(nonatomic,strong)UIImageView *userHeadImageView;
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *userCompany;

@end
