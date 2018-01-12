//
//  StationOrderInfoViewController.m
//  LoginDemo
//
//  Created by wangxiaodong on 2017/12/4.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//
//工位支付详情页

#import "StationOrderInfoViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "WOTSingtleton.h"

@interface StationOrderInfoViewController ()
@property (nonatomic, strong)UIScrollView *bookStationScrollView;
@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong) UIView *orderNumView;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *orderNumInfoLabel;

@property (nonatomic, strong) UIView *bookSiteView;
@property (nonatomic, strong) UILabel *bookSiteLabel;
@property (nonatomic, strong) UILabel *bookSiteInfoLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *startTimeInfoLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *endTimeInfoLabel;
@property (nonatomic, strong) UILabel *bookNumLabel;
@property (nonatomic, strong) UILabel *bookNumInfoLabel;

@property (nonatomic, strong) UIView *facilityView;
@property (nonatomic, strong) UILabel *facilityLabel;
@property (nonatomic, strong) UILabel *facilityInfoLabel;

@property (nonatomic, strong) UIView *payTypeView;
@property (nonatomic, strong) UILabel *payTypeLabel;
@property (nonatomic, strong) UILabel *payTypeInfoLabel;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UILabel *sumInfoLabel;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *orderTimeInfoLabel;

@property (nonatomic, strong) UILabel *attentionLabel;
@property (nonatomic, strong) UILabel *attentionInfoLabel;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *actuallyPaidLabel;
@property (nonatomic, strong) UILabel *actuallyPaidMoneyLabel;
@property (nonatomic, strong) UIButton *orderPayButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation StationOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bookStationScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.bookStationScrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"确认订单";
    
    self.contentView = [UIView new];
    [self.bookStationScrollView addSubview:self.contentView];
    
    self.orderNumView = [UIView new];
    self.orderNumView.layer.shadowOpacity = 0.5;// 阴影透明度
    self.orderNumView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.orderNumView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    self.orderNumView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    self.orderNumView.layer.cornerRadius = 5.f;
    self.orderNumView.layer.borderWidth = 1.f;
    self.orderNumView.layer.borderColor = [UIColor colorWithHexString:@"#f9f9f9"].CGColor;
    self.orderNumView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.bookStationScrollView addSubview:self.orderNumView];
    
    self.orderNumLabel = [[UILabel alloc] init];
    self.orderNumLabel.text = @"订单编号：";
    [self.orderNumView addSubview:self.orderNumLabel];
    
    self.orderNumInfoLabel = [[UILabel alloc] init];
    self.orderNumInfoLabel.text = @"123456789";
    [self.orderNumView addSubview:self.orderNumInfoLabel];
    
    
    self.bookSiteView = [UIView new];
    self.bookSiteView.layer.shadowOpacity = 0.5;// 阴影透明度
    self.bookSiteView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.bookSiteView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    self.bookSiteView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    self.bookSiteView.layer.cornerRadius = 5.f;
    self.bookSiteView.layer.borderWidth = 1.f;
    self.bookSiteView.layer.borderColor = [UIColor colorWithHexString:@"#f9f9f9"].CGColor;
    self.bookSiteView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.bookStationScrollView addSubview:self.bookSiteView];
    
    self.bookSiteLabel = [[UILabel alloc] init];
    self.bookSiteLabel.text = @"预约场地：";
    [self.bookSiteView addSubview:self.bookSiteLabel];
    
    self.bookSiteInfoLabel = [[UILabel alloc] init];
    self.bookSiteInfoLabel.text = @"方圆大厦优客工场A层";
    [self.bookSiteView addSubview:self.bookSiteInfoLabel];
    
    self.startTimeLabel = [[UILabel alloc] init];
    self.startTimeLabel.text = @"开始时间：";
    [self.bookSiteView addSubview:self.startTimeLabel];
    
    self.startTimeInfoLabel = [[UILabel alloc] init];
    self.startTimeInfoLabel.text = @"2017-12-01";
    [self.bookSiteView addSubview:self.startTimeInfoLabel];
    
    self.endTimeLabel = [[UILabel alloc] init];
    self.endTimeLabel.text = @"结束时间：";
    [self.bookSiteView addSubview:self.endTimeLabel];
    
    self.endTimeInfoLabel = [[UILabel alloc] init];
    self.endTimeInfoLabel.text = @"2017-12-02";
    [self.bookSiteView addSubview:self.endTimeInfoLabel];
    
    self.bookNumLabel = [[UILabel alloc] init];
    self.bookNumLabel.text = @"预定数量：";
    [self.bookSiteView addSubview:self.bookNumLabel];
    
    self.bookNumInfoLabel = [[UILabel alloc] init];
    self.bookNumInfoLabel.text = @"200";
    [self.bookSiteView addSubview:self.bookNumInfoLabel];
    
    
    self.facilityView = [UIView new];
    self.facilityView.layer.shadowOpacity = 0.5;// 阴影透明度
    self.facilityView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.facilityView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    self.facilityView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    self.facilityView.layer.cornerRadius = 5.f;
    self.facilityView.layer.borderWidth = 1.f;
    self.facilityView.layer.borderColor = [UIColor colorWithHexString:@"#f9f9f9"].CGColor;
    self.facilityView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.bookStationScrollView addSubview:self.facilityView];
    
    self.facilityLabel = [[UILabel alloc] init];
    self.facilityLabel.text = @"配套设施：";
    [self.facilityView addSubview:self.facilityLabel];
    
    self.facilityInfoLabel = [[UILabel alloc] init];
    self.facilityInfoLabel.text = @"wifi、储物箱、纯净水";
    [self.facilityView addSubview:self.facilityInfoLabel];
    
    self.payTypeView = [UIView new];
    self.payTypeView.layer.shadowOpacity = 0.5;// 阴影透明度
    self.payTypeView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.payTypeView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    self.payTypeView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    self.payTypeView.layer.cornerRadius = 5.f;
    self.payTypeView.layer.borderWidth = 1.f;
    self.payTypeView.layer.borderColor = [UIColor colorWithHexString:@"#f9f9f9"].CGColor;
    self.payTypeView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.bookStationScrollView addSubview:self.payTypeView];
    
    self.payTypeLabel = [[UILabel alloc] init];
    self.payTypeLabel.text = @"支付类型：";
    [self.payTypeView addSubview:self.payTypeLabel];
    
    self.payTypeInfoLabel = [[UILabel alloc] init];
    self.payTypeInfoLabel.text = @"个人支付";
    [self.payTypeView addSubview:self.payTypeInfoLabel];
    
    self.sumLabel = [[UILabel alloc] init];
    self.sumLabel.text = @"总金额：";
    [self.payTypeView addSubview:self.sumLabel];
    
    self.sumInfoLabel = [[UILabel alloc] init];
    self.sumInfoLabel.text = @"200元";
    [self.payTypeView addSubview:self.sumInfoLabel];
    
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.text = @"下单时间：";
    [self.payTypeView addSubview:self.orderTimeLabel];
    
    self.orderTimeInfoLabel = [[UILabel alloc] init];
    self.orderTimeInfoLabel.text = @"2017-11-29";
    [self.payTypeView addSubview:self.orderTimeInfoLabel];
    
    self.attentionLabel = [[UILabel alloc] init];
    self.attentionLabel.text = @"注：";
    self.attentionLabel.textColor = [UIColor colorWithHexString:@"#ff7d3d"];
    [self.bookStationScrollView addSubview:self.attentionLabel];
    
    self.attentionInfoLabel = [[UILabel alloc] init];
    self.attentionInfoLabel.text = @" 您将被安排在优客工场A层 \n 请携带有效身份证件在前台办理进场 \n 您也可以在预定前一天23：59前取消订单";
    self.attentionInfoLabel.numberOfLines = 0;
    self.attentionInfoLabel.font = [UIFont systemFontOfSize:13.0];
    self.attentionInfoLabel.textColor = [UIColor grayColor];
    [self.bookStationScrollView addSubview:self.attentionInfoLabel];
    
    self.bottomView = [UIView new];
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_SITE) {
        self.bottomView.hidden = NO;
    } else {
        self.bottomView.hidden = YES;
    }
    [self.view addSubview:self.bottomView];
    
    self.actuallyPaidLabel = [[UILabel alloc] init];
    self.actuallyPaidLabel.text = @"实付：";
    [self.bottomView addSubview:self.actuallyPaidLabel];
    
    self.actuallyPaidMoneyLabel = [[UILabel alloc] init];
    self.actuallyPaidMoneyLabel.text  = @"¥200.00";
    [self.bottomView addSubview:self.actuallyPaidMoneyLabel];
    
    self.orderPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderPayButton.layer.cornerRadius = 5.f;
    self.orderPayButton.layer.borderWidth = 1.f;
    self.orderPayButton.layer.borderColor = [UIColor colorWithHexString:@"#00a910"].CGColor;
    [self.orderPayButton setTitle:@"支付" forState: UIControlStateNormal];
    [self.orderPayButton addTarget:self action:@selector(stationPayMethod) forControlEvents:UIControlEventTouchDown];
    [self.orderPayButton setBackgroundColor:[UIColor colorWithHexString:@"#00a910"]];
    [self.bottomView addSubview:self.orderPayButton];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.bottomView addSubview:self.lineView];
    [self updateView];
}

-(void)viewDidLayoutSubviews
{
    [self.bookStationScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bookStationScrollView);
        make.width.height.equalTo(self.bookStationScrollView);
    }];
    
    [self.orderNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookStationScrollView.mas_top).with.offset(10);
        make.left.equalTo(self.bookStationScrollView.mas_left).with.offset(20);
        make.right.equalTo(self.bookStationScrollView.mas_right).with.offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderNumView);
        make.left.equalTo(self.orderNumView).with.offset(5);
    }];
    
    [self.orderNumInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderNumLabel);
        make.left.equalTo(self.orderNumLabel.mas_right);
    }];
    
    [self.bookSiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumView.mas_bottom).with.offset(25);
        make.left.equalTo(self.bookStationScrollView).with.offset(20);
        make.right.equalTo(self.bookStationScrollView).with.offset(-20);
        make.height.mas_equalTo(130);
    }];
    
    [self.bookSiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookSiteView.mas_top).with.offset(10);
        make.left.equalTo(self.bookSiteView.mas_left).with.offset(5);
    }];
    
    [self.bookSiteInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookSiteLabel.mas_top);
        make.left.equalTo(self.bookSiteLabel.mas_right);
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookSiteLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.bookSiteView.mas_left).with.offset(5);
    }];
    
    [self.startTimeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTimeLabel.mas_top);
        make.left.equalTo(self.startTimeLabel.mas_right);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTimeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.bookSiteView.mas_left).with.offset(5);
    }];
    
    [self.endTimeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endTimeLabel.mas_top);
        make.left.equalTo(self.endTimeLabel.mas_right);
    }];
    
    [self.bookNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endTimeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.bookSiteView.mas_left).with.offset(5);
    }];
    [self.bookNumInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookNumLabel.mas_top);
        make.left.equalTo(self.bookNumLabel.mas_right);
    }];
    
    [self.facilityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookSiteView.mas_bottom).with.offset(25);
        make.left.equalTo(self.bookStationScrollView).with.offset(20);
        make.right.equalTo(self.bookStationScrollView).with.offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.facilityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.facilityView);
        make.left.equalTo(self.facilityView).with.offset(5);
    }];
    
    [self.facilityInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.facilityLabel);
        make.left.equalTo(self.facilityLabel.mas_right);
    }];
    
    [self.payTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.facilityView.mas_bottom).with.offset(25);
        make.left.equalTo(self.bookStationScrollView).with.offset(20);
        make.right.equalTo(self.bookStationScrollView).with.offset(-20);
        make.height.mas_equalTo(100);
    }];
    
    [self.payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeView.mas_top).with.offset(10);
        make.left.equalTo(self.payTypeView.mas_left).with.offset(5);
    }];
    
    [self.payTypeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeLabel.mas_top);
        make.left.equalTo(self.payTypeLabel.mas_right);
    }];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.payTypeView.mas_left).with.offset(5);
    }];
    
    [self.sumInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sumLabel.mas_top);
        make.left.equalTo(self.payTypeInfoLabel.mas_left);
    }];
    
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sumLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.payTypeView.mas_left).with.offset(5);
    }];
    
    [self.orderTimeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderTimeLabel.mas_top);
        make.left.equalTo(self.orderTimeLabel.mas_right);
    }];
    
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeView.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    
    [self.attentionInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.attentionLabel.mas_bottom);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_offset(50);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(48);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.right.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView);
        make.height.mas_offset(1);
    }];
    
    [self.actuallyPaidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView.mas_left).with.offset(10);
    }];
    
    [self.actuallyPaidMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.actuallyPaidLabel.mas_right);
    }];
    
    [self.orderPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_right).with.offset(-10);
        make.width.mas_offset(100);
    }];
    
}

-(void)updateView
{
    [self.orderNumInfoLabel setText:self.model.orderNum];
    [self.bookSiteInfoLabel setText:self.meetingModel.location];
    [self.startTimeInfoLabel setText:[self.dic[@"starTime"] substringToIndex:[WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION ? 10 : 16]];
    [self.endTimeInfoLabel   setText:[self.dic[@"endTime"] substringToIndex:[WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION ? 10 : 16]];
    [self.bookNumInfoLabel   setText:@"1"];
    [self.facilityInfoLabel setText:strIsEmpty(self.meetingModel.facility)? @"无":self.meetingModel.facility];
    [self.payTypeInfoLabel setText:((NSNumber *)self.dic[@"payType"]).intValue == 0? @"企业支付" : @"个人支付"];
    [self.sumInfoLabel setText:[NSString stringWithFormat:@"￥%.2f",((NSNumber*)self.dic[@"money"]).doubleValue]];
    [self.orderTimeInfoLabel setText:[NSDate getNewTime]];
    [self.actuallyPaidMoneyLabel setText:[NSString stringWithFormat:@"￥%.2f",((NSNumber*)self.dic[@"money"]).doubleValue]];
}



#pragma mark - 支付
-(void)stationPayMethod
{
    if ([self.dic[@"dealMode"] isEqualToString:@"微信支付"]) {
        [WOTHTTPNetwork wxPayWithParameter:self.model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
