//
//  WOTScrollViewCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTeamView.h"
typedef NS_ENUM(NSInteger, WOTScrollViewCellType) {
    WOTScrollViewCellType_facilities, //配套设施
    WOTScrollViewCellType_type,    //活动类型
    WOTScrollViewCellType_team,  //社区团队
};

@class WOTScrollViewCell;

@protocol WOTScrollViewCellDelegate <NSObject>
-(void)scrollviewCell:(WOTScrollViewCell *)cell didSelectBtn:(NSString *)tel;
@end

@interface WOTScrollViewCell : UITableViewCell  <WOTTeamViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) WOTScrollViewCellType cellType;
@property (nonatomic, strong) id <WOTScrollViewCellDelegate> delegate;

-(void)setData:(NSArray *)data;



@end
