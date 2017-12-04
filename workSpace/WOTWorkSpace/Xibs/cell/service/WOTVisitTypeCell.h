//
//  WOTVisitTypeCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTVisitTypeCell;

@protocol WOTVisitTypeCellDelegate <NSObject>

-(void)selectVisitType:(WOTVisitTypeCell*)cell type:(NSInteger)type;

@end

@interface WOTVisitTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *visitBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitEnterpriseBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitIndividualBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;


@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) id <WOTVisitTypeCellDelegate> delegate;

@end
