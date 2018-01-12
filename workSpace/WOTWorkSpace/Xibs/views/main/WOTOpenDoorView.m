//
//  WOTOpenDoorView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOpenDoorView.h"
#import "Masonry.h"
#import "HCCreateQRCode.h"
#import "UIImage+Extension.h"
#import "UIImage+Blur.h"

@interface WOTOpenDoorView ()
{
    UIViewController *_fromController;
}
@property (nonatomic, strong) UIImageView *bgIV;
@property (nonatomic, strong) UIView *QRBgView;
@property (nonatomic, strong) UIImageView *QRIV;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *lab2;


@end


@implementation WOTOpenDoorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    
    
    NSString *str =[WOTSingtleton shared].QRcodeStr;
    UIImage *im = [HCCreateQRCode createQRCodeWithString:[WOTSingtleton shared].QRcodeStr ViewController:nil];
    [self.QRIV setImage:im];
    
    //加阴影
    self.QRBgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.QRBgView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.QRBgView.layer.shadowRadius = 8;//阴影半径，默认3
    self.QRBgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    
    [self addSubview:self.bgIV];
    [self addSubview:self.QRBgView];
    [self.QRBgView addSubview:self.QRIV];
    [self addSubview:self.lab1];
    [self addSubview:self.btn];
    [self addSubview:self.lab2];
    
//    [self.QRBgView setBackgroundColor:UIColorFromRGB(0x123456)];
//    [self.QRIV setBackgroundColor:UIColorFromRGB(0x654321)];
    
    [_bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [_QRBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(100);
        make.left.mas_equalTo(self).offset(40);
        make.right.mas_equalTo(self).offset(-40);
        make.height.equalTo(_QRBgView.mas_width).multipliedBy(1.f);
    }];
    
    [_QRIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.QRBgView).offset(10);
        make.left.mas_equalTo(self.QRBgView).offset(10);
        make.right.mas_equalTo(self.QRBgView).offset(-10);
        make.bottom.mas_equalTo(self.QRBgView).offset(-10);
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QRBgView.mas_bottom).offset(15);
        make.left.equalTo(_QRBgView.mas_left);
        make.right.equalTo(_QRBgView.mas_right);
    }];
    
    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.left.equalTo(_QRBgView.mas_left);
        make.right.equalTo(_QRBgView.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lab2.mas_top).offset(-15);
        make.centerX.equalTo(self.lab2.mas_centerX);
//        make.left.equalTo(_QRBgView.mas_left);
//        make.right.equalTo(_QRBgView.mas_right);
    }];
    
    
}

// 按钮滑出动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

// 按钮弹出动画
- (void)showWithController:(UIViewController *)fromController {
    _fromController = fromController;
    self.alpha = 0.0;
    [fromController.view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
}


-(void)changeBtn:(UIButton *)b
{
    if (self.btnClick) {
        self.btnClick(nil);
    }
}


#pragma mark - add object
-(UIImageView *)bgIV
{
    if (!_bgIV) {
        _bgIV = [[UIImageView alloc] init];
        //_bgIV = [[UIImageView alloc] initWithImage:[[UIImage getScreenSnap] blur]];
    }
    return _bgIV;
}

-(UIView *)QRBgView
{
    if (!_QRBgView) {
        _QRBgView = [[UIView alloc] init];
    }
    return _QRBgView;
}

-(UIImageView *)QRIV
{
    if (!_QRIV) {
        _QRIV = [[UIImageView alloc] init];
    }
    return _QRIV;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"change_btn_gray"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"change_btn_black"] forState:UIControlStateHighlighted];
        [_btn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _btn;
}

-(UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        [_lab1 setTextAlignment:NSTextAlignmentCenter];
        [_lab1 setFont:[UIFont systemFontOfSize:13.f]];
        [_lab1 setText:@"如果二维码识别，请尝试其他开门方式"];
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        [_lab2 setTextAlignment:NSTextAlignmentCenter];
        [_lab2 setFont:[UIFont systemFontOfSize:15.f]];
        [_lab2 setText:@"切换至扫一扫"];
    }
    return _lab2;
}



@end
