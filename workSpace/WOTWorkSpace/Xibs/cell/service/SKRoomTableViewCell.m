//
//  SKRoomTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKRoomTableViewCell.h"

@interface SKRoomTableViewCell()


@property(nonatomic,strong)UIImageView *lineImageView;
@end

@implementation SKRoomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.roomImageView];
        [self.contentView addSubview:self.roomNameLabel];
        [self.contentView addSubview:self.bookStationNumLabel];
        [self.contentView addSubview:self.bookStationInfoNumLabel];
        [self.contentView addSubview:self.nowPriceLabel];
        [self.contentView addSubview:self.formerlyPriceLabel];
        [self.contentView addSubview:self.lineImageView];
        [self layoutSubviews];
    }
    return self;
}

-(void)layoutSubviews
{
    [self.roomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.bottom.equalTo(self).with.offset(-20);
        make.left.equalTo(self).with.offset(10);
        make.width.mas_offset(140);
    }];
    
    [self.roomNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(30);
        make.right.equalTo(self).with.offset(-10);
        make.left.equalTo(self.roomImageView.mas_right).with.offset(10);
    }];
    
    [self.bookStationNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomNameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.roomImageView.mas_right).with.offset(10);
        make.width.mas_offset(90);
    }];
    
    [self.bookStationInfoNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomNameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.bookStationNumLabel.mas_right);
        make.right.equalTo(self).with.offset(-10);
    }];
    
    [self.nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookStationNumLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.roomImageView.mas_right).with.offset(10);
        make.width.mas_offset(80);
    }];
    
    [self.formerlyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookStationNumLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.nowPriceLabel.mas_right).with.offset(5);
        make.right.equalTo(self).with.offset(-10);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
        make.height.mas_offset(0.5);
    }];
}

-(UIImageView *)roomImageView
{
    if (_roomImageView == nil) {
        _roomImageView = [[UIImageView alloc] init];
        _roomImageView.image = [UIImage imageNamed:@"GiftBag1"];
    }
    return _roomImageView;
}

-(UILabel *)roomNameLabel
{
    if (_roomNameLabel == nil) {
        _roomNameLabel = [[UILabel alloc] init];
        _roomNameLabel.text = @"西区-301";
    }
    return _roomNameLabel;
}

-(UILabel *)bookStationNumLabel
{
    if (_bookStationNumLabel == nil) {
        _bookStationNumLabel = [[UILabel alloc] init];
        _bookStationNumLabel.textColor = UICOLOR_GRAY_66;
        _bookStationNumLabel.text = @"工位数量：";
    }
    return _bookStationNumLabel;
}

-(UILabel *)bookStationInfoNumLabel
{
    if (_bookStationInfoNumLabel == nil) {
        _bookStationInfoNumLabel = [[UILabel alloc] init];
        _bookStationInfoNumLabel.textColor = UICOLOR_GRAY_66;
        _bookStationInfoNumLabel.text = @"66/位";
    }
    return _bookStationInfoNumLabel;
}

-(UILabel *)nowPriceLabel
{
    if (_nowPriceLabel == nil) {
        _nowPriceLabel = [[UILabel alloc] init];
        _nowPriceLabel.textColor = UICOLOR_MAIN_ORANGE;
        _nowPriceLabel.text = @"¥80";
    }
    return _nowPriceLabel;
}

-(UILabel *)formerlyPriceLabel
{
    if (_formerlyPriceLabel == nil) {
        _formerlyPriceLabel = [[UILabel alloc] init];
        NSString *price = @"¥100";
        NSAttributedString *attrStr =
        [[NSAttributedString alloc]initWithString:price
                                      attributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
    NSForegroundColorAttributeName:UICOLOR_GRAY_66,
    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    NSStrikethroughColorAttributeName:UICOLOR_GRAY_66}];
        _formerlyPriceLabel.attributedText = attrStr;
    }
    return _formerlyPriceLabel;
}

-(UIImageView *)lineImageView
{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayline"]];
    }
    return _lineImageView;
}

@end
