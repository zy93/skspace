//
//  WOTEnterpriseIntroduceNameCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTEnterpriseIntroduceNameCell;

@protocol WOTEnterpriseIntroduceNameCellDelegate <NSObject>
-(void)enterpriseCellApplyJoin:(WOTEnterpriseIntroduceNameCell *)cell;
@end

@interface WOTEnterpriseIntroduceNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;
@property (weak, nonatomic) IBOutlet UIButton *applyJoinBtn;
@property (nonatomic, strong) id <WOTEnterpriseIntroduceNameCellDelegate> delegate;

@end
