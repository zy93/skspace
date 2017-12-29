//
//  SKGiftBagInfoViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/26.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKGiftBagInfoViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"

@interface SKGiftBagInfoViewController ()
@property (nonatomic,strong)UIScrollView *giftBagScrollView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIImageView *giftBagImageView;

@property (nonatomic,strong)UIView *giftBagInfoView;
@property (nonatomic,strong)UILabel *giftBagNameLabel;
@property (nonatomic,strong)UILabel *giftBagPriceLabel;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIImageView *voucherImageView;
@property (nonatomic,strong)UILabel *voucherInfoLabel;

@property (nonatomic,strong)UILabel *giftBagInfoLabel;
@property (nonatomic,strong)UILabel *explainLabel;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *bottomLineView;
@property (nonatomic,strong)UILabel *paymentLabel;
@property (nonatomic,strong)UILabel *moneyNumLabel;
@property (nonatomic,strong)UIButton *payButton;

@end

@implementation SKGiftBagInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.giftBagScrollView];
    
    [self.giftBagScrollView addSubview:self.contentView];
    
    [self.giftBagScrollView addSubview:self.giftBagImageView];
    [self.giftBagScrollView addSubview:self.giftBagInfoView];
    
    [self.giftBagInfoView addSubview:self.giftBagNameLabel];
    [self.giftBagInfoView addSubview:self.giftBagPriceLabel];
    [self.giftBagInfoView addSubview:self.lineView];
    [self.giftBagInfoView addSubview:self.voucherImageView];
    [self.giftBagInfoView addSubview:self.voucherInfoLabel];
    
    [self.giftBagScrollView addSubview:self.giftBagInfoLabel];
    [self.giftBagScrollView addSubview:self.explainLabel];
    [self.giftBagScrollView addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.bottomLineView];
    [self.bottomView addSubview:self.paymentLabel];
    [self.bottomView addSubview:self.moneyNumLabel];
    [self.bottomView addSubview:self.payButton];
    
    [self layoutSubviews];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - 添加约束
-(void)layoutSubviews
{
    [self.giftBagScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.giftBagScrollView);
        make.width.equalTo(self.giftBagScrollView);
    }];
    
    [self.giftBagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagScrollView).with.offset(64);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(10);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-10);
        make.height.mas_offset(200);
    }];
    
    [self.giftBagInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagImageView.mas_bottom);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(10);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-10);
        make.height.equalTo(@100);
    }];

    [self.giftBagNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagInfoView).with.offset(5);
        make.left.equalTo(self.giftBagInfoView).with.offset(5);
    }];

    [self.giftBagPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagNameLabel.mas_top);
        make.right.equalTo(self.giftBagInfoView).with.offset(-10);
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagNameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.giftBagInfoView.mas_left).with.offset(10);
        make.right.equalTo(self.giftBagInfoView.mas_right).with.offset(-10);
        make.height.mas_offset(1);
    }];

    [self.voucherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagInfoView.mas_left).with.offset(10);
        make.height.mas_offset(26);
        make.width.mas_offset(40);
    }];

    [self.voucherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.voucherImageView);
        make.left.equalTo(self.voucherImageView.mas_right).with.offset(10);
    }];

    [self.giftBagInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagInfoView.mas_bottom).with.offset(5);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(5);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-5);
    }];

    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagInfoLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(5);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-5);
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.explainLabel.mas_bottom);
        make.left.equalTo(self.giftBagScrollView.mas_left);
        make.right.equalTo(self.giftBagScrollView.mas_right);
        make.height.mas_offset(48);
    }];

    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.height.mas_offset(1);
    }];

    [self.paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView.mas_left).with.offset(10);
    }];

    [self.moneyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.paymentLabel);
        make.left.equalTo(self.paymentLabel.mas_right).with.offset(5);
    }];

    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_right).with.offset(-10);
        make.width.mas_offset(100);
    }];
    
}

-(UIScrollView *)giftBagScrollView
{
    if (_giftBagScrollView == nil) {
        _giftBagScrollView = [[UIScrollView alloc] init];
        //_giftBagScrollView.contentOffset.x = 0.0;
        CGSize scrollableSize = CGSizeMake(_giftBagScrollView.frame.size.width,_giftBagScrollView.size.height);
        [_giftBagScrollView setContentSize:scrollableSize];
    }
    return _giftBagScrollView;
}

-(UIImageView *)giftBagImageView
{
    if (_giftBagImageView == nil) {
        _giftBagImageView = [[UIImageView alloc] init];
        [_giftBagImageView setImage:[UIImage imageNamed:self.giftBagNameStr]];
    }
    return _giftBagImageView;
}

-(UIView *)giftBagInfoView
{
    if (_giftBagInfoView == nil) {
        _giftBagInfoView = [[UIView alloc] init];
        [_giftBagInfoView setBackgroundColor:[UIColor colorWithHexString:@"f9f9f9"]];
    }
    return _giftBagInfoView;
}

-(UILabel *)giftBagNameLabel
{
    if (_giftBagNameLabel == nil) {
        _giftBagNameLabel = [[UILabel alloc] init];
        if ([self.giftBagNameStr isEqualToString:@"GiftBag1"]) {
            _giftBagNameLabel.text = @"礼包一（尝鲜包）";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag2"]) {
            _giftBagNameLabel.text = @"礼包二";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag3"]) {
            _giftBagNameLabel.text = @"礼包三";
        }
    }
    return _giftBagNameLabel;
}

-(UILabel *)giftBagPriceLabel
{
    if (_giftBagPriceLabel == nil) {
        _giftBagPriceLabel = [[UILabel alloc] init];
        _giftBagPriceLabel.textColor = [UIColor colorWithHexString:@"ff5906"];
        if ([self.giftBagNameStr isEqualToString:@"GiftBag1"]) {
            _giftBagPriceLabel.text = @"¥888.00";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag2"]) {
            _giftBagPriceLabel.text = @"¥1688.00";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag3"]) {
            _giftBagPriceLabel.text = @"¥2999.00";
        }
    }
    return _giftBagPriceLabel;
}

-(UIView *)lineView
{
    if (_lineView == nil ) {
        _lineView = [[UIView alloc] init];
        [_lineView setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    }
    return _lineView;
}

-(UIImageView *)voucherImageView
{
    if (_voucherImageView == nil) {
        _voucherImageView = [[UIImageView alloc] init];
        [_voucherImageView setImage:[UIImage imageNamed:@"GiftBagInfo"]];
    }
    return _voucherImageView;
}

-(UILabel *)voucherInfoLabel
{
    if (_voucherInfoLabel == nil) {
        _voucherInfoLabel = [[UILabel alloc] init];
        _voucherInfoLabel.text = @"指定空间可用";
    }
    return _voucherInfoLabel;
}

-(UILabel *)giftBagInfoLabel
{
    if (_giftBagInfoLabel == nil) {
        _giftBagInfoLabel = [[UILabel alloc] init];
        [_giftBagInfoLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _giftBagInfoLabel.numberOfLines =0;
        NSString *giftBagInfoStr;
        if ([self.giftBagNameStr isEqualToString:@"GiftBag1"]) {
            giftBagInfoStr = @"礼包详细信息：\n\n  工位：    128小时\n\n  会议室：5小时";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag2"]) {
            giftBagInfoStr = @"礼包详细信息：\n 工位：    200小时\n  会议室：10小时";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag3"]) {
            giftBagInfoStr = @"礼包详细信息：\n  工位：    400小时\n  会议室：15小时";
        }
        _giftBagInfoLabel.text = giftBagInfoStr;
    }
    return _giftBagInfoLabel;
}

-(UILabel *)explainLabel
{
    if (_explainLabel == nil) {
        _explainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _explainLabel.preferredMaxLayoutWidth = (self.view.frame.size.width -10.0 * 2);
        [_explainLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _explainLabel.numberOfLines =0;
        NSString *explainLabelStr = @"企业工位代金券使用说明：\n\n1. 使用范围：优客工场全国任意社区；\n\n2. 限制条件：此工位代金券仅限订购优客工场中的开放工位；\n\n3. 有效期：每次购买礼包时，所获得的代金券有效期均为从使用礼包后起3个月内；\n\n4. 使用方法：通过优客工场web网站，app预定工位时，结算流程中选择“企业支付”，并选择有该代金券的企业账户，选中代金券，即可抵扣现金使用；\n\n5. 使用说明：工位预订单次消费不限代金券使用数量，直至订单金额抵扣为0元，如代金券抵扣金额超过实际金额，扣除的整张代金券不予找零；\n\n6. 过期说明：代金券超过有效截止日期之后，将无法使用，并不予返赠，请优先使用即将过期的代金券。";
        _explainLabel.text = explainLabelStr;
    }
    return _explainLabel;
}

-(UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

-(UILabel *)paymentLabel
{
    if (_paymentLabel == nil) {
        _paymentLabel = [[UILabel alloc] init];
        _paymentLabel.text = @"实付：";
    }
    return _paymentLabel;
}

-(UILabel *)moneyNumLabel
{
    if (_moneyNumLabel == nil) {
        _moneyNumLabel = [[UILabel alloc] init];
        if ([self.giftBagNameStr isEqualToString:@"GiftBag1"]) {
            _moneyNumLabel.text = @"¥888.00";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag2"]) {
            _moneyNumLabel.text = @"¥1688.00";
        }
        if ([self.giftBagNameStr isEqualToString:@"GiftBag3"]) {
            _moneyNumLabel.text = @"¥2999.00";
        }
    }
    return _moneyNumLabel;
}

-(UIButton *)payButton
{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"支付" forState:UIControlStateNormal];
        [_payButton setBackgroundColor:[UIColor colorWithHexString:@"ff5906"]];
        _payButton.layer.cornerRadius = 5.f;
        _payButton.layer.borderWidth = 1.f;
        _payButton.layer.borderColor = [UIColor colorWithHexString:@"ff5906"].CGColor;
    }
    return _payButton;
}

-(UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        [_bottomLineView setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    }
    return _bottomLineView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}



@end
