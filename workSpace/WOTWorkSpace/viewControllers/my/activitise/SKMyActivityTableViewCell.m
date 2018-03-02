//
//  SKMyActivityTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKMyActivityTableViewCell.h"

@interface SKMyActivityTableViewCell()

@property(nonatomic,strong)UIView *floorView;

@end


@implementation SKMyActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.floorView];
        [self.floorView addSubview:self.myActivityImageView];
        [self.floorView addSubview:self.infoLabel];
        [self.floorView addSubview:self.spaceNameLabel];
        [self.floorView addSubview:self.startTimeLabel];
        [self layoutSubviews];
    }
    return self;
}

-(void)layoutSubviews
{
    [self.floorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.bottom.equalTo(self);
    }];
    
    [self.myActivityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.floorView);
        make.left.equalTo(self.floorView);
        make.right.equalTo(self.floorView);
        make.height.mas_offset(200);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myActivityImageView.mas_bottom).with.offset(5);
        make.left.equalTo(self.floorView).with.offset(5);
    }];
    
    [self.spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.floorView).with.offset(5);
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).with.offset(5);
        make.right.equalTo(self.floorView).with.offset(-10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(UIView *)floorView
{
    if (_floorView == nil) {
        _floorView = [[UIView alloc] init];
        _floorView.backgroundColor = [UIColor whiteColor];
        _floorView.layer.shadowOpacity = 0.5;// 阴影透明度
        _floorView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        _floorView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        _floorView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    }
    return _floorView;
}

-(UIImageView *)myActivityImageView
{
    if (_myActivityImageView == nil) {
        _myActivityImageView = [[UIImageView alloc] init];
    }
    return _myActivityImageView;
}

-(UILabel *)infoLabel
{
    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        [_infoLabel setFont:[UIFont systemFontOfSize:20]];
    }
    return _infoLabel;
}

-(UILabel *)spaceNameLabel
{
    if (_spaceNameLabel == nil) {
        _spaceNameLabel = [[UILabel alloc] init];
    }
    return _spaceNameLabel;
}

-(UILabel *)startTimeLabel
{
    if (_startTimeLabel==nil) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.textColor = [UIColor grayColor];
    }
    return _startTimeLabel;
}

@end
