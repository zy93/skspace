//
//  WOTOrderLIstBaseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTOrderLIstBaseVC.h"
#import "WOTMeetingHistoryModel.h"
#import "WOTWorkStationHistoryModel.h"
#import "WOTOrderCell.h"
@interface WOTOrderLIstBaseVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *tableList;
@end

@implementation WOTOrderLIstBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderCell" bundle:nil] forCellReuseIdentifier:@"orderlistCellID"];
    // Do any additional setup after loading the view.
    [self AddRefreshHeader];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self StartRefresh];
}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UIScrollView *pTableView = self.tableView;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    if (self.tableView.mj_footer != nil && [self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
    [self createRequest];
}

- (void)StopRefresh
{
    if (self.tableView.mj_header != nil && [self.tableView.mj_header isRefreshing])
    {
        [self.tableView.mj_header endRefreshing];
    }
}
#pragma mark - request
-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    switch (self.orderlisttype) {
        case WOTPageMenuVCTypeSite:
        {
            [WOTHTTPNetwork getUserSiteOrderResponse:^(id bean, NSError *error) {
                WOTMeetingHistoryModel_msg *model = bean;
                [self StopRefresh];
                if ([model.code isEqualToString:@"200"]) {
                    weakSelf.tableList = model.msg.list;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                    });
                }
                else {
                    [MBProgressHUDUtil showMessage:model.result toView:self.view];
                }
            }];
        }
            break;
        case WOTPageMenuVCTypeMetting:
        {
            [WOTHTTPNetwork getUserMeetingOrderResponse:^(id bean, NSError *error) {
                WOTMeetingHistoryModel_msg *model = bean;
                [self StopRefresh];
                if ([model.code isEqualToString:@"200"]) {
                    weakSelf.tableList = model.msg.list;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                    });
                }
                else {
                    [MBProgressHUDUtil showMessage:model.result toView:self.view];
                }
            }];
        }
            break;
        case WOTPageMenuVCTypeStation:
        {
            [WOTHTTPNetwork getUserWorkStationOrderResponse:^(id bean, NSError *error) {
                WOTMeetingHistoryModel_msg *model = bean;
                [self StopRefresh];
                if ([model.code isEqualToString:@"200"]) {
                    weakSelf.tableList = model.msg.list;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                    });
                }
                else {
                    [MBProgressHUDUtil showMessage:model.result toView:self.view];
                }
            }];
        }
            break;
        default:
            break;
    }
    
}


#pragma mark - table delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    WOTOrderCell *cell = (WOTOrderCell *)[tableView dequeueReusableCellWithIdentifier:@"orderlistCellID"];
    switch (_orderlisttype) {
        case WOTPageMenuVCTypeMetting:
        {
            WOTMeetingHistoryModel *model = self.tableList[indexPath.row];
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeLabel,cell.dateLabel,cell.timeLabel,cell.moneyLabel, nil]  withTexts:@[@"预定地点",@"预定时间",@"下单时间",@"金额总数"]];
            NSString *loca = [NSString stringWithFormat:@"%@",model.spaceName];
            NSString *starTime = [NSString stringWithFormat:@"%@",[model.startTime substringToIndex:16]];
            NSString *endTime  = [NSString stringWithFormat:@"%@",[model.endTime substringToIndex:16]];
            NSString *money = [NSString stringWithFormat:@"￥%.2f",model.conferencePrice.floatValue];
        [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeValue,cell.dateValue,cell.timeValue,cell.moneyValue, nil]  withTexts:@[loca,starTime,endTime,money]];
            
        }
            break;
        case WOTPageMenuVCTypeStation:
        {
            WOTWorkStationHistoryModel *model = self.tableList[indexPath.row];
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeLabel,cell.dateLabel,cell.timeLabel,cell.moneyLabel, nil]  withTexts:@[@"预定地点",@"预定时间",@"预定数量",@"金额总数"]];
            
//            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeValue,cell.dateValue,cell.timeValue,cell.moneyValue, nil]  withTexts:@[@"方圆大厦优客工场",@"2017-06-30 12:34:56",@"34量",@"¥5456"]];
            NSString *loca = [NSString stringWithFormat:@"%@",model.spaceName];
            NSString *starTime = [NSString stringWithFormat:@"%@",[model.starTime substringToIndex:16]];
            NSString *endTime  = [NSString stringWithFormat:@"%@",[model.endTime substringToIndex:16]];
            NSString *money = [NSString stringWithFormat:@"￥%.2f",model.money.floatValue];
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeValue,cell.dateValue,cell.timeValue,cell.moneyValue, nil]  withTexts:@[loca,starTime,endTime,money]];

        }
            case WOTPageMenuVCTypeSite:
        {
            WOTWorkStationHistoryModel *model = self.tableList[indexPath.row];
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeLabel,cell.dateLabel,cell.timeLabel,cell.moneyLabel, nil]  withTexts:@[@"预定地点",@"预定时间",@"预定数量",@"金额总数"]];
            NSString *loca = [NSString stringWithFormat:@"%@",model.spaceName];
            NSString *starTime = [NSString stringWithFormat:@"%@",[model.starTime substringToIndex:16]];
            NSString *endTime  = [NSString stringWithFormat:@"%@",[model.endTime substringToIndex:16]];
            NSString *money = [NSString stringWithFormat:@"￥%.2f",model.money.floatValue];
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeValue,cell.dateValue,cell.timeValue,cell.moneyValue, nil]  withTexts:@[loca,starTime,endTime,money]];
        }
           
        default:
            break;
    }
//    if (!cell) {
//      
//        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"WOTOrderCell" owner:nil options:nil];
//        for (id obj in nibArray) {
//            if ([obj isMemberOfClass:[WOTOrderCell class]]) {
//                // Assign cell to obj
//                cell = (WOTOrderCell *)obj;
//                break;
//            }
//        }
//    }
    
    return cell;
    
    
}

-(void)createData{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
