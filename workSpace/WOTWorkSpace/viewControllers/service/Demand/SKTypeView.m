//
//  SKTypeView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKTypeView.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
@interface SKTypeView()

@property(nonatomic, weak) UIView *contentView;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;
@property(nonatomic,strong)UIButton *button4;
@property(nonatomic,strong)UIButton *button5;
@property(nonatomic,strong)UIButton *button6;
@property(nonatomic,strong)UIButton *button7;
@end

@implementation SKTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
        self.backgroundColor = [UIColor whiteColor];
        [self setupBasicView];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.button1];
        [self.contentView addSubview:self.button2];
        [self.contentView addSubview:self.button3];
        [self.contentView addSubview:self.button4];
        [self.contentView addSubview:self.button5];
        [self.contentView addSubview:self.button6];
        [self.contentView addSubview:self.button7];
    }
    return self;
}

-(void)layoutSubviews
{
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
    }];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button1.mas_top);
        make.left.equalTo(self.button1.mas_right).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button1.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button3.mas_top);
        make.left.equalTo(self.button3.mas_right).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button3.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button5.mas_top);
        make.left.equalTo(self.button5.mas_right).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button5.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.width.mas_offset(100);
    }];
    
}

/**
 *  设置视图的基本内容
 */
- (void)setupBasicView {
    // 添加手势，点击背景视图消失
    /** 使用的时候注意名字不能用错，害我定格了几天才发现。FK
     UIGestureRecognizer
     UITapGestureRecognizer // 点击手势
     UISwipeGestureRecognizer // 轻扫手势
     */
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tapBackGesture];
    
    UIView *contentView = [[UIView alloc] initWithFrame:(CGRect){kScreenW/2,0, kScreenW, kATTR_VIEW_HEIGHT}];
    contentView.backgroundColor = [UIColor whiteColor];
    // 添加手势，遮盖整个视图的手势，
    UITapGestureRecognizer *contentViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [contentView addGestureRecognizer:contentViewTapGesture];
    [self addSubview:contentView];
    self.contentView = contentView;
}

#pragma mark - 显示视图
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(kScreenW, 0, 0, kScreenH);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(kScreenW/4, 0, kScreenW, kScreenH);
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

#pragma mark - 点击方法
-(void)clickButtonMethod:(UIButton *)button
{
    self.sureBtnsClick(demandTypeList[button.tag-1000]);
    [self removeView];
}

-(UILabel *)typeLabel
{
    if (_typeLabel == nil) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.text = @"支持类型";
    }
    return _typeLabel;
}

-(UIButton *)button1
{
    if (_button1 == nil) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:demandTypeList[0] forState:UIControlStateNormal];
        [_button1 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button1.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button1.tag = 1000;
        _button1.layer.cornerRadius = 5.f;
        _button1.layer.borderWidth = 1.f;
        _button1.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button1 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button1;
}

-(UIButton *)button2
{
    if (_button2 == nil) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:demandTypeList[1] forState:UIControlStateNormal];
        [_button2 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button2.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button2.tag = 1001;
        _button2.layer.cornerRadius = 5.f;
        _button2.layer.borderWidth = 1.f;
        _button2.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button2 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button2;
}

-(UIButton *)button3
{
    if (_button3 == nil) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitle:demandTypeList[2] forState:UIControlStateNormal];
        [_button3 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button3.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button3.tag = 1002;
        _button3.layer.cornerRadius = 5.f;
        _button3.layer.borderWidth = 1.f;
        _button3.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button3 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button3;
}

-(UIButton *)button4
{
    if (_button4 == nil) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setTitle:demandTypeList[3] forState:UIControlStateNormal];
        [_button4 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button4.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button4.tag = 1003;
        _button4.layer.cornerRadius = 5.f;
        _button4.layer.borderWidth = 1.f;
        _button4.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button4 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button4;
}

-(UIButton *)button5
{
    if (_button5 == nil) {
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button5 setTitle:demandTypeList[4] forState:UIControlStateNormal];
        [_button5 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button5.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button5.tag = 1004;
        _button5.layer.cornerRadius = 5.f;
        _button5.layer.borderWidth = 1.f;
        _button5.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button5 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button5;
}

-(UIButton *)button6
{
    if (_button6 == nil) {
        _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button6 setTitle:demandTypeList[5] forState:UIControlStateNormal];
        [_button6 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button6.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button6.tag = 1005;
        _button6.layer.cornerRadius = 5.f;
        _button6.layer.borderWidth = 1.f;
        _button6.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button6 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button6;
}

-(UIButton *)button7
{
    if (_button7 == nil) {
        _button7 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button7 setTitle:demandTypeList[6] forState:UIControlStateNormal];
        [_button7 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal] ;
        _button7.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _button7.tag = 1006;
        _button7.layer.cornerRadius = 5.f;
        _button7.layer.borderWidth = 1.f;
        _button7.layer.borderColor = [UIColor colorWithHexString:@"dddddd"].CGColor;
        [_button7 addTarget:self action:@selector(clickButtonMethod:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _button7;
}






@end
