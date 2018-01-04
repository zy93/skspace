//
//  CLTabBar.m
//  weibo-OC
//
//  Created by Oboe_b on 16/8/29.
//  Copyright © 2016年 Oboe_b. All rights reserved.
//

#import "CLTabBar.h"

@interface TabBarButton : UIButton

@end

@implementation TabBarButton
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更改image的中心坐标
    CGPoint imageCenter = self.imageView.center;
    imageCenter.x = self.frame.size.width/2;
    imageCenter.y = (self.frame.size.height-self.imageView.frame.size.height)/2+10;
    self.imageView.center = imageCenter;
    
    // 更改label的中心坐标
    CGRect labelFrame = self.titleLabel.frame;
    labelFrame.origin.x = 0;
    labelFrame.origin.y = CGRectGetMaxY(self.imageView.frame)+3 ;
    labelFrame.size.width = self.frame.size.width;
    labelFrame.size.height= 10;
    
    self.titleLabel.frame = labelFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}






@end





@interface CLTabBar ()

@property (strong, nonatomic) TabBarButton *composeButton;

@end

@implementation CLTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    [self addSubview:self.composeButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 每个Button的宽
    CGFloat itemW = self.bounds.size.width / 5;
    self.composeButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    // 一个UITabBarButton的索引
    NSInteger index = 0;
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGRect rect = subView.frame;
            rect.origin.x = index * itemW;
            rect.size.width = itemW;
            
            if (index == 1) {
                index ++;
            }
            subView.frame = rect;
            index ++;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    if (view == nil) {
        // 转换坐标系
        CGFloat w = SCREEN_WIDTH/5;
//        CGPoint newPoint = [self.composeButton convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(CGRectMake(w*2, -15 , w, self.bounds.size.height), point)) {
            view = self.composeButton;
        }
    }
    return view;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    CGFloat w = SCREEN_WIDTH/5;
//    NSLog(@"======%f  %f  %f",self.composeButton.frame.origin.x, self.composeButton.frame.origin.y,self.bounds.size.height);
//    if (CGRectContainsPoint(CGRectMake(w*2, -11, w, self.bounds.size.height),point)) {
//        return YES;
//    }
//    return NO;
//}

- (void)composeBtnClick :(UIButton *)sender {
    if (self.composeButtonClick) {
        self.composeButtonClick();
    }
}

#pragma mark -- 懒加载
- (UIButton *)composeButton {
    if(!_composeButton){
        _composeButton = [TabBarButton buttonWithType:UIButtonTypeCustom];
        [_composeButton setTitle:@"开门" forState:UIControlStateNormal];
        [_composeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
//        NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:252.f/255.f green:91.f/255.f blue:17.f/255.f alpha:1] forKey:NSForegroundColorAttributeName];
//        [_composeButton sett];
//        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"123"];
//        [attriString addAttribute:NSForegroundColorAttributeName
//                            value:[UIColor redColor]
//                            range:NSMakeRange(4, 2)];
//        [_composeButton setAttributedTitle:attriString forState:UIControlStateNormal];
        
        
        
        [_composeButton setTitleColor:UICOLOR_GRAY_66 forState:UIControlStateNormal];
        [_composeButton setTitleColor:UICOLOR_MAIN_ORANGE forState:UIControlStateHighlighted];
        
        [_composeButton addTarget:self action:@selector(composeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_composeButton setImage:[UIImage imageNamed:@"openDoor"] forState:UIControlStateNormal];
        [_composeButton setImage:[UIImage imageNamed:@"openDoor_select"] forState:UIControlStateHighlighted];
//        [_composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [_composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_composeButton sizeToFit];
    }
    return _composeButton;
}

@end
