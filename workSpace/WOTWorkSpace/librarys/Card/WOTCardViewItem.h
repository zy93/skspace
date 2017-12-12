//
//  WOTCardViewItem.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "CardViewItem.h"

@interface WOTCardViewItem : CardViewItem
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgIV;
@property (weak, nonatomic) IBOutlet UIView *titleBgView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
