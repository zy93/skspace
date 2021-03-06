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
-(void)changeValue:(WOTOrderForBookStationCell *)cell;

@end

@interface WOTOrderForBookStationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (nonatomic, assign)int orderNumberInt;
@property (nonatomic, strong)NSNumber *maxNumber;
@property (nonatomic,weak) id<WOTOrderForBookStationCellDelegate>delegate;



@end
