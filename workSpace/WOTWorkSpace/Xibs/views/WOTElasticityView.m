//
//  WOTElasticityView.m
//  test
//
//  Created by 张雨 on 2017/12/13.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "WOTElasticityView.h"

#define MIN_HEIGHT          160                                     // 图形最小高度
#define MIN_HEIGHT_GAP      50

@interface WOTElasticityView ()

@property (nonatomic, assign) CGFloat mHeight;
@property (nonatomic, assign) CGFloat curveX;               // r5点x坐标
@property (nonatomic, assign) CGFloat curveY;               // r5点y坐标
@property (nonatomic, strong) UIView *curveView;            // r5红点
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL isAnimating;

@end


@implementation WOTElasticityView
static NSString *kX = @"curveX";
static NSString *kY = @"curveY";


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:kX options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:kY options:NSKeyValueObservingOptionNew context:nil];
        [self configShapeLayer];
        [self configCurveView];
        [self configAction];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self addObserver:self forKeyPath:kX options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:kY options:NSKeyValueObservingOptionNew context:nil];
        [self configShapeLayer];
        [self configCurveView];
        [self configAction];
    }
    
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:kX];
    [self removeObserver:self forKeyPath:kY];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kX] || [keyPath isEqualToString:kY]) {
        [self updateShapeLayerPath];
    }
}
#pragma mark - Configuration

- (void)configAction
{
    _mHeight = 100;                       // 手势移动时相对高度
    _isAnimating = NO;                    // 是否处于动效状态
    self.backgroundColor = [UIColor clearColor];
    // 手势
    
    // CADisplayLink默认每秒运行60次calculatePath是算出在运行期间_curveView的坐标，从而确定_shapeLayer的形状
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
}

- (void)configShapeLayer
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = UIColorFromRGB(0xff7371).CGColor;
    [self.layer addSublayer:_shapeLayer];
}

- (void)configCurveView
{
    // _curveView就是r5点
    self.curveX = SCREEN_WIDTH/2.0;       // r5点x坐标
    self.curveY = MIN_HEIGHT - MIN_HEIGHT_GAP;        // r5点y坐标
    _curveView = [[UIView alloc] initWithFrame:CGRectMake(_curveX, _curveY, 3, 3)];
    _curveView.backgroundColor = [UIColor clearColor];
    [self addSubview:_curveView];
}

#pragma mark -
#pragma mark - Action

-(void)scrollViewPoint:(CGPoint)point isEnd:(BOOL)end
{
    if(!_isAnimating)
    {
        if(!end)
        {
            // 手势移动时，_shapeLayer跟着手势向下扩大区域

            // 这部分代码使r5红点跟着手势走
            _mHeight = point.y + MIN_HEIGHT-MIN_HEIGHT_GAP ;
            self.curveX = SCREEN_WIDTH/2.0 + point.x;
            self.curveY = _mHeight > MIN_HEIGHT-MIN_HEIGHT_GAP ? _mHeight : MIN_HEIGHT-MIN_HEIGHT_GAP;
            _curveView.frame = CGRectMake(_curveX,
                                          _curveY,
                                          _curveView.frame.size.width,
                                          _curveView.frame.size.height);
        }
        else if (end)
        {
            // 手势结束时,_shapeLayer返回原状并产生弹簧动效
            _isAnimating = YES;
            _displayLink.paused = NO;           //开启displaylink,会执行方法calculatePath.

            // 弹簧动效
            [UIView animateWithDuration:1.0
                                  delay:0.0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{

                                 // 曲线点(r5点)是一个view.所以在block中有弹簧效果.然后根据他的动效路径,在calculatePath中计算弹性图形的形状
                                 _curveView.frame = CGRectMake(SCREEN_WIDTH/2.0, MIN_HEIGHT-MIN_HEIGHT_GAP, 3, 3);

                             } completion:^(BOOL finished) {

                                 if(finished)
                                 {
                                     _displayLink.paused = YES;
                                     _isAnimating = NO;
                                 }

                             }];
        }
    }
}


- (void)updateShapeLayerPath
{
    // 更新_shapeLayer形状
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0, 0)];                              // r1点
    [tPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];            // r2点
    [tPath addLineToPoint:CGPointMake(SCREEN_WIDTH,  MIN_HEIGHT)];  // r4点
    [tPath addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT)
                  controlPoint:CGPointMake(_curveX, _curveY)]; // r3,r4,r5确定的一个弧线
    [tPath closePath];
    _shapeLayer.path = tPath.CGPath;
}


- (void)calculatePath
{
    // 由于手势结束时,r5执行了一个UIView的弹簧动画,把这个过程的坐标记录下来,并相应的画出_shapeLayer形状
    CALayer *layer = _curveView.layer.presentationLayer;
    self.curveX = layer.position.x;
    self.curveY = layer.position.y;
}
@end
