//
//  YYShareView.h
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/13.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYShareViewDelegate <NSObject>

-(void)ClickShareWithType:(NSInteger)argType;

@end

@interface YYShareView : UIView

@property (nonatomic,weak)id<YYShareViewDelegate> propDelegate;

-(void)ShowView;

@end
