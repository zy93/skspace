//
//  WOTOrderVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderVC.h"
#import "WOTOrderForInfoCell.h"
#import "WOTOrderForSelectDateCell.h"
#import "WOTOrderForSelectTimeCell.h"
#import "WOTOrderForBookStationCell.h"
#import "WOTOrderForSiteCell.h"
#import "WOTOrderForServiceInfoCell.h"
#import "WOTPaymentTypeCell.h"
#import "WOTOrderForSelectCell.h"
#import "WOTOrderForPaymentCell.h"
#import "WOTOrderForAmountCell.h"
#import "WOTDatePickerView.h"
#import "JudgmentTime.h"
#import "WOTLoginVC.h"
#import "SKBookStationNumberModel.h"
#import "StationOrderInfoViewController.h"
#import "UIColor+ColorChange.h"
#import "SKAliPayModel.h"
#import "SKOrderStringModel.h"
#import "SKBookStationOrderModel.h"
#import "WOTOrderForDescribeCell.h"
#import "WOTScrollViewCell.h"
#import "SKGiftBagViewController.h"
#import "WOTMeetingFacilityModel.h"
#import "WOTStaffModel.h"

#define infoCell @"WOTOrderForInfoCell"
#define selectDateCell @"WOTOrderForSelectDateCell"
#define selectTimeCell @"WOTOrderForSelectTimeCell"
#define selectNumberCell @"WOTOrderForBookStationCell"
#define serviceCell @"WOTOrderForServiceInfoCell"
#define describeCell @"WOTOrderForDescribeCell"
#define scrollViewCell @"WOTScrollViewCell"
#define paymentCell @"WOTPaymentTypeCell"
#define selectCell @"WOTOrderForSelectCell"
//#define payTypeCell @"WOTOrderForSelectCell"
//#define siteCell @"siteCell"
//#define amountCell @"amountCell"
//#define uitableCell @"uitableCell"

@interface WOTOrderVC () <UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate,WOTOrderForBookStationCellDelegate, WOTOrderForSelectTimeCellDelegate,WOTOrderForPaymentCellDelegate,WOTPaymentTypeCellDelegate,SDCycleScrollViewDelegate>
{
    NSArray *tableList;
    NSArray *mettingReservationList; //会议室已预订时间数组
    NSIndexPath *payTypeIndex;//个人、企业支付
    NSIndexPath *paymentIndex;//微信、支付宝支付
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong)WOTDatePickerView *datepickerview;
@property (nonatomic, assign)BOOL isValidTime;
@property (nonatomic, strong)JudgmentTime *judgmentTime;
@property (nonatomic, strong)NSIndexPath *selectCellIndex;
@property (nonatomic, strong)NSString *reservationDate;//预定会议室日期
@property (nonatomic, strong)NSNumber *stationTotalNumber; //可预定工位数量
@property (nonatomic, strong)NSString *reservationStationStartDate;//预定工位开始日期
@property (nonatomic, strong)NSString *reservationStationEndDate;//预定工位结束日期
@property (nonatomic, assign)NSInteger reservationStationNumber; //预定工位数量

//@property (nonatomic, strong) WOTMeetingFacilityModel_msg * meetingFacilityModel; //会议室
@property (nonatomic, strong) NSMutableArray * meetingFacilityList;
@property (nonatomic, strong) NSMutableArray * supportList;
@property (nonatomic, strong) NSArray * spaceFacilityList;
@property (nonatomic, strong) NSArray *teamList;


//订单信息
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSNumber *commodityNum;   //商品编号
@property (nonatomic, strong) NSString *commodityKind; //商品对象 0:工位 1:会议室 2:场地 3:增值服务
@property (nonatomic, strong) NSNumber *productNum;   //商品数量
@property (nonatomic, strong) NSString *starTime;    //开始时间
@property (nonatomic, strong) NSString *endTime;    //结束时间
@property (nonatomic, strong) NSNumber *money;     //金额
@property (nonatomic, strong) NSNumber *payType;  //支付类型 0:企业 1:个人
@property (nonatomic, strong) NSString *payObject;//支付对象 企业支付就是公司Id；个人支付就是人名
@property (nonatomic, strong) NSNumber *payMode;//支付方式 0:线下 1:线上
@property (nonatomic, strong) NSNumber *contractMode;     //合同方式 0:纸质 1:电子
@property (nonatomic, strong) NSString *dealMode;         //交易方式 微信 支付宝
@property (nonatomic, strong) NSNumber *deduction;        //是否抵用 0:是 1:否
@property (nonatomic, strong) NSString *facilitator;      //服务商编号:1006
@property (nonatomic, strong) NSString *carrieroperator;  //运营商编号:1006
@property (nonatomic, strong) NSString *body;             //商品描述
@property (nonatomic, strong) NSString *total_fee;        //总金额
@property (nonatomic, strong) NSString *spbill_create_ip; //终端IP
@property (nonatomic, strong) NSString *trade_type;       //交易类型
@property (nonatomic, strong) NSString *invoiceInfo;      //发票信息
@property (nonatomic, assign) NSNumber *bookSationTime;
@property (nonatomic, assign) NSNumber *meetingTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *payWayStr;
@property (nonatomic, strong) NSNumber *conferenceDetailsId;//预定场地的id

@end

@implementation WOTOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(backMainView:)
                                                name:@"buttonLoseResponse" object:nil];
    self.reservationDate = [NSDate getNewTimeZero];
    self.reservationStationStartDate = [NSDate getNewTimeZero];
    self.reservationStationEndDate = [NSDate getNewTimeZero];
    self.payType = @(0); //默认
    self.invoiceInfo = @"请选择企业";
    self.reservationStationNumber = 1;
    self.confirmButton.backgroundColor = UICOLOR_MAIN_ORANGE;
    self.confirmButton.layer.cornerRadius = 5.f;
    [self configNav];
    [self loadData];
    [self loadCost];
    [self requestQuerySingularMan];
    self.payObject = [[WOTUserSingleton shareUser].userInfo.userId stringValue];
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING ||
        [WOTSingtleton shared].orderType == ORDER_TYPE_SITE) {
        [self requestMeetingReservationsInfo];
        
    } else if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
        [self requestStationNumber];
    }
    [self.table registerNib:[UINib nibWithNibName:scrollViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:scrollViewCell];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.judgmentTime = [[JudgmentTime alloc] init];
    [self creatDataPickerView];
    [self getTeam];
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
        [self getSpaceFacility];

    }
    else {
        [self getmeetingFacility];

    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _datepickerview.hidden = YES;
}

-(void)configNav{
    self.navigationItem.title = @"预定";
    self.navigationController.navigationBar.translucent = NO;
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.confirmButton.layer.cornerRadius = 5.f;
    self.confirmButton.layer.borderWidth = 1.f;
    self.confirmButton.layer.borderColor = UICOLOR_MAIN_LINE.CGColor;
}

-(void)creatDataPickerView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
     [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSString *selecTime = [NSString stringWithFormat:@"%04ld/%02ld/%02ld 00:00:00",year, month, day];
        weakSelf.isValidTime = [weakSelf.judgmentTime judgementTimeWithYear:year month:month day:day];
        
        if (weakSelf.isValidTime) {
            weakSelf.reservationDate = selecTime;
        }else
        {
            [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:weakSelf.view];
            weakSelf.datepickerview.hidden  = NO;
        }
        if ([WOTSingtleton shared].orderType != ORDER_TYPE_BOOKSTATION) {
            weakSelf.reservationStationStartDate = selecTime;
            [weakSelf requestMeetingReservationsInfo];
        }else {
            if (weakSelf.isValidTime) {
                weakSelf.datepickerview.hidden  = YES;
                
                if (weakSelf.selectCellIndex.row == 1) {
                    weakSelf.reservationStationStartDate = selecTime;
                }
                else {
                    weakSelf.reservationStationEndDate = selecTime;
                }
                [weakSelf Timedisplay:selecTime];
            }else
            {
                [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:weakSelf.view];
                weakSelf.datepickerview.hidden  = NO;
            }
            
        }
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
    
}

-(void)loadData
{
    NSArray *list1 = nil;
    NSArray *list2 = nil;
    NSArray *list3 = nil;
    NSArray *list4 = nil;

    switch ([WOTSingtleton shared].orderType) {
        case ORDER_TYPE_BOOKSTATION:
        {
            list1 = @[infoCell, selectDateCell,selectDateCell, serviceCell, describeCell];
            list2 = @[scrollViewCell]; //配套设施
            list3 = @[scrollViewCell]; //社区团队
            tableList = @[list1, list2,list3];

        }
            break;
        case ORDER_TYPE_MEETING:
        {
            list1 = @[infoCell, selectDateCell, selectTimeCell, paymentCell, selectCell, serviceCell, describeCell];
            list2 = @[scrollViewCell]; //配套设施
            list3 = @[scrollViewCell]; //支持活动类型
            list4 = @[scrollViewCell]; //社区团队
            tableList = @[list1, list2, list3, list4];
        }
            break;
        case ORDER_TYPE_SITE:
        {
            list1 = @[infoCell, selectDateCell, selectTimeCell, serviceCell, describeCell];
            list2 = @[scrollViewCell]; //配套设施
            list3 = @[scrollViewCell]; //支持活动类型
            list4 = @[scrollViewCell]; //社区团队
            tableList = @[list1, list2, list3, list4];
        }
            break;
        default:
            break;
    }
}

#pragma mark - update table
-(void)updateView{
    self.meetingBeginTime = 0;
    self.meetingEndTime = 0;
    [self.table reloadData];
}


-(void)loadCost
{
    [_costLabel setText:[NSString stringWithFormat:@"实付：￥%.2f",self.costNumber]];
}


#pragma mark - action-- 确认按钮
- (IBAction)clickSubmitBtn:(id)sender {
    //判断用户是否登录
    //NSLog(@"打印工位数量：%@",self.stationNumber);
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
    
    if ([self.judgmentTime compareDate:self.reservationStationStartDate withDate:self.reservationStationEndDate]) {
        [MBProgressHUDUtil showMessage:@"请选择正确的时间范围！" toView:self.view];
        return;
    }
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_SITE) {
        if ([self.invoiceInfo isEqualToString:@"请选择企业"]) {
            [MBProgressHUDUtil showMessage:@"如果选择企业支付，请选择企业" toView:self.view];
            return;
        }
    }
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
        NSInteger bookstationInter = [self.bookSationTime integerValue];
        if (!( bookstationInter> 0)) {
            [MBProgressHUDUtil showMessage:@"该用户下没有工位时间，请购买礼包" toView:self.view];
            SKGiftBagViewController *vc = [[SKGiftBagViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        NSInteger difference = (self.meetingEndTime-self.meetingBeginTime)*60;
        NSInteger meetInteger = [self.meetingTime integerValue];
        if (difference > meetInteger) {
            [MBProgressHUDUtil showMessage:@"该用户下会议室时间剩余不足，请购买礼包" toView:self.view];
            SKGiftBagViewController *vc = [[SKGiftBagViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    self.dealMode = @"微信支付";
    //self.payObject= [[WOTUserSingleton shareUser].userInfo.userId stringValue];
    
    switch ([WOTSingtleton shared].orderType) {
        case ORDER_TYPE_BOOKSTATION:
        {
            if (![self verifyBookStation]) {
                return;
            };
            self.spaceId = self.spaceModel.spaceId;
            self.commodityNum = self.spaceModel.spaceId;
            self.commodityKind = @"工位";
            self.productNum = @(self.reservationStationNumber);
            self.starTime = self.reservationStationStartDate;
            self.endTime =  self.reservationStationEndDate;
            self.money = @(self.costNumber);
            self.payMode = @(1);
            self.contractMode = @(1);
            self.facilitator = @"1006";
            self.carrieroperator = @"1006";
            self.body = @"工位";
            self.total_fee = @"1";// self.money.floatValue * 100;
            self.trade_type = @"APP";
            self.payObject = [[WOTUserSingleton shareUser].userInfo.userId stringValue];
            self.payType = @1;
            [self commitBookStationOrder];
            
        }
            break;
        case ORDER_TYPE_MEETING:
        case ORDER_TYPE_SITE:
        {
            //时间检验
            if (self.meetingEndTime-self.meetingBeginTime <=0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择预定时间" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            self.spaceId = self.meetingModel.spaceId;
            self.commodityNum = self.meetingModel.conferenceId;
            self.commodityKind = [WOTSingtleton shared].orderType == ORDER_TYPE_MEETING ?  @"会议室": @"场地";
            self.productNum = @(1);
            NSArray *arr = [NSString getReservationsTimesWithDate:self.reservationDate StartTime:self.meetingBeginTime  endTime:self.meetingEndTime];
            self.starTime = arr.firstObject;
            self.endTime =  arr.lastObject;
            self.money = @(self.costNumber);
            self.payMode = @(1);
            self.contractMode = @(1);
            self.facilitator = @"1006";
            self.carrieroperator = @"1006";
            self.body = @"场地/会议室预定";
            self.total_fee = @"1";// self.money.floatValue * 100;
            self.trade_type = @"APP";
            if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
                [self reservationsMeeting];
            }else
            {
                [self reservationsSite];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - cell delegate
-(void)selectTimeWithCell:(WOTOrderForSelectTimeCell *)cell Time:(CGFloat)time
{
    if (self.meetingBeginTime == self.meetingEndTime && self.meetingEndTime == 0) {
        self.meetingBeginTime = time;
        self.meetingEndTime = self.meetingBeginTime+0.5;
    }
    else if (time ==  self.meetingBeginTime && self.meetingBeginTime == self.meetingEndTime-0.5) {
        self.meetingBeginTime = self.meetingEndTime = 0;
    }
    else if (time<self.meetingBeginTime) {
        self.meetingBeginTime = time;
    }
    else if (time>=self.meetingEndTime) {
        self.meetingEndTime = time+0.5;
    }
    else if (time>self.meetingBeginTime && time<self.meetingEndTime) {
        if (time == self.meetingEndTime-0.5) {
            self.meetingEndTime = time;
        }
        else {
            self.meetingEndTime = time+0.5;
        }
    }
    [cell.selectTimeScroll setBeginTime:self.meetingBeginTime endTime:self.meetingEndTime];
    [self imputedPriceAndLoadCost];
}

-(void)changeValue:(WOTOrderForBookStationCell *)cell
{
    self.reservationStationNumber = cell.orderNumberInt;
    [self imputedPriceAndLoadCost];
}

-(void)paymentTypeCell:(WOTPaymentTypeCell *)cell selectPaymentType:(NSNumber *)paymentType
{
    self.payType = paymentType;
    if (paymentType.integerValue == 0) {
        self.invoiceInfo = @"请选择企业";
    }
    else {
        self.invoiceInfo = @"个人";
        self.payObject = [[WOTUserSingleton shareUser].userInfo.userId stringValue];
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:cell.index.row+1 inSection:cell.index.section];
    [self.table reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    
}


#pragma mark - table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list = tableList[section];
    return list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *list = tableList[indexPath.section];
    NSString *cellType = list[indexPath.row];
    
    if ([cellType isEqualToString:infoCell]) {
        return 300;
    }
    else if ([cellType isEqualToString:selectDateCell]) {
        return 40;
    }
    else if ([cellType isEqualToString:selectTimeCell]) {
        return 130;
    }
    else if ([cellType isEqualToString:selectNumberCell]) {
        return 50;
    }
//    else if ([cellType isEqualToString:siteCell]) {
//        return 65;
//    }
    else if ([cellType isEqualToString:serviceCell]) {
        return 96;
    }
    else if ([cellType isEqualToString:describeCell]) {
        //计算高度
//
        CGFloat heigth = [self.meetingModel.conferenceDescribe heightWithFont:[UIFont systemFontOfSize:13.f] maxWidth:SCREEN_WIDTH-40];
        return 60+heigth;
    }
    else if ([cellType isEqualToString:scrollViewCell]) {
        if ([WOTSingtleton shared].orderType==ORDER_TYPE_BOOKSTATION) {
            if (indexPath.section == 1) {
                return 130;
            }
            return 250*[WOTUitls GetLengthAdaptRate];
        }
//        else if ([WOTSingtleton shared].orderType==ORDER_TYPE_MEETING){
//
//        }
        else {
            if (indexPath.section == 1) {
                return 130;
            }
            else if (indexPath.section == 2) {
                //70 其他高度、40scroll高度，10数据量、3每行显示数量 1基础数量1行。
                return 70+(40*(((int)(self.supportList.count/3))+1));
            }
            return 250*[WOTUitls GetLengthAdaptRate];
        }
    }
//    else if ([cellType isEqualToString:payTypeCell]) {
//        return 50;
//    }
    else if ([cellType isEqualToString:selectCell]) {
        return 50;
    }
//    else if ([cellType isEqualToString:uitableCell]) {
//        return 30;
//    }
    else if ([cellType isEqualToString:paymentCell]) {
        return 50;
    }
    else // ([cellType isEqualToString:amountCell])
    {
        return 50;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *list = tableList[indexPath.section];
    NSString *cellType = list[indexPath.row];
    
    if ([cellType isEqualToString:infoCell]) {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
        
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:infoCell];
        }
        switch ([WOTSingtleton shared].orderType) {
            case ORDER_TYPE_BOOKSTATION:
            {
                NSArray  *array = [_spaceModel.spacePicture componentsSeparatedByString:@","];
                NSMutableArray *imageArr = [NSMutableArray new];
                for (NSString *str in array) {
                    [imageArr addObject:[str ToResourcesUrl]];
                }
                cell.scrollview.imageURLStringsGroup = imageArr;
                cell.scrollview.delegate = self;
                cell.scrollview.pageDotColor = UICOLOR_GRAY_66;
                cell.scrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;//dong删除默认居中
                cell.scrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;  //设置图片填充格式
                cell.infoTitle.text = _spaceModel.spaceName;
                cell.dailyRentLabel.text = [NSString stringWithFormat:@"今日剩余工位：%ld",self.stationTotalNumber.integerValue];
            }
                break;
            case ORDER_TYPE_SITE:
            case ORDER_TYPE_MEETING:
            {
                NSArray  *array = [_meetingModel.conferencePicture componentsSeparatedByString:@","];
//                NSString *imageUrl = [array firstObject];
                cell.infoTitle.text = _meetingModel.conferenceName;
                cell.dailyRentLabel.text = _meetingModel.location;
                NSMutableArray *imageArr = [NSMutableArray new];
                for (NSString *str in array) {
                    [imageArr addObject:[str ToResourcesUrl]];
                }
                cell.scrollview.imageURLStringsGroup = imageArr;
                cell.scrollview.delegate = self;
//                cell.scrollview.titlesGroup = titleArr;
                cell.scrollview.pageDotColor = UICOLOR_CLEAR;
                cell.scrollview.backgroundColor = UICOLOR_GRAY_F1;
                cell.scrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;//dong删除默认居中
                cell.scrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;  //设置图片填充格式
                
            }
                break;
            default:
                break;
        }
        return cell;
    }
    else if ([cellType isEqualToString:selectDateCell]) {
        WOTOrderForSelectDateCell *cell = [tableView dequeueReusableCellWithIdentifier:selectDateCell];
        if (cell == nil) {
            cell = [[WOTOrderForSelectDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectDateCell];
        }
        [cell.dateLab setText:[self.reservationDate substringToIndex:10]];
//        if (self.isValidTime) {
//            [cell.dateLab setText:[self.reservationDate substringToIndex:10]];
//        }else
//        {
//            [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:self.view];
//            self.datepickerview.hidden  = NO;
//        }
        if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
            if (indexPath.row == 1) {
                [cell.dateNameLab setText:@"开始日期："];
            }
            else {
                [cell.dateNameLab setText:@"结束日期："];
            }
        }
        return cell;
    }
    else if ([cellType isEqualToString:selectTimeCell]) {
        WOTOrderForSelectTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:selectTimeCell];
        if (cell == nil) {
            cell = [[WOTOrderForSelectTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectTimeCell];
        }
        cell.delegate  =  self;
        [cell setSelectDate: self.reservationStationStartDate]; //先设置日期
        [cell setReservationList:mettingReservationList];   //再设置时间
        if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING ||
            [WOTSingtleton shared].orderType == ORDER_TYPE_SITE ) {
            [cell.selectTimeScroll setOpenTime:self.meetingModel.openTime];
            [cell.selectTimeScroll setBeginTime:self.meetingBeginTime endTime:self.meetingEndTime];
        }
        else {
        }
        cell.index = indexPath;
        return cell;
    }
    else if ([cellType isEqualToString:selectNumberCell]) {
        WOTOrderForBookStationCell *cell = [tableView dequeueReusableCellWithIdentifier:selectNumberCell];
        if (cell == nil) {
            cell = [[WOTOrderForBookStationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:selectNumberCell];
        }
        cell.maxNumber = self.stationTotalNumber;
        cell.delegate = self;
        return cell;
    }
//    else if ([cellType isEqualToString:siteCell]) {
//        WOTOrderForSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSiteCell"];
//        if (cell == nil) {
//            cell = [[WOTOrderForSiteCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSiteCell"];
//        }
//        return cell;
//    }
    else if ([cellType isEqualToString:serviceCell]) {
        WOTOrderForServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceCell];
        if (cell == nil) {
            cell = [[WOTOrderForServiceInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:serviceCell];
        }

        switch ([WOTSingtleton shared].orderType) {
            case ORDER_TYPE_BOOKSTATION:
            {
                cell.addressValueLab.text  = self.spaceModel.spaceSite;
                cell.openTimeValueLab.text = @"全天";
                cell.peopleValueLab.text   = @"100人";
            }
                break;
            case ORDER_TYPE_MEETING:
            case ORDER_TYPE_SITE:

            {
                cell.addressValueLab.text = [self.spaceModel.spaceSite stringByAppendingString:self.meetingModel.location];
                cell.openTimeValueLab.text =self.meetingModel.openTime;
                cell.peopleValueLab.text = [NSString stringWithFormat:@"%@人",self.meetingModel.peopleNum];
            }
                break;
            default:
                break;
        }
         
        return cell;
    }
    else if ([cellType isEqualToString:describeCell]) {
        WOTOrderForDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:describeCell];
        if (cell == nil) {
            cell = [[WOTOrderForDescribeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:describeCell];
        }
        cell.contentText.text = self.meetingModel.conferenceDescribe;
        
        return cell;
    }
    else if ([cellType isEqualToString:scrollViewCell]) {
        WOTScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollViewCell];
        if (cell == nil) {
            cell = [[WOTScrollViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:scrollViewCell];
        }
        
        if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
            if (indexPath.section==1) {
                cell.cellType = WOTScrollViewCellType_facilities;
                [cell setData:self.spaceFacilityList];
            }
            else {
                cell.cellType = WOTScrollViewCellType_team;
                [cell setData:self.teamList];
            }
        }
//        else if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
//
//        }
        else {
            if (indexPath.section==1) {
                cell.cellType = WOTScrollViewCellType_facilities;
                [cell setData:self.meetingFacilityList];

            }
            else if (indexPath.section==2) {
                cell.cellType = WOTScrollViewCellType_type;
                [cell setData:self.supportList];
            }
            else {
                cell.cellType = WOTScrollViewCellType_team;
                [cell setData:self.teamList];
            }
        }
        
        

        return cell;
    }
    else if ([cellType isEqualToString:paymentCell]) {
        WOTPaymentTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:paymentCell];
        if (cell == nil) {
            cell = [[WOTPaymentTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:paymentCell];
        }
        cell.delegate = self;
        cell.index = indexPath;
        cell.enterprise= YES;
        return cell;
    }
    else if ([cellType isEqualToString:selectCell]) {
        WOTOrderForSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSelectCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSelectCell"];
        }
        if (indexPath.row==1) {
            [cell.titleLab setText:@"发票信息"];
            [cell.subtitleLab setText:self.invoiceInfo];
        }
        return cell;
    }
//    else if ([cellType isEqualToString:uitableCell]) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCelll"];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCelll"];
//        }
//        [cell.textLabel setText:@"支付方式"];
////        cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
//
//        return cell;
//    }
//    else if ([cellType isEqualToString:paymentCell]) {
//        WOTOrderForPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForPaymentCell"];
//        if (cell == nil) {
//            cell = [[WOTOrderForPaymentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForPaymentCell"];
//        }
//        cell.delegate = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    else // ([cellType isEqualToString:amountCell])
    {
        WOTOrderForAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForAmountCell"];
        if (cell == nil) {
            cell = [[WOTOrderForAmountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForAmountCell"];
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *list = tableList[indexPath.section];
    NSString *cellType = list[indexPath.row];
    self.selectCellIndex = indexPath;
    if ([cellType isEqualToString:selectDateCell]) {
        _datepickerview.hidden = NO;
    }
//    if ([cellType isEqualToString:selectCell]) {
//        //
//        if ([self.payType isEqual:@(0)]) {
//            //企业发票
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
//            WOTMyEnterpriseVC *myenterprisevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTMyEnterpriseVC"];
//            myenterprisevc.selectEnterprise = YES;
//            [self.navigationController pushViewController:myenterprisevc animated:YES];
//            myenterprisevc.selectEnterpriseBlock = ^(WOTEnterpriseModel *model) {
//                self.payObject = model.companyId;
//                self.invoiceInfo = model.companyName;
//                NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//                [self.table reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
//            };
//        }
//        else {
//            //个人发票
//        }
//    }
}

#pragma mark - WOTOrderForPaymentCellDelegate
-(void)choosePayWay:(NSString *)payWayStr
{
    self.payWayStr = payWayStr;
    if ([self.payWayStr isEqualToString:@"支付宝"]) {
        [WOTSingtleton shared].payType = PAY_TYPE_ALI;
    }else
    {
        [WOTSingtleton shared].payType = PAY_TYPE_WX;
    }
}

#pragma mark - 计算价格
-(void)imputedPriceAndLoadCost
{
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_SITE ||
        [WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        CGFloat reservaionsTime = self.meetingEndTime - self.meetingBeginTime;
        self.costNumber = [self.meetingModel.conferencePrice floatValue] * reservaionsTime;
    }
    else {
        NSString *startDate =[self.reservationStationStartDate substringToIndex:10];
        NSString *endDate = [self.reservationStationEndDate substringToIndex:10];
        NSInteger dayNumber = [self.judgmentTime numberOfDaysWithFromDate:startDate toDate:endDate];
        self.costNumber = dayNumber * self.reservationStationNumber * [self.spaceModel.onlineLocationPrice floatValue];
    }
    [self loadCost];
}

#pragma mark - 判断时间选择是否合理
-(void)Timedisplay:(NSString *)selectTime
{
    NSString *startDate =[self.reservationStationStartDate substringToIndex:10];
    NSString *endDate = [self.reservationStationEndDate substringToIndex:10];
    WOTOrderForSelectDateCell *cell = [self.table cellForRowAtIndexPath:self.selectCellIndex];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.dateLab setText:[self.reservationDate substringToIndex:10]];
    });
    [self imputedPriceAndLoadCost];
}

#pragma mark - 预定场地
-(void)reservationsSite
{
    __weak typeof(self) weakSelf = self;
    //会议室先预定，然后支付。
    NSArray *arr = [NSString getReservationsTimesWithDate:self.reservationDate StartTime:self.meetingBeginTime  endTime:self.meetingEndTime];
    [WOTHTTPNetwork  siteReservationsWithSpaceId:self.spaceModel.spaceId
                                      conferenceId:self.meetingModel.conferenceId startTime:arr.firstObject
                                           endTime:arr.lastObject
                                         spaceName:self.spaceModel.spaceName
                                       meetingName:self.meetingModel.conferenceName
                                            userId:[WOTUserSingleton shareUser].userInfo.userId
                                              body:self.body
                                          response:^(id bean, NSError *error) {
                                              WOTReservationsResponseModel_msg *model = (WOTReservationsResponseModel_msg *)bean;
                                              if ([model.code isEqualToString:@"200"]) {
                                                  self.conferenceDetailsId = model.msg.conferenceDetailsId;
                                                  if ([self.payWayStr isEqualToString:@"支付宝"]) {
                                                      [weakSelf commitAliOrder];
                                                  }else
                                                  {
                                                      [weakSelf commitOrder];
                                                  }
                                              }
                                              else {
                                                  [MBProgressHUDUtil showMessage:[NSString stringWithFormat:@"预定失败:%@", model.result] toView:weakSelf.view];
                                              }
                                          }];
}

#pragma mark - 预定会议室
-(void)reservationsMeeting
{
    __weak typeof(self) weakSelf = self;
    //会议室先预定，然后支付。
    NSArray *arr = [NSString getReservationsTimesWithDate:self.reservationDate StartTime:self.meetingBeginTime  endTime:self.meetingEndTime];
    [WOTHTTPNetwork meetingReservationsWithSpaceId:self.spaceModel.spaceId
                                      conferenceId:self.meetingModel.conferenceId startTime:arr.firstObject
                                           endTime:arr.lastObject
                                         spaceName:self.spaceModel.spaceName
                                       meetingName:self.meetingModel.conferenceName
                                            userId:[WOTUserSingleton shareUser].userInfo.userId
                                          response:^(id bean, NSError *error) {
                                            WOTReservationsResponseModel_msg *model = (WOTReservationsResponseModel_msg *)bean;
                                            if ([model.code isEqualToString:@"200"]) {
                                                self.conferenceDetailsId = model.msg.conferenceDetailsId;
                                                StationOrderInfoViewController *vc = [[StationOrderInfoViewController alloc] init];
                                                vc.orderNum = model.msg.orderNum;
                                                vc.nameStr = self.meetingModel.conferenceName;
                                                vc.startTime = model.msg.starTime;
                                                vc.endTime = model.msg.endTime;
                                                vc.productNum = self.productNum;
                                                //vc.orderString = model.msg;
                                                vc.payType = self.payType;
                                                vc.money = self.money;
                                                vc.durationTime = [NSString dateTimeDifferenceHoursWithStartTime:self.starTime endTime:self.endTime];
                                                [weakSelf.navigationController pushViewController:vc animated:YES];
                                            }
                                            else {
                                                [MBProgressHUDUtil showMessage:[NSString stringWithFormat:@"预定失败:%@", model.result] toView:weakSelf.view];
                                            }
                                          }];
}
#pragma mark - 验证工位
-(BOOL)verifyBookStation
{
    //工位不需要先预定，支付后完成后才会修改状态
    if (self.reservationStationNumber <=0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择工位数量" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - 支付宝订单接口
-(void)commitAliOrder
{
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                               @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                               @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                               @"spaceId":self.spaceId,
                               @"commodityKind":self.commodityKind,
                               @"productNum":self.productNum,
                               @"money":@(self.costNumber),
                               @"payType":self.payType,
                               @"payObject":self.payObject,
                               @"body":self.body,
                               @"starTime":self.starTime,
                               @"endTime":self.endTime,
                               @"spaceName":self.spaceModel.spaceName,
                               @"conferenceDetailsId":self.conferenceDetailsId,
                               @"invoiceInfo":self.invoiceInfo,
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
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getOrderString:param response:^(id bean, NSError *error) {
        SKOrderStringModel *model = (SKOrderStringModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            StationOrderInfoViewController *vc = [[StationOrderInfoViewController alloc] init];
            vc.orderNum = [param objectForKey:@"orderNum"];
            if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
                vc.nameStr = self.spaceModel.spaceName;
            }
            else
            {
                vc.nameStr = self.meetingModel.conferenceName;
            }
            vc.startTime = [orderParam objectForKey:@"starTime"];
            vc.endTime = [orderParam objectForKey:@"endTime"];
            vc.productNum = self.productNum;
            vc.orderString = model.msg;
            vc.payType = self.payType;
            vc.money = self.money;
            vc.durationTime = [NSString dateTimeDifferenceHoursWithStartTime:self.starTime endTime:self.endTime];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else
        {
            [MBProgressHUDUtil showMessage:@"提交失败" toView:self.view];
            return ;
        }
    }];
}

#pragma mark - 工位微信订单接口
-(void)commitBookStationOrder
{
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                 @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                                 @"facilitator":self.facilitator,
                                 @"carrieroperator":self.carrieroperator,
                                 @"body":self.body,
                                 @"total_fee":self.total_fee,
                                 @"trade_type":self.trade_type,
                                 @"spaceId":self.spaceId,
                                 @"spaceName":self.spaceModel.spaceName,
                                 @"commodityNum":self.commodityNum,
                                 @"commodityKind":self.commodityKind,
                                 @"productNum":self.productNum,//,@500
                                 @"starTime":self.starTime,
                                 @"endTime":self.endTime,
                                 @"money":@(self.costNumber),
                                 @"dealMode":self.dealMode,
                                 @"payType":self.payType,
                                 @"payObject":self.payObject,
                                 @"payMode":self.payMode,
                                 @"contractMode":self.contractMode,
                                 @"conferenceDetailsId":self.conferenceDetailsId,
                                 @"invoiceInfo":self.invoiceInfo,
                                 };
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork generateBookStationOrderWithParam:parameters response:^(id bean, NSError *error) {
        SKBookStationOrderModel_msg *model_msg = (SKBookStationOrderModel_msg *)bean;
        SKBookStationOrderModel *model = model_msg.msg;
        if ([model_msg.code isEqualToString:@"200"]) {
            SKBookStationOrderModel_object *model_object = model.Object;
            StationOrderInfoViewController *vc = [[StationOrderInfoViewController alloc] init];
            vc.orderNum = model_object.orderNum;
            vc.nameStr = self.spaceModel.spaceName;
            //vc.model = model_object;
            vc.startTime = self.starTime;
            vc.endTime = self.endTime;
            vc.productNum = self.productNum;
            vc.payType = self.payType;
            vc.money = self.money;
            vc.durationTime = [NSString dateTimeDifferenceHoursWithStartTime:self.starTime endTime:self.endTime];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else if ([model_msg.code isEqualToString:@"201"])
        {
            NSArray <SKBookStationOrderModel_array *>*objectArray = model.Array;
            NSMutableArray *infoArray = [[NSMutableArray alloc] init];
            [infoArray addObject:@"以下日期不能预约："];
            for (SKBookStationOrderModel_array *infoObject in objectArray) {
                
                [infoArray addObject:[infoObject.time substringToIndex:11]];
            }
            
            NSString *string = [infoArray componentsJoinedByString:@" "];
            [MBProgressHUDUtil showMessage:string toView:self.view];
            return ;
        }else
        {
            [MBProgressHUDUtil showMessage:@"提交失败" toView:self.view];
            return ;
        }
    }];
}

#pragma mark - 微信订单接口
-(void)commitOrder{
    //是否选择了时间
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                 @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                                 @"facilitator":self.facilitator,
                                 @"carrieroperator":self.carrieroperator,
                                 @"body":self.body,
                                 @"total_fee":self.total_fee,
                                 @"trade_type":self.trade_type,
                                 @"spaceId":self.spaceId,
                                 @"spaceName":self.spaceModel.spaceName,
                                 @"commodityNum":self.commodityNum,
                                 @"commodityKind":self.commodityKind,
                                 @"productNum":self.productNum,//,@500
                                 @"starTime":self.starTime,
                                 @"endTime":self.endTime,
                                 @"money":@(self.costNumber),
                                 @"dealMode":self.dealMode,
                                 @"payType":self.payType,
                                 @"payObject":self.payObject,
                                 @"payMode":self.payMode,
                                 @"contractMode":self.contractMode,
                                 @"conferenceDetailsId":self.conferenceDetailsId,
                                 @"invoiceInfo":self.invoiceInfo,
                                 };
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork generateOrderWithParam:parameters response:^(id bean, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            WOTWXPayModel_msg *model_msg = (WOTWXPayModel_msg *)bean;
            if ([model_msg.code isEqualToString:@"200"]) {
                StationOrderInfoViewController *vc = [[StationOrderInfoViewController alloc] init];
                if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
                    vc.orderNum = model_msg.msg.orderNum;
                }else
                {
                    vc.orderNum = model_msg.msg.out_trade_no;
                }
                
                if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
                    vc.nameStr = self.spaceModel.spaceName;
                }
                else
                {
                    vc.nameStr = self.meetingModel.conferenceName;
                }
                vc.model = model_msg.msg;
                vc.startTime = self.starTime;
                vc.endTime = self.endTime;
                vc.productNum = self.productNum;
                vc.payType = self.payType;
                vc.money = self.money;
                vc.durationTime = [NSString dateTimeDifferenceHoursWithStartTime:self.starTime endTime:self.endTime];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                
                [MBProgressHUDUtil showMessage:@"提交失败" toView:self.view];
                return ;
            }
            
        });
    }];
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)backMainView:(NSNotification *)noti

{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 请求工位数量 request
-(void)requestStationNumber
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getBookStationNumberWithSpaceId:self.spaceModel.spaceId time:[NSDate getNewTimeZero] response:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        SKBookStationNumberModel *bookStation = bean;
        weakSelf.stationTotalNumber = [bookStation.msg objectForKey:@"residueStationNum"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
        NSLog(@"可预订工位数量：%@",weakSelf.stationTotalNumber);
    }];
}

//查询会议室预定情况
-(void)requestMeetingReservationsInfo
{
    //    @"2017/07/13 00:00:00"
    [WOTHTTPNetwork getMeetingReservationsTimeWithSpaceId:_meetingModel.spaceId conferenceId:_meetingModel.conferenceId startTime:self.reservationDate response:^(id bean, NSError *error) {
        WOTMeetingReservationsModel_msg *mod =(WOTMeetingReservationsModel_msg *) bean;
        NSMutableArray *reserList = [NSMutableArray new];
        for (WOTMeetingReservationsModel * model in  mod.msg) {
            NSArray *arr = [NSString getReservationsTimesWithStartTime:model.startTime endTime:model.endTime];
            [reserList addObject:arr];
        }
        mettingReservationList = reserList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateView];
        });
    }];
}

#pragma mark - 查询个人信息
-(void)requestQuerySingularMan
{
    if ([WOTUserSingleton shareUser].userInfo.userId == nil) {
        [MBProgressHUDUtil showMessage:@"请先登录再进行其他操作" toView:self.view];
        return;
    }
    [WOTHTTPNetwork querySingularManInfoWithUserId:[WOTUserSingleton shareUser].userInfo.userId response:^(id bean, NSError *error) {
        WOTLoginModel_msg *model_msg = (WOTLoginModel_msg *)bean;
        WOTLoginModel *model = model_msg.msg;
        if ([model_msg.code isEqualToString:@"200"]) {
            self.bookSationTime = model.workHours;
            self.meetingTime = model.meetingHours;
            self.userId = model.userId;
        } else {
            [MBProgressHUDUtil showMessage:@"网络出错！" toView:self.view];
        }
    }];
}

#pragma mark - 获取会议室场地配套设施
-(void)getmeetingFacility
{
    if (!self.meetingFacilityList) {
        self.meetingFacilityList= [NSMutableArray new];
    }
    if (!self.supportList) {
        self.supportList = [NSMutableArray new];
    }
    [self.meetingFacilityList removeAllObjects];
    [self.supportList removeAllObjects];
    [WOTHTTPNetwork getMeetingFacilitiesWithMeetingId:self.meetingModel.conferenceId response:^(id bean, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WOTMeetingFacilityModel_msg *msg = bean;
            //需要把数据拆出来
            for (WOTMeetingFacilityModel *model in msg.msg) {
                //如果是空，就是支持类型，
                if (strIsEmpty(model.facilitiesPicture)) {
                    [self.supportList addObject:model];
                }
                //否则是设施
                else {
                    [self.meetingFacilityList addObject:model];
                }
            }
            [self.table reloadData];
        });
    }];
}

-(void)getSpaceFacility
{
    [WOTHTTPNetwork getSpaceFacilitiesWithSpaceId:self.spaceModel.spaceId response:^(id bean, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WOTMeetingFacilityModel_msg *msg = bean;
            self.spaceFacilityList = msg.msg;
            [self.table reloadData];
        });
    }];
}

#pragma mark - 查询团队
-(void)getTeam
{
    [WOTHTTPNetwork getSpaceTeamWithSpaceId:self.spaceModel.spaceId response:^(id bean, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WOTStaffModel_msg *model = bean;
            self.teamList = model.msg.list;
            [self.table reloadData];
        });
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.datepickerview.hidden = YES;
}

-(NSString *)payWayStr
{
    if (_payWayStr == nil) {
        _payWayStr = @"支付宝";
        [WOTSingtleton shared].payType = PAY_TYPE_ALI;
    }
    return _payWayStr;
}

-(NSNumber *)conferenceDetailsId
{
    if (_conferenceDetailsId == nil) {
        _conferenceDetailsId = [[NSNumber alloc] init];
        _conferenceDetailsId = @0;
    }
    return _conferenceDetailsId;
}

@end
