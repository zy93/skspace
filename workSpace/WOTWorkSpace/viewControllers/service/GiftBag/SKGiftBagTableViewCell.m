//
//  SKGiftBagTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/26.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKGiftBagTableViewCell.h"
#import "Masonry.h"

@interface SKGiftBagTableViewCell()
@property(nonatomic,strong)UIImageView *lineImageView;
@end

@implementation SKGiftBagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.giftBagImageView = [[UIImageView alloc] init];
        [self addSubview:self.giftBagImageView];
        
        self.giftNameLabel = [[UILabel alloc] init];
        self.giftNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.giftNameLabel.text = @"大礼包";
        [self addSubview:self.giftNameLabel];
        
        self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buyButton.backgroundColor = UICOLOR_blacK;
        self.buyButton.layer.cornerRadius = 5.f;
        
        [self.buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        self.buyButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [self.buyButton setTitleColor:UICOLOR_gold forState:UIControlStateNormal];
        [self addSubview:self.buyButton];
        
        self.giftPriceLabel = [[UILabel alloc] init];
        self.giftPriceLabel.textColor = UICOLOR_GRAY_99;
        self.giftPriceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.giftPriceLabel.text = @"¥199.00";
        [self addSubview:self.giftPriceLabel];
        
        self.lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayline"]];
        [self addSubview:self.lineImageView];
        [self imageViewLayout];
    }
    return self;
}

-(void)imageViewLayout
{
    [self.giftBagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerY.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_offset(180);
    }];
    
    [self.giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagImageView.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(15);
        make.width.mas_offset(200);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftNameLabel.mas_top);
        make.width.mas_offset(80);
        make.right.equalTo(self).with.offset(-20);
    }];
    
    [self.giftPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftNameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self).with.offset(15);
        make.width.mas_offset(200);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(self).with.offset(-15);
        make.height.mas_offset(1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
