//
//  WOTScrollViewCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WOTScrollViewCellType) {
    WOTScrollViewCellType_facilities, //配套设施
    WOTScrollViewCellType_type,    //活动类型
    WOTScrollViewCellType_team,  //社区团队
};

@interface WOTScrollViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) WOTScrollViewCellType cellType;


-(void)setData:(NSArray *)data;



@end
