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
#import "WOTUserSingleton.h"
#import "WOTWXPayModel.h"
#import "SKAliPayModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SKOrderStringModel.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

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

@property (nonatomic,strong)UILabel *giftBagInfoTitleLabel;

@property (nonatomic,strong)UILabel *giftBagInfoLabel;
@property (nonatomic,strong)UILabel *giftBagValidityLabel;
@property (nonatomic,strong)UILabel *giftBagValidityInfoLabel;
@property (nonatomic,strong)UILabel *giftBagValidityDetailInfoLabel;
@property (nonatomic,strong)UILabel *explainLabel;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *bottomLineView;
@property (nonatomic,strong)UILabel *paymentLabel;
@property (nonatomic,strong)UILabel *moneyNumLabel;
@property (nonatomic,strong)UIButton *payButton;
@property (nonatomic,assign)float paySumNumber;
@property (nonatomic,assign)NSInteger payNumber;
@property (nonatomic,strong)NSString *commodityDescribeStr;
@property (nonatomic,assign)NSInteger price;

@end

@implementation SKGiftBagInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.giftBagModel.giftName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.giftBagScrollView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"buttonLoseResponse" object:nil];
    [self.giftBagScrollView addSubview:self.contentView];
    
    [self.giftBagScrollView addSubview:self.giftBagImageView];
    [self.giftBagScrollView addSubview:self.giftBagInfoView];
    
    [self.giftBagInfoView addSubview:self.giftBagNameLabel];
    [self.giftBagInfoView addSubview:self.giftBagPriceLabel];
    [self.giftBagInfoView addSubview:self.lineView];
    [self.giftBagInfoView addSubview:self.voucherImageView];
    [self.giftBagInfoView addSubview:self.voucherInfoLabel];
    
    [self.giftBagScrollView addSubview:self.giftBagInfoTitleLabel];
    [self.giftBagScrollView addSubview:self.giftBagInfoLabel];
    [self.giftBagScrollView addSubview:self.giftBagValidityLabel];
    [self.giftBagScrollView addSubview:self.giftBagValidityInfoLabel];
    [self.giftBagScrollView addSubview:self.giftBagValidityDetailInfoLabel];
    [self.giftBagScrollView addSubview:self.explainLabel];
    [self.giftBagScrollView addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.bottomLineView];
    [self.bottomView addSubview:self.paymentLabel];
    [self.bottomView addSubview:self.moneyNumLabel];
    [self.bottomView addSubview:self.payButton];
//    [UILabel changeLineSpaceForLabel:_explainLabel WithSpace:10.0];
//    [UILabel changeWordSpaceForLabel:_explainLabel WithSpace:3.0];
    [self layoutSubviews];
    [self loadData];
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
        //make.top.equalTo(self.giftBagScrollView).with.offset(64);
        make.top.equalTo(self.giftBagScrollView);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(10);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-10);
        make.height.mas_offset(200);
    }];
    
    [self.giftBagInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagImageView.mas_bottom);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(15);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-15);
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
        make.left.equalTo(self.giftBagInfoView.mas_left).with.offset(20);
        make.right.equalTo(self.giftBagInfoView.mas_right).with.offset(-20);
        make.height.mas_offset(1);
    }];

    [self.voucherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagInfoView.mas_left).with.offset(20);
        make.height.mas_offset(26);
        make.width.mas_offset(40);
    }];

    [self.voucherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.voucherImageView);
        make.left.equalTo(self.voucherImageView.mas_right).with.offset(20);
    }];
    
    [self.giftBagInfoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagInfoView.mas_bottom).with.offset(5);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(20);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-20);
    }];

    [self.giftBagInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagInfoTitleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(25);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-20);
    }];
    
    [self.giftBagValidityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagInfoLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(20);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-20);
    }];
    
    [self.giftBagValidityInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagValidityLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(20);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-20);
    }];
    
    [self.giftBagValidityDetailInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagValidityInfoLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(20);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-20);
    }];

    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.giftBagValidityDetailInfoLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.giftBagScrollView.mas_left).with.offset(25);
        make.right.equalTo(self.giftBagScrollView.mas_right).with.offset(-20);
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
        make.left.equalTo(self.paymentLabel.mas_right).with.offset(10);
    }];

    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_right).with.offset(-10);
        make.width.mas_offset(100);
    }];
    
}

#pragma mark - 加载数据
-(void)loadData
{
    self.paySumNumber = [self.giftBagModel.price integerValue];
    self.commodityDescribeStr = self.giftBagModel.giftName;
}

#pragma mark - 礼包支付接口
-(void)payButtonMethod
{
    //先判断是否登录
    if (![WOTUserSingleton shareUser].userInfo.userId) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未登录" message:@"请先登录用户" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"跳转到");
            [[WOTConfigThemeUitls shared] showLoginVC:self];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
//    UIAlertController *alertController=[UIAlertController alertControllerWithTitle: nil message:message preferredStyle:UIAlertControllerStyleAlert];//创建界面
    UIAlertController *alertController = [[UIAlertController alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    UIAlertAction *wxPayAction = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self wxPayMethod];
    }];
    
    UIAlertAction *aliPayAction = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self aliPayMethod];
    }];
    //aliPayMethod
    //最后将这些按钮都添加到界面上去，显示界面
    [alertController addAction:aliPayAction];
    [alertController addAction:wxPayAction];
    [alertController addAction:cancelAction];
    [self presentViewController: alertController animated:YES completion:nil];
    
}

#pragma mark - 微信支付接口
-(void)wxPayMethod
{
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                 @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                                 @"facilitator":@"1006",
                                 @"carrieroperator":@"1006",
                                 @"body":self.commodityDescribeStr,
                                 @"trade_type":@"APP",
                                 @"commodityNum":self.giftBagModel.giftId,
                                 @"commodityName":self.giftBagModel.giftName,
                                 @"imageSite":self.giftBagModel.picture,
                                 @"commodityKind":@"礼包",
                                 @"productNum":@1,
                                 @"money":self.giftBagModel.price,//
                                 @"payType":@1,
                                 @"payObject":[WOTUserSingleton shareUser].userInfo.userName
                                 };
    //__weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork generateOrderWithParam:parameters response:^(id bean, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            WOTWXPayModel_msg *model = (WOTWXPayModel_msg *)bean;
            if ([model.code isEqualToString:@"200"]) {
                WOTWXPayModel_msg *model = (WOTWXPayModel_msg*)bean;
                [WOTHTTPNetwork wxPayWithParameter:model.msg];
            }else
            {
                [MBProgressHUDUtil showMessage:@"支付失败！" toView:self.view];
                return ;
            }
            
        });
    }];
}

#pragma mark - 支付宝支付接口
-(void)aliPayMethod
{
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                 @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                                 @"commodityName":self.giftBagModel.giftName,
                                 @"commodityKind":@"礼包",
                                 @"productNum":@1,
                                 @"commodityNum":self.giftBagModel.giftId,
                                 @"imageSite":self.giftBagModel.picture,
                                 @"money":self.giftBagModel.price,//self.paySumNumber
                                 @"payType":@1,
                                 @"payObject":[WOTUserSingleton shareUser].userInfo.userName,
                                 @"body":self.commodityDescribeStr
                                 };
    [WOTHTTPNetwork submitAlipayOrderWith:parameters response:^(id bean, NSError *error) {
        SKAliPayModel_msg *model_msg = (SKAliPayModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            SKAliPayModel *model = model_msg.msg;
            NSDictionary *parmDict = @{@"appid":AliPayAPPID,
                                       @"body":model.body,
                                       @"money":model.money,//model.money
                                       @"orderNum":model.orderNum
                                       };
            [self getOrderString:parmDict orderParam:parameters];
        }else
        {
            [MBProgressHUDUtil showMessage:@"提交失败" toView:self.view];
            return ;
        }
    }];
}

#pragma mark - 获取支付宝orderstring
-(void)getOrderString:(NSDictionary *)param orderParam:(NSDictionary *)orderParam
{
    [WOTHTTPNetwork getOrderString:param response:^(id bean, NSError *error) {
        SKOrderStringModel *model = (SKOrderStringModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            [[AlipaySDK defaultService] payOrder:model.msg fromScheme:AliPayAPPID callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut ===>= %@",resultDic);
            }];
        }else
        {
            [MBProgressHUDUtil showMessage:@"提交失败" toView:self.view];
            return ;
        }
    }];
}
#pragma mark - 实现通知方法
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"---接收到通知---");
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
        [_giftBagImageView sd_setImageWithURL:[self.giftBagModel.picture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_space"]];
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
        _giftBagNameLabel.text = self.giftBagModel.giftName;
    }
    return _giftBagNameLabel;
}

-(UILabel *)giftBagPriceLabel
{
    if (_giftBagPriceLabel == nil) {
        _giftBagPriceLabel = [[UILabel alloc] init];
        _giftBagPriceLabel.textColor = [UIColor colorWithHexString:@"ff5906"];
        _giftBagPriceLabel.text = [NSString stringWithFormat:@"¥%@",self.giftBagModel.price];
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

-(UILabel *)giftBagInfoTitleLabel
{
    if (_giftBagInfoTitleLabel == nil) {
        _giftBagInfoTitleLabel = [[UILabel alloc] init];
        _giftBagInfoTitleLabel.text = @"礼包详细信息";
        [_giftBagInfoTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    return _giftBagInfoTitleLabel;
}

-(UILabel *)giftBagInfoLabel
{
    if (_giftBagInfoLabel == nil) {
        _giftBagInfoLabel = [[UILabel alloc] init];
        NSString *giftBagInfoStr =[NSString stringWithFormat:@"%@\n",self.giftBagModel.giftInfo];
        [_giftBagInfoLabel setFont:[UIFont systemFontOfSize:14]];
        
        _giftBagInfoLabel.preferredMaxLayoutWidth = (self.view.frame.size.width -10.0 * 2);
        [_giftBagInfoLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _giftBagInfoLabel.numberOfLines =0;
        NSDictionary *dic = @{NSKernAttributeName:@1.f
                              
                              };
        
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:giftBagInfoStr attributes:dic];
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:8];//行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [giftBagInfoStr length])];
        
        [_giftBagInfoLabel setAttributedText:attributedString];
    }
    return _giftBagInfoLabel;
}

-(UILabel *)giftBagValidityLabel
{
    if (_giftBagValidityLabel == nil) {
        _giftBagValidityLabel = [[UILabel alloc] init];
        _giftBagValidityLabel.text = @"礼包有效期";
        [_giftBagValidityLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    return _giftBagValidityLabel;
}

-(UILabel *)giftBagValidityInfoLabel
{
    if (_giftBagValidityInfoLabel == nil) {
        _giftBagValidityInfoLabel = [[UILabel alloc] init];
        [_giftBagValidityInfoLabel setFont:[UIFont systemFontOfSize:14]];
        [_giftBagValidityInfoLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _giftBagValidityInfoLabel.numberOfLines =0;
        NSString *giftBagInfo = [NSString stringWithFormat:@"  %@",self.giftBagModel.giftValidity];
        _giftBagValidityInfoLabel.text = giftBagInfo;
    }
    return _giftBagValidityInfoLabel;
}

-(UILabel *)giftBagValidityDetailInfoLabel
{
    if (_giftBagValidityDetailInfoLabel == nil) {
        _giftBagValidityDetailInfoLabel = [[UILabel alloc] init];
        _giftBagValidityDetailInfoLabel.text = @"礼包使用说明";
        [_giftBagValidityDetailInfoLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    return _giftBagValidityDetailInfoLabel;
}

-(UILabel *)explainLabel
{
    if (_explainLabel == nil) {
        _explainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        NSString *explainLabelStr =[NSString stringWithFormat:@"%@\n",self.giftBagModel.giftExplain];
        [_explainLabel setFont:[UIFont systemFontOfSize:14]];
        
        _explainLabel.preferredMaxLayoutWidth = (self.view.frame.size.width -10.0 * 2);
        [_explainLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _explainLabel.numberOfLines =0;
        NSDictionary *dic = @{NSKernAttributeName:@1.f

                              };

        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:explainLabelStr attributes:dic];

        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];

        [paragraphStyle setLineSpacing:8];//行间距

        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [explainLabelStr length])];

        [_explainLabel setAttributedText:attributedString];
        
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
        _moneyNumLabel.text = [NSString stringWithFormat:@"¥%@",self.giftBagModel.price];

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
        [_payButton addTarget:self action:@selector(payButtonMethod) forControlEvents:UIControlEventTouchDown];
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

-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buttonLoseResponse" object:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
