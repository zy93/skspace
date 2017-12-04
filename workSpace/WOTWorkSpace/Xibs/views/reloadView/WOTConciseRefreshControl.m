//
//  WOTConciseRefreshControl.m
//  YNCCProduct
//
//  Created by YNKJMACMINI4 on 16/6/30.
//  Copyright © 2016年 YNKJMACMINI2. All rights reserved.
//

#import "WOTConciseRefreshControl.h"

@implementation WOTConciseRefreshControl

static const CGFloat DefaultScreenWidth = 320.0;
static const CGFloat ReloadHeight = 120.0;
static const CGFloat SpringTreshold = 120.0;
static const CGFloat AnimationDuration = 1.f;
static const CGFloat AnimationDamping = 0.4f;
static const CGFloat AnimationVelosity= 0.8f;


- (instancetype)initWithFrame:(CGRect)frame;{

    return [[[NSBundle mainBundle] loadNibNamed:@"WOTConciseRefreshControl" owner:self options:nil] firstObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    CGFloat leadingRatio = [UIScreen mainScreen].bounds.size.width / DefaultScreenWidth;
    self.backView.frame = CGRectMake(self.backView.frame.origin.x, self.backView.frame.origin.y, self.backView.frame.size.width * leadingRatio, self.backView.frame.size.height * leadingRatio);
}



- (void)attachToScrollView:(UIScrollView *)scrollView {
    self.scrollView = scrollView;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self setFrame:CGRectMake(0.f, 0.f, self.scrollView.frame.size.width,0)];
    
    [self.scrollView addSubview:self];
}
-(void)dealloc{
    
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    [self calculateShift];
    
}

-(void)calculateShift{
    
    if (-self.scrollView.contentOffset.y < 100*[UIScreen mainScreen].bounds.size.width/DefaultScreenWidth){
        self.reloadText.text = @"松手刷新数据";
    }
    
    [self setFrame:CGRectMake(0.f, 0.f, self.scrollView.frame.size.width, self.scrollView.contentOffset.y)];
    [self refreshingAnimation];
    if (self.scrollView.contentOffset.y < -(ReloadHeight * [UIScreen mainScreen].bounds.size.width/DefaultScreenWidth )) {
        
        if (self.scrollView.contentOffset.y <  -(SpringTreshold  * [UIScreen mainScreen].bounds.size.width/DefaultScreenWidth)) {
            int y = ( SpringTreshold  * [UIScreen mainScreen].bounds.size.width/DefaultScreenWidth);
            [self.scrollView setContentOffset:CGPointMake(0.f, -y)];
        }
        if (!self.forbidSunSet && self.scrollView.isTracking == NO) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            [self rotateAnimation];
            self.forbidSunSet = YES;
        }
    }
    
    
    if ((ReloadHeight * [UIScreen mainScreen].bounds.size.width/DefaultScreenWidth) <= -self.scrollView.contentOffset.y ) {
        if (!self.scrollView.dragging && self.scrollView.decelerating && !self.forbidContentInsetChanges) {
            [self beginRefreshing];
            self.reloadText.text = @"加载数据中...";
        }
    }
    
}
//下拉过程中的动画及蒙版效果
-(void)refreshingAnimation{
    if ( - self.scrollView.contentOffset.y < (100 * [UIScreen mainScreen].bounds.size.width/320 )) {
//        
//        self.centerTopImage.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha: 1 - (-self.scrollView.contentOffset.y / (100 * [UIScreen mainScreen].bounds.size.width/320 ))];
        self.centerImage.transform = CGAffineTransformMakeRotation( M_PI *2 *(- self.scrollView.contentOffset.y / (100 * [UIScreen mainScreen].bounds.size.width/320 )));
        
    }
    if ( !(- self.scrollView.contentOffset.y < (100 * [UIScreen mainScreen].bounds.size.width/320 ))) {
        self.centerTopImage.backgroundColor = [UIColor clearColor];
        self.centerTopImage.transform = CGAffineTransformMakeRotation(0.0);
    }
}
-(void)beginRefreshing {
    int y = ReloadHeight * [UIScreen mainScreen].bounds.size.width/DefaultScreenWidth;
    [self.scrollView setContentInset:UIEdgeInsetsMake(y, 0.f, 0.f, 0.f)];
    [self.scrollView setContentOffset:CGPointMake(0.f, -y) animated:YES];
    self.forbidContentInsetChanges = YES;
}



-(void)rotateAnimation{
    if (!self.imageIsRoting) {
        self.imageIsRoting = YES;
        CABasicAnimation * centerImageAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        centerImageAnimation.toValue = @(M_PI * 4.0);//下拉已经旋转一周了所以是3
        centerImageAnimation.duration = 2/([self shiftInPercents]/100);
        centerImageAnimation.autoreverses = NO;
        centerImageAnimation.repeatCount = HUGE_VAL;
        centerImageAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.centerImage.layer addAnimation:centerImageAnimation forKey:@"Center_Animation"];
    }
    
}
-(CGFloat)shiftInPercents{
    return (ReloadHeight / 100) * -self.scrollView.contentOffset.y;
}
-(void)stopRotating{
    self.imageIsRoting = NO;
    [self.centerImage.layer removeAnimationForKey:@"Center_Animation"];
}
-(void)endRefreshing{
    
    
    int y = ReloadHeight * [UIScreen mainScreen].bounds.size.width/DefaultScreenWidth;
    if(self.scrollView.contentOffset.y > -y){
        
        [self performSelector:@selector(returnToDefaultState) withObject:nil afterDelay:AnimationDuration];
    }else{
        [self returnToDefaultState];
    }
}

-(void)returnToDefaultState{
    
    self.forbidContentInsetChanges = NO;
    [UIView animateWithDuration:AnimationDuration
                          delay:0.f
         usingSpringWithDamping:AnimationDamping
          initialSpringVelocity:AnimationVelosity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.scrollView setContentInset:UIEdgeInsetsMake(64, 0.f, 0.f, 0.f)];
                     } completion:nil];
    self.forbidSunSet = NO;
    self.reloadText.text = @"下拉刷新数据";
    [self stopRotating];
    
}

@end
