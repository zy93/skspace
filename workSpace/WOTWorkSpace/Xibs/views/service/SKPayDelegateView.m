//
//  SKPayDelegateView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKPayDelegateView.h"
#import "Masonry.h"

@interface SKPayDelegateView()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation SKPayDelegateView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"协议";
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(5);
        make.centerX.mas_equalTo(self);
    }];
    
    self.levelLine = [[UIView alloc] init];
    self.levelLine.backgroundColor = UICOLOR_GRAY_CC;
    [self addSubview:self.levelLine];
    [self.levelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).with.offset(-48);
        make.height.mas_offset(1);
    }];
    
    self.webView = [[UIWebView alloc] init];
//    self.textView.editable = NO;
//    self.textView.text = @"感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。感谢您选择支付宝服务。支付宝服务协议（以下简称本协议）由支付宝（中国）网络技术有限公司（以下简称支付宝）和您签订。";
//    self.textView.textColor = UICOLOR_GRAY_66;
    self.webView.delegate = self;
    //self.webView.scrollView.delegate = self;
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
        make.bottom.equalTo(self.levelLine.mas_top);
    }];
    
    self.verticalLine = [[UIView alloc] init];
    self.verticalLine.backgroundColor = UICOLOR_GRAY_CC;
    [self addSubview:self.verticalLine];
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelLine.mas_bottom);
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_offset(1);
    }];
    
    self.agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    self.agreeButton.titleLabel.font = [UIFont fontWithName:@"Hiragino Maru Gothic ProN" size:17];
    [self.agreeButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self addSubview:self.agreeButton];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelLine.mas_bottom);
        make.left.equalTo(self.verticalLine.mas_right);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleButton setTitle:@"拒绝" forState:UIControlStateNormal];
    self.cancleButton.titleLabel.font = [UIFont fontWithName:@"Hiragino Maru Gothic ProN" size:17];
    [self.cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.cancleButton];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.levelLine.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self.verticalLine.mas_left);
        make.bottom.equalTo(self);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x > 0) {
        scrollView.contentOffset = CGPointMake(0, point.y);//这里不要设置为CGPointMake(0, 0)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
    }
}

@end
