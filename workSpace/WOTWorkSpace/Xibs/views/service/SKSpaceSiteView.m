//
//  SKSpaceSiteView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKSpaceSiteView.h"
@interface SKSpaceSiteView()
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UIView *spaceInfolineView;
@end

@implementation SKSpaceSiteView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.imageView];
    [self addSubview:self.numLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.spaceInfolineView];
    [self layoutSubviews];
}

-(void)setDataWith:(NSString *)numString  moneyString:(NSString *)moneyString imageUrl:(NSURL *)imageUrl
{
    _numLabel.text = numString;
    _moneyLabel.text = moneyString;
    [_imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

-(void)layoutSubviews
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self);
        make.width.mas_offset(100);
        make.height.mas_offset(80);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.left.equalTo(self.imageView.mas_right).with.offset(10);
        make.width.mas_offset(110);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_top);
        make.left.equalTo(self.nameLabel.mas_right).with.offset(20);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.nameLabel.mas_left);
    }];
    
    [self.spaceInfolineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
        make.height.mas_offset(1);
    }];
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = self.nameString;
    }
    return _nameLabel;
}

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView sd_setImageWithURL:self.imageUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    return _imageView;
}

-(UILabel *)numLabel
{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.text = self.numString;
    }
    return _numLabel;
}

-(UILabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = self.moneyString;
    }
    return _moneyLabel;
}
-(UIView *)spaceInfolineView
{
    if (_spaceInfolineView == nil) {
        _spaceInfolineView = [[UIView alloc] init];
        _spaceInfolineView.backgroundColor = UICOLOR_MAIN_LINE;
    }
    return _spaceInfolineView;
}

@end
