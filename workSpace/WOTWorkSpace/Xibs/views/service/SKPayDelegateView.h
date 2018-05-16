//
//  SKPayDelegateView.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SKPayDelegateView : UIView

@property(nonatomic,strong)UIButton *agreeButton;
@property(nonatomic,strong)UIButton *cancleButton;
//@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *levelLine;
@property(nonatomic,strong)UIView *verticalLine;

@end
