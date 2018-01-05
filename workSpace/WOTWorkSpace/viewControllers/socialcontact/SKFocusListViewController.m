//
//  SKFocusListViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKFocusListViewController.h"
#import "Masonry.h"
#import "SKFocusListTableViewCell.h"
#import "WOTHTTPNetwork.h"
#import "WOTUserSingleton.h"
#import "SKFocusListModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SKFocusCirclesViewController.h"

@interface SKFocusListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *focusListTableView;
@property(nonatomic,strong)NSArray <SKFocusListModel_msg *>*foucusListArray;

@end

@implementation SKFocusListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestFocusList];
    self.foucusListArray = [[NSArray alloc] init];
    self.focusListTableView = [[UITableView alloc] init];
    self.focusListTableView.delegate = self;
    self.focusListTableView.dataSource = self;
    self.focusListTableView.estimatedRowHeight = 0;
    [self.focusListTableView setTableFooterView:[UIView new]];
    [self.focusListTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.focusListTableView setLayoutMargins:UIEdgeInsetsZero];
    self.focusListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.focusListTableView.mj_header beginRefreshing];
    [self.view addSubview:self.focusListTableView];
    
}

-(void)viewDidLayoutSubviews
{
    [self.focusListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-48);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.foucusListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKFocusListTableViewCell";
    SKFocusListTableViewCell *cell = (SKFocusListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SKFocusListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.cancelFocusButton.appendIndexPath = indexPath;
    NSString *httpService = @"http://219.143.170.98:10011/SKwork";
    [cell.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpService,self.foucusListArray[indexPath.row].heard]] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
    cell.userName.text = self.foucusListArray[indexPath.row].userName;
    cell.userCompany.text = self.foucusListArray[indexPath.row].companyName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.cancelFocusButton addTarget:self action:@selector(cancleFocus:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKFocusCirclesViewController *circlesVC = [[SKFocusCirclesViewController alloc]init];
    circlesVC.userIdNum = self.foucusListArray[indexPath.row].userId;
    [self.navigationController pushViewController:circlesVC animated:YES];
}

#pragma mark - 取消关注
-(void)cancleFocus:(YMButton *)button
{
    NSIndexPath *indexPath = button.appendIndexPath;
    NSNumber *focusId = self.foucusListArray[indexPath.row].focusId;
    [WOTHTTPNetwork deleteFocusWithFocusId:focusId response:^(id bean, NSError *error) {
        WOTBaseModel *baseModel = (WOTBaseModel *)bean;
        if ([baseModel.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"取消成功！" toView:self.view];
            [self requestFocusList];
        } else {
            [MBProgressHUDUtil showMessage:@"取消失败！" toView:self.view];
        }
    }];
}

-(void)loadNewData
{
    [self requestFocusList];
    [self.focusListTableView reloadData];
    [self.focusListTableView.mj_header endRefreshing];
}


#pragma mark - 请求关注人列表
-(void)requestFocusList
{
    if ([WOTUserSingleton shareUser].userInfo.userId == nil) {
        [MBProgressHUDUtil showMessage:@"请先登录再查看" toView:self.view];
        return;
    }
    [WOTHTTPNetwork queryFocusOnPeopleWithFocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId  response:^(id bean, NSError *error) {
        SKFocusListModel *baseModel = (SKFocusListModel *)bean;
        if ([baseModel.code isEqualToString:@"200"]) {
            self.foucusListArray = baseModel.msg;
            [self.focusListTableView reloadData];
        } else {
            
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
