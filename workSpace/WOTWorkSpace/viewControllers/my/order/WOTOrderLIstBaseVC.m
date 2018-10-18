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
#import "WOTAllOrderListVC.h"
@interface WOTOrderLIstBaseVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *tableList;
@property (nonatomic,strong)UIImageView *notInfoImageView;
@property (nonatomic,strong)UILabel *notInfoLabel;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation WOTOrderLIstBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderCell" bundle:nil] forCellReuseIdentifier:@"orderlistCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderInfoCell" bundle:nil] forCellReuseIdentifier:@"WOTMyOrderInfoCell"];

    // Do any additional setup after loading the view.
    self.notInfoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotInformation"]];
    self.notInfoImageView.hidden = YES;
    [self.view addSubview:self.notInfoImageView];
    
    self.notInfoLabel = [[UILabel alloc] init];
    self.notInfoLabel.hidden = YES;
    self.notInfoLabel.text = @"亲,暂时没有订单！";
    self.notInfoLabel.textColor = [UIColor colorWithRed:145/255.f green:145/255.f blue:145/255.f alpha:1.f];
    self.notInfoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.notInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.notInfoLabel];
    [self layoutSubviews];
    
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
    }];
    [self.notInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-50);
        make.height.width.mas_offset(70);
    }];
    
    [self.notInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.notInfoImageView.mas_bottom).with.offset(10);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self createRequest];
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
    NSArray *arr = @[@"全部订单", @"会议室", @"工位",@"长租工位", @"场地", @"礼包"];
    __weak typeof(self) weakSelf = self;
    if (self.tableView.mj_footer != nil && [self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
    [WOTHTTPNetwork getUserOrderWithType:self.orderlisttype==WOTPageMenuVCTypeAll?nil:arr[self.orderlisttype] response:^(id bean, NSError *error) {
            WOTWorkStationHistoryModel_msg *model = bean;
            [self StopRefresh];
            if ([model.code isEqualToString:@"200"]) {
                
                weakSelf.tableList = model.msg.list;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.notInfoImageView.hidden = YES;
                    self.notInfoLabel.hidden = YES;
                    [weakSelf.tableView reloadData];
                });
            }
            else {
                self.notInfoImageView.hidden = NO;
                self.notInfoLabel.hidden = NO;
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
    
    if ([model.commodityKind isEqualToString:@"礼包"] || [model.commodityKind isEqualToString:@"长租工位"]) {
        cell.billStateLabel.hidden = NO;
        cell.billStateLabel.text = [NSString stringWithFormat:@"开票状态：%@",model.invoiceState];
    }else
    {
        cell.billStateLabel.hidden = YES;
    }
    
    if ([model.commodityKind isEqualToString:@"会议室"]) {
        [cell.iconIV setImage:[UIImage imageNamed:@"order_meeting"]];
    }
    else if ([model.commodityKind isEqualToString:@"场地"]) {
        [cell.iconIV setImage:[UIImage imageNamed:@"order_site"]];
    }
    else if ([model.commodityKind isEqualToString:@"工位"]) {
        [cell.iconIV setImage:[UIImage imageNamed:@"order_station"]];
    }
    else if ([model.commodityKind isEqualToString:@"礼包"]) {
        [cell.iconIV setImage:[UIImage imageNamed:@"order_gift_bag"]];
    }
    
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

@end
