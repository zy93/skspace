//
//  SKSupportTypeView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/3.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKSupportTypeView.h"
#import "UIColor+ColorChange.h"


@interface SKSupportTypeView()

@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UIButton *typeButton1;
@property(nonatomic,strong)UIButton *typeButton2;
@property(nonatomic,strong)UIButton *typeButton3;
@property(nonatomic,strong)UIButton *typeButton4;
@property(nonatomic,strong)UIButton *typeButton5;
@property(nonatomic,strong)UIButton *typeButton6;
@property(nonatomic,strong)UIButton *typeButton7;
@end

@implementation SKSupportTypeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupBasicView];
    }
    return self;
}

-(void)setupBasicView
{
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tapBackGesture];
    
    UITapGestureRecognizer *contentViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [self.contentView addGestureRecognizer:contentViewTapGesture];
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.typeButton1];
    [self.contentView addSubview:self.typeButton2];
    [self.contentView addSubview:self.typeButton3];
    [self.contentView addSubview:self.typeButton4];
    [self.contentView addSubview:self.typeButton5];
    [self.contentView addSubview:self.typeButton6];
    [self.contentView addSubview:self.typeButton7];
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(10);
    }];
    
    [self.typeButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(15);
        make.width.mas_offset(100);
    }];
    [self.typeButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton1.mas_top);
        make.left.equalTo(self.typeButton1.mas_right).with.offset(15);
        make.width.mas_offset(100);
    }];
    [self.typeButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton1.mas_bottom).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(15);
        make.width.mas_offset(100);
    }];
    [self.typeButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton3.mas_top);
        make.left.equalTo(self.typeButton2.mas_left);
        make.width.mas_offset(100);
    }];
    [self.typeButton5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton3.mas_bottom).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(15);
        make.width.mas_offset(100);
    }];
    [self.typeButton6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton5.mas_top);
        make.left.equalTo(self.typeButton2.mas_left);
        make.width.mas_offset(100);
    }];
    [self.typeButton7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton5.mas_bottom).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(15);
        make.width.mas_offset(100);
    }];
}

#pragma mark - 显示视图
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(kScreenW, 0, 0, kScreenH);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(kScreenW*0.3, 0, kViewScreenW, kScreenH);
    }];
}

#pragma mark - 移除视图
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(kScreenW, 0, 0, kScreenH);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW/2, 0, kViewScreenW, kATTR_VIEW_HEIGHT)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UILabel *)typeLabel
{
    if (_typeLabel == nil) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.text = @"支持类型";
    }
    return _typeLabel;
}
-(UIButton *)typeButton1
{
    if (_typeButton1 == nil) {
        _typeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton1 setTitle:@"人力资源服务" forState:UIControlStateNormal];
        _typeButton1.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton1.layer.cornerRadius = 5.f;
        _typeButton1.layer.borderWidth = 1.f;
        _typeButton1.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton1.tag = 1;
        [_typeButton1 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton1;
}
-(UIButton *)typeButton2
{
    if (_typeButton2 == nil) {
        _typeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton2 setTitle:@"财税会计服务" forState:UIControlStateNormal];
        _typeButton2.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton2.layer.cornerRadius = 5.f;
        _typeButton2.layer.borderWidth = 1.f;
        _typeButton2.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton2.tag = 2;
        [_typeButton2 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton2;
}
-(UIButton *)typeButton3
{
    if (_typeButton3 == nil) {
        _typeButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton3 setTitle:@"法律政策咨询" forState:UIControlStateNormal];
        _typeButton3.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton3.layer.cornerRadius = 5.f;
        _typeButton3.layer.borderWidth = 1.f;
        _typeButton3.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton3.tag = 3;
        [_typeButton3 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton3;
}
-(UIButton *)typeButton4
{
    if (_typeButton4 == nil) {
        _typeButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton4 setTitle:@"品牌宣传推广" forState:UIControlStateNormal];
        _typeButton4.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton4.layer.cornerRadius = 5.f;
        _typeButton4.layer.borderWidth = 1.f;
        _typeButton4.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton4.tag = 4;
        [_typeButton4 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton4;
}
-(UIButton *)typeButton5
{
    if (_typeButton5 == nil) {
        _typeButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton5 setTitle:@"投融资对接" forState:UIControlStateNormal];
        _typeButton5.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton5.layer.cornerRadius = 5.f;
        _typeButton5.layer.borderWidth = 1.f;
        _typeButton5.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton5.tag = 5;
        [_typeButton5 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton5;
}
-(UIButton *)typeButton6
{
    if (_typeButton6 == nil) {
        _typeButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton6 setTitle:@"IT技术支持" forState:UIControlStateNormal];
        _typeButton6.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton6.layer.cornerRadius = 5.f;
        _typeButton6.layer.borderWidth = 1.f;
        _typeButton6.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton6.tag = 6;
        [_typeButton6 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton6;
}
-(UIButton *)typeButton7
{
    if (_typeButton7 == nil) {
        _typeButton7 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton7 setTitle:@"其他" forState:UIControlStateNormal];
        _typeButton7.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
        [_typeButton7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeButton7.layer.cornerRadius = 5.f;
        _typeButton7.layer.borderWidth = 1.f;
        _typeButton7.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        _typeButton7.tag = 7;
        [_typeButton7 addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _typeButton7;
}



#pragma mark - 按钮点击事件
- (void)sureBtnClick:(UIButton *)button {
    if (button.tag == 1) {
        self.sureBtnsClick(@"人力资源服务");
    }
    if (button.tag == 2) {
        self.sureBtnsClick(@"财税会计服务");
    }
    if (button.tag == 3) {
        self.sureBtnsClick(@"法律政策咨询");
    }
    if (button.tag == 4) {
        self.sureBtnsClick(@"品牌宣传推广");
    }
    if (button.tag == 5) {
        self.sureBtnsClick(@"投融资对接");
    }
    if (button.tag == 6) {
        self.sureBtnsClick(@"IT技术支持");
    }
    if (button.tag == 7) {
        self.sureBtnsClick(@"其他");
    }
    
    [self removeView];
}

@end
