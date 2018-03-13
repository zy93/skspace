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
#import "WOTMyOrderInfoCell.h"
#import "WOTOrderDetailVC.h"
@interface WOTOrderLIstBaseVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *tableList;
@end

@implementation WOTOrderLIstBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderCell" bundle:nil] forCellReuseIdentifier:@"orderlistCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderInfoCell" bundle:nil] forCellReuseIdentifier:@"WOTMyOrderInfoCell"];

    // Do any additional setup after loading the view.
    [self AddRefreshHeader];
    [self StartRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    NSArray *arr = @[@"全部订单", @"会议室", @"工位", @"场地", @"礼包"];
    __weak typeof(self) weakSelf = self;

    [WOTHTTPNetwork getUserOrderWithType:self.orderlisttype==WOTPageMenuVCTypeAll?nil:arr[self.orderlisttype] response:^(id bean, NSError *error) {
            WOTWorkStationHistoryModel_msg *model = bean;
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


#pragma mark - table delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115*[WOTUitls GetLengthAdaptRate];
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
    WOTMyOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyOrderInfoCell"];
    WOTWorkStationHistoryModel *model = self.tableList[indexPath.row];
    cell.titleLab.text = model.commodityKind;
    cell.subtitleLab.text = [NSString stringWithFormat:@"%@·%@",model.spaceName, model.commodityName];
    [cell.bgIV setImageWithURL:[model.imageSite ToResourcesUrl]];
    [cell setupViews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WOTOrderDetailVC *vc = [[WOTOrderDetailVC alloc] init];
    WOTWorkStationHistoryModel *model = self.tableList[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
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
