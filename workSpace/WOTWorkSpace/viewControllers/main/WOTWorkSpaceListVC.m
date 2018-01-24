//
//  WOTworkSpaceLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTWorkSpaceListVC.h"
#import "WOTworkSpaceSearchCell.h"
#import "WOTworkSpaceScrollVIewCell.h"
#import "WOTNearbySapceCell.h"
#import "WOTworkSpaceCommonCell.h"
#import "WOTSpaceCityScrollView.h"
#import "WOTH5VC.h"
#import "MJRefresh.h"
#import "WOTCityModel.h"
#import "WOTRefreshControlUitls.h"
@interface WOTWorkSpaceListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, WOTSpaceCityScrollViewDelegate>{
    NSInteger citySelectedIndex;
}

@property(nonatomic,strong)WOTSpaceCityScrollView *headerView;
@end

@implementation WOTWorkSpaceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.tableVIew.backgroundColor = UICOLOR_CLEAR;
    self.tableVIew.showsVerticalScrollIndicator = NO;
   
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"WOTSpaceCityScrollView" owner:nil options:nil].lastObject;
    [self configNav];
    [_tableVIew registerNib:[UINib nibWithNibName:@"WOTworkSpaceSearchCell" bundle:nil] forCellReuseIdentifier:@"WOTworkSpaceSearchCellID"];
    [_tableVIew registerNib:[UINib nibWithNibName:@"WOTworkSpaceCommonCell" bundle:nil] forCellReuseIdentifier:@"WOTworkSpaceCommonCellID"];
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [self AddRefreshHeader];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    [self createRequest];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

-(void)configNav{
    
    [self configNaviBackItem];
    self.navigationItem.title = @"空间列表";
   
}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */

- (void)AddRefreshHeader
{
    __weak UITableView *pTableView = _tableVIew;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark - 开发刷新
- (void)StartRefresh
{
    if (_tableVIew.mj_footer != nil && [_tableVIew.mj_footer isRefreshing])
    {
        [_tableVIew.mj_footer endRefreshing];
    }
    [self createRequest];
}

- (void)StopRefresh
{
    if (_tableVIew.mj_header != nil && [_tableVIew.mj_header isRefreshing])
    {
        [_tableVIew.mj_header endRefreshing];
    }
}


#pragma mark - 请求数据
-(void)createRequest{
    [self getCityListRequest];
    [self getSpaceRequestWithCityName:nil];
}

-(void)getCityListRequest
{
    [WOTHTTPNetwork getCityListResponse:^(id bean, NSError *error) {
        WOTCityModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            NSMutableArray *cityarr = [@[@"全部"] mutableCopy];
            [cityarr addObjectsFromArray:model.msg];
            self.headerView.cityList = cityarr;
        }
        else {
            [MBProgressHUDUtil showMessage:strIsEmpty(model.result)?error.localizedDescription:model.result toView:self.view];
        }
    }];
}

-(void)getSpaceRequestWithCityName:(NSString *)cityName
{
    [WOTHTTPNetwork getAllSpaceWithCity:cityName block:^(id bean, NSError *error) {
        WOTSpaceModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            _dataSource = model.msg.list;
        }
        else {
            [MBProgressHUDUtil showMessage:strIsEmpty(model.result)?error.localizedDescription:model.result toView:self.view];
        }
        [self StopRefresh];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableVIew reloadData];
        });
    }];
}

#pragma mark - spaceCityView delegate
-(void)spaceCityScrollView:(WOTSpaceCityScrollView *)scrollView selectCity:(NSString *)cityName
{
    if ([cityName isEqualToString:@"全部"]) {
        cityName = nil;
    }
    [self getSpaceRequestWithCityName:cityName];
}



#pragma mark - table dataSource & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _dataSource.count;
            break;
            
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 100;
            break;
        case 1:
            return 250;
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 60;
            
        default:
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView.selectedindex = citySelectedIndex;
    _headerView.delegate = self;
    return _headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        WOTNearbySapceCell *nearcell = [tableView dequeueReusableCellWithIdentifier:@"WOTNearbySapceCell" forIndexPath:indexPath];
        //
        nearcell.spaceNameLab.text = [WOTSingtleton shared].nearbySpace.spaceName;
        NSLog(@"*********------%@", [WOTSingtleton shared].nearbySpace.spaceName);
        nearcell.spaceSubtitleLab.text = [WOTSingtleton shared].nearbySpace.spaceDescribe;
        cell = nearcell;
    } else{
        WOTworkSpaceCommonCell *spacecell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpaceCommonCellID" forIndexPath:indexPath];
        spacecell.lineVIew.hidden = indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1 ? YES:NO;
        spacecell.workSpaceName.text = _dataSource[indexPath.row].spaceName;
        spacecell.workSpaceLocation.text = _dataSource[indexPath.row].spaceSite;
        spacecell.stationNum.text = [_dataSource[indexPath.row].fixPhone stringByAppendingString:@"工位可预订"];
        NSArray *arr = [_dataSource[indexPath.row].spacePicture componentsSeparatedByString:@","];
        [spacecell.workSpaceImage setImageWithURL:[arr.lastObject ToResourcesUrl]];
        cell = spacecell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    [self.navigationController pushViewController:detailvc animated:YES];
}

#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - 懒加载

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

