//
//  WOTMyRepairdCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/13.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WOTMyRepairdCell;
@protocol WOTMyRepairdCellDelegate <NSObject>
-(void)repairdCell:(WOTMyRepairdCell *)cell btnClick:(NSIndexPath *)index;
@end

@interface WOTMyRepairdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repairdTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdAddrLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdContentLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdTypeValueLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdAddrValueLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdTimeValueLab;
@property (weak, nonatomic) IBOutlet UILabel *repairdContentValueLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *repairdStateLab;

@property (nonatomic, strong) NSIndexPath * index;
@property (nonatomic, strong) id <WOTMyRepairdCellDelegate> delegate;

@end
