//
//  WOTScrollViewCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTScrollViewCell.h"

#import "WOTFacilitiesView.h"
#import "WOTTeamView.h"


#define facilitiesViewWidth  (([[UIScreen mainScreen] bounds].size.width - 40)/5)
#define teamViewWidth  (([[UIScreen mainScreen] bounds].size.width- 40) /3 )
#define facilitiesViewGap  0

@implementation WOTScrollViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSArray *)data otherInfos:(NSArray *)oterInfos
{
    if (self.cellType == WOTScrollViewCellType_facilities) {
        [self.titleLab setText:@"配套设施"];
        for (int i = 0; i<data.count; i++) {
            CGFloat facilitiesViewHeight = 70 *[WOTUitls GetLengthAdaptRate];
            CGFloat facilitiesStartX =  20;
            WOTFacilitiesView *view = [[WOTFacilitiesView alloc] initWithFrame:CGRectMake(i==0? facilitiesStartX: i*facilitiesViewWidth + ((i)*(facilitiesViewGap)) + facilitiesStartX, 0, facilitiesViewWidth, facilitiesViewHeight)];
            [view.image setImage:[UIImage imageNamed:@"testttt"]];
            [view.lab setText:data[i]];
            [self.scrollView addSubview:view];
            [self.scrollView setContentSize:CGSizeMake(data.count*facilitiesViewWidth+ (data.count*(facilitiesViewGap)) + facilitiesStartX, 0)];
            
        }
    }
    else if (self.cellType == WOTScrollViewCellType_type) {
        [self.titleLab setText:@"支持活动类型"];
        CGFloat height = 30;
        CGFloat startY = 0;
        CGFloat typeViewWidth = 80 * [WOTUitls GetLengthAdaptRate];
        CGFloat gap = (SCREEN_WIDTH-(40+(typeViewWidth*3)))/2;
        CGFloat verGap = 10;
        for (int i = 0; i<data.count; i++) {
            CGFloat startX = 20;
            int yushu = i%3;
            int shang = i/3;
            startX = startX+(yushu*(typeViewWidth+gap));
            startY = (shang)*height+(shang*verGap);
            UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY, typeViewWidth, height)];
            view.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
            view.layer.borderWidth = 1.f;
            view.textColor = UICOLOR_MAIN_TEXT;
            view.font = [UIFont systemFontOfSize:13.f];
            view.text = data[i];
            view.textAlignment = NSTextAlignmentCenter;
            [self.scrollView addSubview:view];
            [self.scrollView setContentSize:CGSizeMake(0, startY+30)];
            
        }
    }
    else {
        [self.titleLab setText:@"社区团队"];

        for (int i = 0; i<data.count; i++) {
            CGFloat height = 160 * [WOTUitls GetLengthAdaptRate];
            CGFloat startX = 20;
            WOTTeamView *view = [[WOTTeamView alloc] initWithFrame:CGRectMake(i==0? startX: i*teamViewWidth + ((i)*(facilitiesViewGap)) + startX, 0, teamViewWidth, height)];
            
            [self.scrollView addSubview:view];
            [self.scrollView setContentSize:CGSizeMake(data.count*teamViewWidth+ (data.count*(facilitiesViewGap)) + startX, 0)];
            
        }
    }
    
}



@end
