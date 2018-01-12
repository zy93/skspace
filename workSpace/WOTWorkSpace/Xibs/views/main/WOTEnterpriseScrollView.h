//
//  WOTEnterpriseScrollView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/8.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTEnterpriseScrollView;

@protocol WOTEnterpriseScrollViewDelegate <NSObject>
-(void)enterpriseScroll:(WOTEnterpriseScrollView *)scroll didSelectWithIndex:(NSInteger)index;
@end


@interface WOTEnterpriseScrollView : UIScrollView
@property (nonatomic, strong) id <WOTEnterpriseScrollViewDelegate> mDelegate;
-(void)setData:(NSArray *)data;


@end
