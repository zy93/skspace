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

#define infoCell @"infoCell"
#define selectDateCell @"selectDateCell"
#define selectTimeCell @"selectTimeCell"
#define selectNumberCell @"selectNumberCell"
#define serviceCell @"serviceCell"
#define payTypeCell @"payTypeCell"
#define selectCell @"selectCell"
#define siteCell @"siteCell"
#define amountCell @"amountCell"
#define uitableCell @"uitableCell"
#define paymentCell @"paymentCell"

@interface WOTOrderVC () <UITableViewDataSource, UITableViewDelegate,WOTOrderForBookStationCellDelegate, WOTOrderForSelectTimeCellDelegate>
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
@property (nonatomic, strong)WOTOrderForBookStationCell *orderBookStationCell;
@property (nonatomic, assign)NSInteger dayNumber;  //预定工位天数
@property (nonatomic, assign)NSNumber *productNum;
@property (nonatomic, assign)float orderNumber;
@property (nonatomic, assign)NSNumber *stationNumber;
@property (nonatomic, strong)NSIndexPath *selectCellIndex;
@property (nonatomic, strong)NSString *reservationDate;//预定会议室日期
@property (nonatomic, strong)NSString *reservationStationStartDate;//预定工位开始日期
@property (nonatomic, strong)NSString *reservationStationEndDate;//预定工位结束日期

@end

@implementation WOTOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
   // NSNotification *LoseResponse = [NSNotification notificationWithName:@"buttonLoseResponse" object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(backMainView:)
                                                name:@"buttonLoseResponse" object:nil];
    self.reservationDate = [NSDate getNewTimeZero];
    self.reservationStationStartDate = [NSDate getNewTimeZero];
    self.reservationStationEndDate = [NSDate getNewTimeZero];
    [self configNav];
    [self loadData];
    [self loadCost];
    
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING ||
        [WOTSingtleton shared].orderType == ORDER_TYPE_SITE) {
        [self requestMeetingReservationsInfo];
        
    } else if ([WOTSingtleton shared].orderType == ORDER_TYPE_BOOKSTATION) {
        [self requestStationNumber];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.productNum = [[NSNumber alloc] init];
    [super viewWillAppear:animated];
    self.judgmentTime = [[JudgmentTime alloc] init];
    [self creatDataPickerView];
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
    self.confirmButton.layer.borderColor = [UIColor colorWithHexString:@"00a910"].CGColor;
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
        weakSelf.reservationDate = selecTime;
        WOTOrderForSelectDateCell *cell = [weakSelf.table cellForRowAtIndexPath:weakSelf.selectCellIndex];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.dateLab setText:[selecTime substringToIndex:10]];
        });
        if ([WOTSingtleton shared].orderType != ORDER_TYPE_BOOKSTATION) {
            [weakSelf requestMeetingReservationsInfo];
        }else {
            if (weakSelf.selectCellIndex.row == 1) {
                weakSelf.reservationStationStartDate = selecTime;
            }
            else {
                weakSelf.reservationStationEndDate = selecTime;
            }
            if (weakSelf.isValidTime) {
                weakSelf.datepickerview.hidden  = YES;
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
    
    switch ([WOTSingtleton shared].orderType) {
        case ORDER_TYPE_BOOKSTATION:
        {
            list1 = @[infoCell, selectDateCell,selectDateCell, selectNumberCell];
        }
            break;
        case ORDER_TYPE_MEETING:
        case ORDER_TYPE_SITE:
        {
            list1 = @[infoCell, selectDateCell, selectTimeCell];
        }
            break;
        default:
            break;
    }
    
    NSArray *list2 = @[serviceCell];
    NSArray *list3 = @[payTypeCell, selectCell, selectCell];
    NSArray *list4 = @[uitableCell,paymentCell];
    tableList = @[list1, list2, list3, list4];
}

#pragma mark - update table
-(void)updateView{
    self.beginTime = 0;
    self.endTime = 0;
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
    
    NSNumber *commNum = @(0);
    NSNumber *commKind = @(0);
    NSString *dealMode = @"微信支付";
    switch ([WOTSingtleton shared].orderType) {
        case ORDER_TYPE_BOOKSTATION:
        {
            [self verifyBookStation];
            self.productNum = @([self.orderBookStationCell.orderNumber.text integerValue]);
            commNum = @(0);;
            commKind = @(0);
        }
            break;
        case ORDER_TYPE_MEETING:
        case ORDER_TYPE_SITE:
        {
            [self verifyMeeting];
            self.productNum = @(1);
            commNum = self.meetingModel.conferenceId;
            commKind = @(1);
            //是否选择了时间
            if (self.endTime-self.beginTime <=0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择预定时间" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            NSArray *arr = [NSString getReservationsTimesWithDate:self.reservationDate StartTime:self.beginTime  endTime:self.endTime];
            NSString *deviceip = [[WOTConfigThemeUitls shared] getIPAddress];
            NSString *chineseBody = @"易创客";
            
            NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                         @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                         @"userTel":[WOTUserSingleton shareUser].userInfo.tel,
                                         @"facilitator":@"1006",
                                         @"carrieroperator":@"1006",
                                         @"body":chineseBody,
                                         @"total_fee":@(1),
                                         @"spbill_create_ip":deviceip,
                                         @"trade_type":@"APP",
                                         @"spaceId":self.meetingModel.spaceId,
                                         @"commodityNum":commNum,
                                         @"commodityKind":commKind,
                                         @"productNum":@(1),
                                         @"starTime":arr.firstObject,
                                         @"endTime":arr.lastObject,
                                         @"money":@(self.costNumber),
                                         @"dealMode":dealMode,
                                         @"payType":@(1),
                                         @"payObject":@(1),
                                         @"payMode":@(1),
                                         @"contractMode":@(1),
                                         };
            
            
            
            __weak typeof(self) weakSelf = self;
            [WOTHTTPNetwork generateOrderWithParam:parameters response:^(id bean, NSError *error){
               dispatch_async(dispatch_get_main_queue(), ^{
                   //
                   StationOrderInfoViewController *vc = [[StationOrderInfoViewController alloc] init];
                   vc.meetingModel = weakSelf.meetingModel;
                   vc.dic = parameters;
                   [vc setModel:((WOTWXPayModel_msg*)bean).msg];
                   [weakSelf.navigationController pushViewController:vc animated:YES];
               });
            }];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - cell delegate
-(void)selectTimeWithCell:(WOTOrderForSelectTimeCell *)cell Time:(CGFloat)time
{
    if (self.beginTime == self.endTime && self.endTime == 0) {
        self.beginTime = time;
        self.endTime = self.beginTime+0.5;
    }
    else if (time ==  self.beginTime && self.beginTime == self.endTime-0.5) {
        self.beginTime = self.endTime = 0;
    }
    else if (time<self.beginTime) {
        self.beginTime = time;
    }
    else if (time>=self.endTime) {
        self.endTime = time+0.5;
    }
    else if (time>self.beginTime && time<self.endTime) {
        if (time == self.endTime-0.5) {
            self.endTime = time;
        }
        else {
            self.endTime = time+0.5;
        }
    }
    
    [cell.selectTimeScroll setBeginTime:self.beginTime endTime:self.endTime];
    [self imputedPriceAndLoadCost];
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
        return 265;
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
    else if ([cellType isEqualToString:siteCell]) {
        return 65;
    }
    else if ([cellType isEqualToString:serviceCell]) {
        return 80;
    }
    else if ([cellType isEqualToString:payTypeCell]) {
        return 50;
    }
    else if ([cellType isEqualToString:selectCell]) {
        return 50;
    }
    else if ([cellType isEqualToString:uitableCell]) {
        return 30;
    }
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
//    if (section==0) {
//        return 15;
//    }
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *list = tableList[indexPath.section];
    NSString *cellType = list[indexPath.row];
    
    if ([cellType isEqualToString:infoCell]) {
        WOTOrderForInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForInfoCell"];
        
        if (cell == nil) {
            cell = [[WOTOrderForInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForInfoCell"];
        }
        switch ([WOTSingtleton shared].orderType) {
            case ORDER_TYPE_BOOKSTATION:
            {
                [cell.infoImg  sd_setImageWithURL:[_spaceModel.spacePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
                cell.infoTitle.text = _spaceModel.spaceName;
//                cell.dailyRentLabel.text = [NSString stringWithFormat:@"日租金：%@元",_spaceModel.on];
            }
                break;
            case ORDER_TYPE_SITE:
            case ORDER_TYPE_MEETING:
            {
                [cell.infoImg  sd_setImageWithURL:[_meetingModel.conferencePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
                cell.infoTitle.text = _meetingModel.conferenceName;
                cell.dailyRentLabel.text = _meetingModel.location;
            }
                break;
            default:
                break;
        }
            
        
        return cell;
    }
    else if ([cellType isEqualToString:selectDateCell]) {
        WOTOrderForSelectDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSelectDateCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSelectDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WOTOrderForSelectDateCell"];
        }
        [cell.dateLab setText:[self.reservationDate substringToIndex:10]];
        return cell;
    }
    else if ([cellType isEqualToString:selectTimeCell]) {
        WOTOrderForSelectTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSelectTimeCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSelectTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WOTOrderForSelectTimeCell"];
        }
        cell.delegate  =  self;
        [cell setReservationList:mettingReservationList];
        if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING ||
            [WOTSingtleton shared].orderType == ORDER_TYPE_SITE ) {
            [cell.selectTimeScroll setOpenTime:self.meetingModel.openTime];
            [cell.selectTimeScroll setBeginTime:self.beginTime endTime:self.endTime];
        }
        else {
        }
        cell.index = indexPath;
        return cell;
    }
    else if ([cellType isEqualToString:selectNumberCell]) {
        self.orderBookStationCell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForBookStationCell"];
        if (self.orderBookStationCell == nil) {
            self.orderBookStationCell = [[WOTOrderForBookStationCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForBookStationCell"];
            
        }
        self.orderBookStationCell.delegate = self;
        self.orderBookStationCell.spaceModel = self.spaceModel;
        return self.orderBookStationCell;
    }
    else if ([cellType isEqualToString:siteCell]) {
        WOTOrderForSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSiteCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSiteCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSiteCell"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:serviceCell]) {
        WOTOrderForServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForServiceInfoCell"];
        if (cell == nil) {
            cell = [[WOTOrderForServiceInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForServiceInfoCell"];
        }
//        switch ([WOTSingtleton shared].orderType) {
//            case ORDER_TYPE_BOOKSTATION:
        
        switch ([WOTSingtleton shared].orderType) {
            case ORDER_TYPE_BOOKSTATION:
            {
                cell.addressLabel.text = self.spaceModel.spaceSite;
                cell.openTimeLabel.text =@"全天";
                cell.deviceInfoLabel.text =@"无" ;
            }
                break;
            case ORDER_TYPE_MEETING:
            case ORDER_TYPE_SITE:

            {
                cell.addressLabel.text = [self.spaceModel.spaceSite stringByAppendingString:self.meetingModel.location];
                cell.openTimeLabel.text =self.meetingModel.openTime;
                cell.deviceInfoLabel.text = strIsEmpty(self.meetingModel.facility) ? @"无": self.meetingModel.facility ;
            }
                break;
            default:
                break;
        }
         
        return cell;
    }
    else if ([cellType isEqualToString:payTypeCell]) {
        WOTPaymentTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTPaymentTypeCell"];
        if (cell == nil) {
            cell = [[WOTPaymentTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTPaymentTypeCell"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:selectCell]) {
        WOTOrderForSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForSelectCell"];
        if (cell == nil) {
            cell = [[WOTOrderForSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForSelectCell"];
        }
        if (indexPath.row==1) {
            [cell.titleLab setText:@"发票信息"];
            [cell.subtitleLab setText:@"北京物联港科技发展有限公司"];
        }
        else {
            [cell.titleLab setText:@"代金券"];
            [cell.subtitleLab setText:@"无代金券可用"];
        }
        return cell;
    }
    else if ([cellType isEqualToString:uitableCell]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCelll"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCelll"];
        }
        [cell.textLabel setText:@"支付方式"];
//        cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0); // ViewWidth  [宏] 指的是手机屏幕的宽度
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
        
        return cell;
    }
    else if ([cellType isEqualToString:paymentCell]) {
        WOTOrderForPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderForPaymentCell"];
        if (cell == nil) {
            cell = [[WOTOrderForPaymentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTOrderForPaymentCell"];
        }
        if (indexPath.row == 1) {
            cell.alipay = NO;
        }
        else {
            cell.alipay = YES;
        }
        if (indexPath.row == paymentIndex.row) {
            cell.select = YES;
        }
        else {
            cell.select = YES;
        }
            
        return cell;
    }
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
    
//    if (indexPath.section==0) {
//        if (indexPath.row == 4 || indexPath.row == 5) {
//            payTypeIndex = indexPath;
////            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
////        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else if (indexPath.section == 1) {
//        if (indexPath.row == 1 || indexPath.row == 2) {
//            paymentIndex = indexPath;
//        }
//        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//    }
}

#pragma mark - 显示时间选择器
#pragma mark -WOTOrderForBookStationCell delegate
-(void)showDataPickerView:(WOTOrderForBookStationCell *)cell
{
    _datepickerview.hidden = cell.isHiddenDataPickerView;
    [self.view setNeedsLayout];
}

#pragma mark - 计算价格
-(void)imputedPriceAndLoadCost
{
    //self.orderNumber = [self.orderBookStationCell.orderNumber.text floatValue];
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_SITE ||
        [WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        CGFloat reservaionsTime = self.endTime - self.beginTime;
        self.costNumber = [self.meetingModel.conferencePrice floatValue] * reservaionsTime;
    }
    else {
         self.costNumber = self.dayNumber*[self.orderBookStationCell.orderNumber.text floatValue]*[self.spaceModel.onlineLocationPrice floatValue];
    }
    [self loadCost];
}

#pragma mark - 判断时间选择是否合理
-(void)Timedisplay:(NSString *)selectTime
{
    if ([self.judgmentTime compareDate:[self.reservationStationStartDate substringToIndex:10]
                              withDate:[self.reservationStationEndDate substringToIndex:10]]) {
        self.dayNumber = [self.judgmentTime numberOfDaysWithFromDate:selectTime toDate:self.reservationStationEndDate];
        [self imputedPriceAndLoadCost];
    }else
    {
        [MBProgressHUDUtil showMessage:@"请选择正确的时间范围！" toView:self.view];
        _datepickerview.hidden  = NO;
    }
}

#pragma mark - 验证会议室
-(void)verifyMeeting
{
    NSArray *arr = [NSString getReservationsTimesWithDate:self.reservationDate StartTime:self.beginTime  endTime:self.endTime];
    [WOTHTTPNetwork meetingReservationsWithSpaceId:self.spaceModel.spaceId
                                      conferenceId:self.meetingModel.conferenceId
                                         startTime:arr.firstObject
                                           endTime:arr.lastObject
                                         spaceName:self.spaceModel.spaceName
                                       meetingName:self.meetingModel.conferenceName
                                          response:^(id bean, NSError *error) {
                                              
                                          }];
}
#pragma mark - 验证工位
-(void)verifyBookStation
{
   // NSLog(@"测试：%@",self.productNum);
    [WOTHTTPNetwork bookStationReservationsWithSpaceId:self.spaceModel.spaceId
                                            count:@([self.orderBookStationCell.orderNumber.text integerValue])
                                             startTime:self.reservationStationStartDate
                                               endTime:self.reservationStationEndDate
                                              response:^(id bean, NSError *error) {
                                                  
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
    [WOTHTTPNetwork getBookStationNumberWithSpaceId:self.spaceModel.spaceId response:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        SKBookStationNumberModel *bookStation = bean;
        weakSelf.stationNumber = [bookStation.msg objectForKey:@"residueStationNum"];
    }];
    NSLog(@"打印工位数量：%@",self.stationNumber);
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

//-(void)request


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//    [lab setText:@"您可以在使用前2小时取消预定"];
//    [lab setTextAlignment:NSTextAlignmentCenter];
//    [view addSubview:lab];
//    [view setBackgroundColor:UIColorFromRGB(0x12fdff)];
//    return view;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
