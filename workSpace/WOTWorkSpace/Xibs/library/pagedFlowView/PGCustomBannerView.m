//
//  PGCustomBannerView.m
//  NewPagedFlowViewDemo
//
//  Created by Guo on 2017/8/24.
//  Copyright © 2017年 robertcell.net. All rights reserved.
//

#import "PGCustomBannerView.h"
#import "Masonry.h"

@interface PGCustomBannerView ()
@property(nonatomic,strong)UIView *floorView;
@end

@implementation PGCustomBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.floorView];
        [self.floorView addSubview:self.indexLabel];
        [self.floorView addSubview:self.spaceCityLabel];
        [self.floorView addSubview:self.numberLabel];
    }
    
    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {

    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = self.bounds;
    self.coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
//    self.indexLabel.frame = CGRectMake(0,0, superViewBounds.size.width, superViewBounds.size.height);
    [self subViewLayout];
}

-(void)subViewLayout
{
    [self.floorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.spaceCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floorView);
        make.width.equalTo(self.floorView);
        make.bottom.equalTo(self.indexLabel.mas_top);
    }];
    
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.floorView);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floorView);
        make.width.equalTo(self.floorView);
        make.top.equalTo(self.indexLabel.mas_bottom);
    }];
}

- (UILabel *)indexLabel {
    if (_indexLabel == nil) {
        _indexLabel = [[UILabel alloc] init];
        //_indexLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _indexLabel.font = [UIFont systemFontOfSize:25.0];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.textColor = [UIColor whiteColor];
    }
    return _indexLabel;
}

- (UILabel *)spaceCityLabel {
    if (_spaceCityLabel == nil) {
        _spaceCityLabel = [[UILabel alloc] init];
        //_spaceCityLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _spaceCityLabel.font = [UIFont systemFontOfSize:20.0];
        _spaceCityLabel.textAlignment = NSTextAlignmentCenter;
        _spaceCityLabel.textColor = [UIColor whiteColor];
    }
    return _spaceCityLabel;
}

- (UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        //_numberLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _numberLabel.font = [UIFont systemFontOfSize:15.0];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor whiteColor];
    }
    return _numberLabel;
}

-(UIView *)floorView
{
    if (_floorView == nil) {
        _floorView = [[UIView alloc] init];
        _floorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
    return _floorView;
}

@end
