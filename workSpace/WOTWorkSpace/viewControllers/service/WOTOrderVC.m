//
//  WOTOrderVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderVC.h"
#import "WOTOrderForInfoCell.h"
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

#define infoCell @"infoCell"
#define bookStationCell @"bookStationCell"
#define serviceCell @"serviceCell"
#define payTypeCell @"payTypeCell"
#define selectCell @"selectCell"
#define siteCell @"siteCell"
#define amountCell @"amountCell"
#define uitableCell @"uitableCell"
#define paymentCell @"paymentCell"

@interface WOTOrderVC () <UITableViewDataSource, UITableViewDelegate,WOTOrderForBookStationCellDelegate>
{
    NSArray *tableList;
    
    NSIndexPath *payTypeIndex;//个人、企业支付
    NSIndexPath *paymentIndex;//微信、支付宝支付
    
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (nonatomic, strong)WOTDatePickerView *datepickerview;
@property (nonatomic, assign)BOOL isValidTime;
@property (nonatomic, strong) JudgmentTime *judgmentTime;
@property (nonatomic, strong)WOTOrderForBookStationCell *orderBookStationCell;
@property (nonatomic, assign)NSInteger dayNumber;
@property (nonatomic, assign)NSNumber *productNum;
@property (nonatomic, assign)float orderNumber;

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
    [self configNav];
    [self loadData];
    [self loadCost];
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
    self.navigationItem.title = @"确认订单";
    self.navigationController.navigationBar.translucent = NO;
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)creatDataPickerView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    //[_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - [WOTUitls GetLengthAdaptRate]*300, self.view.frame.size.width, 300)];
     [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSString *selecTime = [NSString stringWithFormat:@"%ld/%ld/%ld",year, month, day];
        weakSelf.isValidTime = [weakSelf.judgmentTime judgementTimeWithYear:year month:month day:day];
        
        if (weakSelf.isValidTime) {
            weakSelf.datepickerview.hidden  = YES;
                [weakSelf Timedisplay:selecTime];
            
        }else
        {
            [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:weakSelf.view];
            weakSelf.datepickerview.hidden  = NO;
        }
       // [weakSelf reloadView];
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
            list1 = @[infoCell, bookStationCell, serviceCell, payTypeCell, selectCell, selectCell];
            
        }
            break;
        case ORDER_TYPE_MEETING:
        case ORDER_TYPE_SITE:
        {
            list1 = @[infoCell, siteCell, serviceCell, payTypeCell, selectCell, selectCell];
            
        }
            break;
        default:
            break;
    }
    
    NSArray *list2 = @[uitableCell,paymentCell];
    tableList = @[list1, list2];
}

-(void)loadCost
{
    [_costLabel setText:[NSString stringWithFormat:@"实付：￥%.2f",self.costNumber]];
}


#pragma mark - action-- 支付按钮
- (IBAction)clickSubmitBtn:(id)sender {
    //判断用户是否登录
    if (![WOTUserSingleton shareUser].userInfo.userId) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未登录" message:@"请先登录用户" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"跳转到");
            [[WOTConfigThemeUitls shared] showLoginVC:self];
//            WOTLoginVC *loginVC = [[WOTLoginVC alloc] init];
//            [self.navigationController pushViewController:loginVC animated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (self.costNumber == 0.0) {
        [MBProgressHUDUtil showMessage:@"订单金额为0无法支付" toView:self.view];
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
        {
            [self verifyMeeting];
            self.productNum = @(1);
            commNum = self.meetingModel.conferenceId;
            commKind = @(1);
        }
            break;
        case ORDER_TYPE_SITE:
        {
            [self verifySite];
            self.productNum = @(1);
            commNum = self.siteModel.siteId;
            commKind = @(2);
        }
            break;
        default:
            break;
    }
    [MBProgressHUDUtil showLoadingWithMessage:@"支付中，请稍后...."
                                       toView:self.view
                           whileExcusingBlock:^(MBProgressHUD *hud) {
                               [WOTHTTPNetwork generateOrderWithSpaceId:self.spaceModel.spaceId
                                                           commodityNum:commNum
                                                          commodityKind:commKind
                                                             productNum:self.productNum
                                                              startTime:self.startTime
                                                                endTime:self.endTime
                                                                  money:self.costNumber
                                                               dealMode:dealMode
                                                                payType:@(1)
                                                              payObject:[WOTUserSingleton shareUser].userInfo.userName payMode:@(1) contractMode:@(1) response:^(id bean, NSError *error) {
                                                                  //[hud h];
                                                                  [hud setHidden:YES];
                                                              }];
                           }];
    
    /*
    switch ([WOTSingtleton shared].orderType) {
        case ORDER_TYPE_BOOKSTATION:
        {
            
        }
            break;
        case ORDER_TYPE_MEETING:
        {
            [WOTHTTPNetwork meetingReservationsWithSpaceId:self.spaceId conferenceId:self.conferenceOrSiteId startTime:self.startTime endTime:self.endTime response:^(id bean, NSError *error) {
                NSLog(@"---%@", bean);
            }];
        }
            break;
        case ORDER_TYPE_SITE:
        {
            
//            [WOTHTTPNetwork siteReservationsWithSpaceId:self.spaceId siteId:self.conferenceOrSiteId startTime:self.startTime endTime:self.endTime response:^(id bean, NSError *error) {
//                NSLog(@"---%@", bean);
//            }];
            
            NSNumber *commNum = @(0);
            NSNumber *commKind = @(0);
            NSString *dealMode = @"微信支付";
            switch ([WOTSingtleton shared].orderType) {
                case ORDER_TYPE_BOOKSTATION:
                {
                    commNum = @(10000);;
                    commKind = @(0);
                }
                    break;
                case ORDER_TYPE_MEETING:
                {
                    commNum = self.meetingModel.conferenceId;
                    commKind = @(1);
                }
                    break;
                case ORDER_TYPE_SITE:
                {
                    commNum = self.siteModel.siteId;
                    commKind = @(2);
                }
                    break;
                default:
                    break;
            }
            [WOTHTTPNetwork generateOrderWithSpaceId:self.spaceId commodityNum:commNum commodityKind:commKind productNum:@(1) startTime:self.startTime endTime:self.endTime money:self.costNumber dealMode:dealMode payType:@(1) payObject:[WOTUserSingleton shareUser].userInfo.userName payMode:@(1) contractMode:@(1) response:^(id bean, NSError *error) {
                
            }];
        }
            
            break;
        default:
            break;
    }
     */
             
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
        return 198;
    }
    else if ([cellType isEqualToString:bookStationCell]) {
        return 169;
    }
    else if ([cellType isEqualToString:siteCell]) {
        return 65;
    }
    else if ([cellType isEqualToString:serviceCell]) {
        return 176;
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
            }
                break;
            case ORDER_TYPE_MEETING:
            {
                [cell.infoImg  sd_setImageWithURL:[_meetingModel.conferencePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
                cell.infoTitle.text = _meetingModel.conferenceName;
            }
                break;
            case ORDER_TYPE_SITE:
            {
                [cell.infoImg  sd_setImageWithURL:[_siteModel.sitePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
                cell.infoTitle.text = _siteModel.siteName;
            }
                break;
            default:
                break;
        }
            
        
        return cell;
    }
    else if ([cellType isEqualToString:bookStationCell]) {
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
        //
        [cell.reservationsDateLab setText:[self.startTime substringWithRange:NSMakeRange(0, 10)]];
        NSString *str = [NSString stringWithFormat:@"%@-%@",
                         [self.startTime substringWithRange:NSMakeRange(11, 5)],
                         [self.endTime   substringWithRange:NSMakeRange(11, 5)]];
        
        [cell.reservationsTimeLab setText:str];
        
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
                cell.addressLabel.text = self.spaceModel.spaceSite ;
                cell.openTimeLabel.text =@"全天";
                cell.deviceInfoLabel.text =@"无" ;
            }
                break;
            case ORDER_TYPE_MEETING:
            {
                cell.addressLabel.text = [self.spaceModel.spaceSite stringByAppendingString:self.meetingModel.location];
                cell.openTimeLabel.text = [self.meetingModel.openTime stringByAppendingString:@"开放"];
                cell.deviceInfoLabel.text = self.meetingModel.facility;
            }
                break;
            case ORDER_TYPE_SITE:
            {
                cell.addressLabel.text =[self.spaceModel.spaceSite stringByAppendingString:self.siteModel.location];
                cell.openTimeLabel.text = [self.siteModel.openTime stringByAppendingString:@"开放"];
                cell.deviceInfoLabel.text = self.siteModel.facility;
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
        if (indexPath.row==4) {
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
        [cell.textLabel setText:@"电子支付"];
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
    if (indexPath.section==0) {
        if (indexPath.row == 4 || indexPath.row == 5) {
            payTypeIndex = indexPath;
//            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
//        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            paymentIndex = indexPath;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
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
    self.costNumber = self.dayNumber*[self.orderBookStationCell.orderNumber.text floatValue]*[self.spaceModel.stationPrice floatValue];
    [self loadCost];
}

#pragma mark - 判断时间选择是否合理
-(void)Timedisplay:(NSString *)selectTime
{
    BOOL isStartTime = [self.orderBookStationCell.startDataLable.text isEqualToString:@"请选择"];
    BOOL isEndTime = [self.orderBookStationCell.startDataLable.text isEqualToString:@"请选择"];
//    BOOL isEqualToStartTimeWithEndTime =[self.orderBookStationCell.startDataLable.text isEqualToString:selectTime];
    switch ([WOTSingtleton shared].buttonType) {
        case BUTTON_TYPE_STARTTIME:
        {
            if (isEndTime) {
                self.orderBookStationCell.startDataLable.text = selectTime;
            }else
            {
                if ([self.judgmentTime compareDate:selectTime withDate:self.orderBookStationCell.endDataLabel.text]) {
                    self.dayNumber = [self.judgmentTime numberOfDaysWithFromDate:selectTime toDate:self.orderBookStationCell.endDataLabel.text];
                    [self imputedPriceAndLoadCost];
                    self.orderBookStationCell.startDataLable.text = selectTime;
                }else
                {
                    [MBProgressHUDUtil showMessage:@"请选择小于等于结束时间的时间！" toView:self.view];
                    _datepickerview.hidden  = NO;
                }
            }
        }
            break;
        case BUTTON_TYPE_ENDTIME:
        {
            if (isStartTime) {
                self.orderBookStationCell.endDataLabel.text = selectTime;
            }else
            {
                if ([self.judgmentTime compareDate:self.orderBookStationCell.startDataLable.text withDate:selectTime]) {
                    self.dayNumber = [self.judgmentTime numberOfDaysWithFromDate:self.orderBookStationCell.startDataLable.text toDate:selectTime];
                    [self imputedPriceAndLoadCost];
                    self.orderBookStationCell.endDataLabel.text = selectTime;
                } else {
                    [MBProgressHUDUtil showMessage:@"请选择大写等于开始时间的时间！" toView:self.view];
                    _datepickerview.hidden  = NO;
                }
            }
        }
            
        default:
            break;
    }
    
}

#pragma mark - 数量变化
-(void)changeValue:(WOTOrderForBookStationCell *)cell
{
    BOOL isStartTime = [cell.startDataLable.text isEqualToString:@"请选择"];
    BOOL isEndTime = [cell.startDataLable.text isEqualToString:@"请选择"];
    if ((!isStartTime) && (!isEndTime)) {
        [self imputedPriceAndLoadCost];
    }
}


#pragma mark - 验证会议室
-(void)verifyMeeting
{
    [WOTHTTPNetwork meetingReservationsWithSpaceId:self.spaceModel.spaceId
                                      conferenceId:self.meetingModel.conferenceId
                                         startTime:self.startTime
                                           endTime:self.endTime
                                         spaceName:self.spaceModel.spaceName
                                       meetingName:self.meetingModel.conferenceName
                                          response:^(id bean, NSError *error) {
                                              
                                          }];
}

#pragma mark - 验证场地
-(void)verifySite
{
    [WOTHTTPNetwork siteReservationsWithSpaceId:self.spaceModel.spaceId
                                         siteId:self.siteModel.siteId
                                      startTime:self.startTime
                                        endTime:self.endTime
                                      spaceName:self.spaceModel.spaceName
                                       siteName:self.siteModel.siteName
                                       response:^(id bean, NSError *error) {
                                           
                                       }];
}

#pragma mark - 验证工位
-(void)verifyBookStation
{
   // NSLog(@"测试：%@",self.productNum);
    [WOTHTTPNetwork bookStationReservationsWithSpaceId:self.spaceModel.spaceId
                                                 count:@([self.orderBookStationCell.orderNumber.text integerValue])
                                             startTime:self.orderBookStationCell.startDataLable.text
                                               endTime:self.orderBookStationCell.endDataLabel.text
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
