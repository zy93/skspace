//
//  WOTOrderForBookStationCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSpaceModel.h"

@class WOTOrderForBookStationCell;

@protocol WOTOrderForBookStationCellDelegate <NSObject>

-(void)showDataPickerView:(WOTOrderForBookStationCell *)cell;

-(void)changeValue:(WOTOrderForBookStationCell *)cell;

@end

@interface WOTOrderForBookStationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *beginTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *surplusLab;
@property (weak, nonatomic) IBOutlet UILabel *timeExplanationLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (nonatomic, assign)BOOL isHiddenDataPickerView;
@property (weak, nonatomic) IBOutlet UILabel *startDataLable;
@property (weak, nonatomic) IBOutlet UILabel *endDataLabel;

@property (nonatomic, strong)WOTSpaceModel *spaceModel;

@property (nonatomic,weak) id<WOTOrderForBookStationCellDelegate>delegate;

@end
