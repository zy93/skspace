//
//  WOTMyRepairdListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyRepairdListVC.h"
#import "WOTMyRepairdCell.h"
#import "WOTRepairHistoryModel.h"
#import "WOTRepairdHistoryDetailVC.h"

@interface WOTMyRepairdListVC () <UITableViewDataSource, UITableViewDelegate, WOTMyRepairdCellDelegate>
@property (nonatomic, strong) NSArray * tableList;
@end

@implementation WOTMyRepairdListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyRepairdCell" bundle:nil] forCellReuseIdentifier:@"WOTMyRepairdCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.navigationItem.title = @"报修记录";
    [self AddRefreshHeader];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self createRequest];
    __weak UIScrollView *_scrollView = self.tableView;
    if (_scrollView.mj_footer != nil && [_scrollView.mj_footer isRefreshing])
    {
        [_scrollView.mj_footer endRefreshing];
    }
    
    
}

- (void)StopRefresh
{
    __weak UIScrollView *_scrollView = self.tableView;
    if (_scrollView.mj_header != nil && [_scrollView.mj_header isRefreshing])
    {
        [_scrollView.mj_header endRefreshing];
    }
}

#pragma mark - request
-(void)createRequest
{
    [WOTHTTPNetwork getUserRepairHistoryResponse:^(id bean, NSError *error) {
        WOTRepairHistoryModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            self.tableList = model.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        [self StopRefresh];
    }];
}

#pragma mark - cell delegate
-(void)repairdCell:(WOTMyRepairdCell *)cell btnClick:(NSIndexPath *)index
{
    WOTRepairdHistoryDetailVC *vc = [[WOTRepairdHistoryDetailVC alloc] init];
    vc.model = self.tableList[index.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delegate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyRepairdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyRepairdCell" forIndexPath:indexPath];
    WOTRepairHistoryModel *model = self.tableList[indexPath.row];
    cell.repairdTimeValueLab.text = [model.sorderTime substringToIndex:16];
    cell.repairdAddrValueLab.text = model.address;
    cell.repairdContentValueLab.text = model.info;
    cell.repairdTypeValueLab.text = model.type;
    cell.delegate = self;
    cell.index = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
