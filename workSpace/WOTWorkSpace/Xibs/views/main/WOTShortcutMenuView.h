//
//  WOTShortcutMenuView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTShortcutMenuView;
@protocol WOTShortcutMenuViewDelegate <NSObject>
-(void)shortcutMenu:(WOTShortcutMenuView*)menu pushToVCWithStoryBoardName:(NSString *)sbName vcName:(NSString *)vcName;

@end

@interface WOTShortcutMenuView : UIView
@property (nonatomic, strong) id <WOTShortcutMenuViewDelegate> delegate;

@end
