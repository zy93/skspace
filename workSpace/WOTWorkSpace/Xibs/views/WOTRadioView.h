//
//  WOTRadioView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WOTRadioViewPresentationStyleNone = 0,
    WOTRadioViewPresentationStylePop,
    WOTRadioViewPresentationStyleFade,
    WOTRadioViewPresentationStyleDefault = WOTRadioViewPresentationStylePop
} WOTRadioViewPresentationStyle;

typedef enum {
    WOTRadioViewDismissalStyleNone = 0,
    WOTRadioViewDismissalStyleZoomDown,
    WOTRadioViewDismissalStyleZoomOut,
    WOTRadioViewDismissalStyleFade,
    WOTRadioViewDismissalStyleTumble,
    WOTRadioViewDismissalStyleDefault = WOTRadioViewDismissalStyleFade
} WOTRadioViewDismissalStyle;

/**
 *  @param btnTag 0开始，
 *  @param title 输入信息
 */
typedef void (^WOTRadioViewBlock)(NSInteger btnTag, NSString *title);

@interface WOTRadioView : UIView
{
    NSMutableArray *mBtnTitleList;
    WOTRadioViewBlock block;
}

@property(nonatomic, assign) WOTRadioViewPresentationStyle presentationStyle;
@property(nonatomic, assign) WOTRadioViewDismissalStyle dismissalStyle;

+ (void)applyAlertAppearance;

/*初始化方法*/
- (id)initWithTitle:(NSString *)title message:(NSString *)message  otherButtonTitle:(NSString *)otherTilte, ... NS_REQUIRES_NIL_TERMINATION;

/***
 * @brief 处理按钮响应block
 * @param btnBlock 回调block.
 */
-(void)handleButtonBlock:(WOTRadioViewBlock)btnBlock;

- (void)show;

@end
