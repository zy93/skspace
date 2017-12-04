//
//  WOTCityTileView.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WOTCityTileViewDelegate <NSObject>

@required
-(void)selectedCityIndex:(NSInteger)index;

@end

@interface WOTCityTileView : UIView

@property (nonatomic,copy)id <WOTCityTileViewDelegate>tiledelegate;

-(WOTCityTileView *)initWithFrame:(CGRect)frame;

@end
