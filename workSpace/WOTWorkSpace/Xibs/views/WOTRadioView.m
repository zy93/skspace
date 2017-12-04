//
//  WOTRadioView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTRadioView.h"
#import "header.h"

#define  WOTRadioViewDefaultWidth [UIScreen mainScreen].bounds.size.width - (60*2)
static const CGFloat WOTRadioViewMinimumHeight = 200;
static const CGFloat WOTOtherButtonDefaultHeight = 35;

CGFloat CGAffineTransformGetAbsoluteRotationAngleDifference(CGAffineTransform t1, CGAffineTransform t2)
{
    CGFloat dot = t1.a * t2.a + t1.c * t2.c;
    CGFloat n1 = sqrtf(t1.a * t1.a + t1.c * t1.c);
    CGFloat n2 = sqrtf(t2.a * t2.a + t2.c * t2.c);
    return acosf(dot / (n1 * n2));
}

typedef void (^WOTAnimationCompletionBlock)(BOOL); // Internal.

@interface WOTRadioView()
{
    BOOL hasLayedOut;
}

@property (nonatomic, strong) NSMutableArray *otherButtons;
@property(nonatomic, assign) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;


@end


@implementation WOTRadioView

-(id)initWithTitle:(NSString *)title message:(NSString *)message otherButtonTitle:(NSString *)otherTilte, ...
{
    CGRect frame = CGRectMake(0, 0, WOTRadioViewDefaultWidth, WOTRadioViewMinimumHeight);
    
    if((self = [super initWithFrame:frame]))
    {
        _otherButtons = [NSMutableArray array];
        mBtnTitleList = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8.f;
        if (otherTilte) {
            [mBtnTitleList addObject:otherTilte];
            
            NSString *str;
            va_list argumentList;
            va_start(argumentList, otherTilte);
            while ((str = va_arg(argumentList, NSString *))) {
                [mBtnTitleList addObject:str];
            }
            va_end(argumentList);
        }
        
        for (int i = 0; i < mBtnTitleList.count; i++) {
            UIButton *otherBtn = [self buttonWithTitle:mBtnTitleList[i]];
            otherBtn.tag = i;
            [self.otherButtons addObject:otherBtn];
            [self addSubview:otherBtn];
        }
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)deviceOrientationChanged:(NSNotification *)notification
{
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGAffineTransform baseTransform = [self transformForCurrentOrientation];
    
    CGFloat delta = CGAffineTransformGetAbsoluteRotationAngleDifference(self.transform, baseTransform);
    BOOL isDoubleRotation = (delta > M_PI);
    if(hasLayedOut)
    {
        CGFloat duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
        if(isDoubleRotation)
            duration *= 2;
        
        [UIView animateWithDuration:duration animations:^{
            self.transform = baseTransform;
        }];
    }
    else
        self.transform = baseTransform;
    
    hasLayedOut = YES;
    
    CGRect boundingRect = self.bounds;
    boundingRect = UIEdgeInsetsInsetRect(boundingRect, self.contentInsets);
    
    //布局
    CGRect otherButtonRect = CGRectMake(35, 18, self.bounds.size.width-35*2, WOTOtherButtonDefaultHeight);

    for (int i = 0; i < self.otherButtons.count; i++) {
        UIButton *otherButton = [self.otherButtons objectAtIndex:i];
        otherButton.frame = otherButtonRect;
        //加个小圆点
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        circleView.center = CGPointMake(CGRectGetMaxX(otherButton.bounds)-10, CGRectGetHeight(otherButton.bounds)*0.5f);
        circleView.layer.cornerRadius = 5;
        circleView.backgroundColor = LowTextColor;
        [otherButton addSubview:circleView];
        if (i < self.otherButtons.count-1) {
            otherButtonRect = CGRectMake(CGRectGetMinX(otherButton.frame) , CGRectGetMaxY(otherButton.frame),CGRectGetWidth(otherButton.frame), WOTOtherButtonDefaultHeight);
        }
    }
    
    //更新
    CGRect newBounds = CGRectMake(0, 0, self.bounds.size.width, CGRectGetMaxY(otherButtonRect)+18);
    CGPoint newCenter = CGPointMake(self.superview.bounds.size.width * 0.5, self.superview.bounds.size.height * 0.5 -80*[WOTUitls GetLengthAdaptRate]);
    self.bounds = newBounds;
    self.center = newCenter;
    
}

//加载button
- (UIButton *)buttonWithTitle:(NSString *)aTitle {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    return button;
}

-(void)buttonDown:(UIButton *)button
{
    [self dismiss];
    if (block) {
        block(button.tag, button.titleLabel.text);
    }
}

-(void)handleButtonBlock:(WOTRadioViewBlock)btnBlock
{
    block = btnBlock;
}

#pragma mark - shwo and dismiss

- (void)show {
    [self showWithStyle:self.presentationStyle];
}

- (void)showWithStyle:(WOTRadioViewPresentationStyle)style
{
    self.presentationStyle = style;
    
    [self setNeedsLayout];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIImageView *dimView = [[UIImageView alloc] initWithFrame:keyWindow.bounds];
    dimView.image = [self backgroundGradientImageWithSize:keyWindow.bounds.size];
    dimView.userInteractionEnabled = YES;
    
    [keyWindow addSubview:dimView];
    [dimView addSubview:self];
    
    [self performPresentationAnimation];
}


- (void)dismiss {
    [self dismissWithStyle:self.dismissalStyle];
}

- (void)dismissWithStyle:(WOTRadioViewDismissalStyle)style {
    self.dismissalStyle = style;
    [self performDismissalAnimation];
}

#pragma mark - Drawing utilities for implementing system control styles

- (UIImage *)backgroundGradientImageWithSize:(CGSize)size
{
    CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
    CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    CGFloat components[locationCount * 4] = {
        0.0, 0.0, 0.0, 0.1, // More transparent black
        0.0, 0.0, 0.0, 0.7  // More opaque black
    };
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, locationCount);
    
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return image;
}

#pragma mark - Orientation helpers
- (CGAffineTransform)transformForCurrentOrientation
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationPortraitUpsideDown)
        transform = CGAffineTransformMakeRotation(M_PI);
    else if(orientation == UIInterfaceOrientationLandscapeLeft)
        transform = CGAffineTransformMakeRotation(-M_PI_2);
    else if(orientation == UIInterfaceOrientationLandscapeRight)
        transform = CGAffineTransformMakeRotation(M_PI_2);
    
    return transform;
}

#pragma mark - Presentation and dismissal animation utilities

- (void)performPresentationAnimation
{
    if(self.presentationStyle == WOTRadioViewPresentationStylePop)
    {
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
        bounceAnimation.duration = 0.3;
        bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        bounceAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0.01],
                                  [NSNumber numberWithFloat:1.1],
                                  [NSNumber numberWithFloat:0.9],
                                  [NSNumber numberWithFloat:1.0],
                                  nil];
        
        [self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
        
        CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
        fadeInAnimation.duration = 0.3;
        fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
        fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
        [self.superview.layer addAnimation:fadeInAnimation forKey:@"opacity"];
    }
    else if(self.presentationStyle == WOTRadioViewPresentationStyleFade)
    {
        self.superview.alpha = 0;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
         {
             self.superview.alpha = 1;
         }
                         completion:nil];
    }
    else
    {
        // Views appear immediately when added
    }
}

- (void)performDismissalAnimation {
    WOTAnimationCompletionBlock completionBlock = ^(BOOL finished)
    {
        [self.superview removeFromSuperview];
        [self removeFromSuperview];
    };
    
    
    if(self.dismissalStyle == WOTRadioViewDismissalStyleTumble)
    {
        [UIView animateWithDuration:0.7
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             CGPoint offset = CGPointMake(0, self.superview.bounds.size.height * 1.5);
             offset = CGPointApplyAffineTransform(offset, self.transform);
             self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeRotation(-M_PI_4));
             self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
             self.superview.alpha = 0;
         }
                         completion:completionBlock];
    }
    else if(self.dismissalStyle == WOTRadioViewDismissalStyleFade)
    {
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
         {
             self.superview.alpha = 0;
         }
                         completion:completionBlock];
    }
    else if(self.dismissalStyle == WOTRadioViewDismissalStyleZoomDown)
    {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01));
             self.superview.alpha = 0;
         }
                         completion:completionBlock];
    }
    else if(self.dismissalStyle == WOTRadioViewDismissalStyleZoomOut)
    {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^
         {
             self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(10, 10));
             self.superview.alpha = 0;
         }
                         completion:completionBlock];
    }
    else
    {
        completionBlock(YES);
    }
}

@end
