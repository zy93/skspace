//
//  WOTGetProvidersCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTGetProvidersCell;

@protocol WOTGetProvidersCellDelegate <NSObject>
-(void)getProvidersCell:(WOTGetProvidersCell *)cell selectType:(NSString *)type;

@end

@interface WOTGetProvidersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (nonatomic, strong) id <WOTGetProvidersCellDelegate> delegate;
@end
