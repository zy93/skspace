//
//  SKTtileView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKTtileView.h"

@interface SKTtileView()
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation SKTtileView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightImageView];
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.titleLabel.mas_left).with.offset(-5);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(5);
    }];
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = self.titleString;
    }
    return _titleLabel;
}

-(UIImageView *)leftImageView
{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"leftImage"];
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"rightImage"];
    }
    return _rightImageView;
}
@end
