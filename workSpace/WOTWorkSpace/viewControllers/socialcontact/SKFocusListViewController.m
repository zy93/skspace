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
@property(nonatomic,strong)NSMutableArray <SKFocusListModel_msg *>*foucusListArray;

@property (nonatomic,strong)UIImageView *notInfoImageView;
@property (nonatomic,strong)UILabel *notInfoLabel;

@end

@implementation SKFocusListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foucusListArray = [[NSMutableArray alloc] init];
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
    
    self.notInfoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotInformation"]];
    self.notInfoImageView.hidden = YES;
    [self.view addSubview:self.notInfoImageView];
    
    self.notInfoLabel = [[UILabel alloc] init];
    self.notInfoLabel.hidden = YES;
    self.notInfoLabel.text = @"亲,暂时没有关注！";
    self.notInfoLabel.textColor = [UIColor colorWithRed:145/255.f green:145/255.f blue:145/255.f alpha:1.f];
    self.notInfoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.notInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.notInfoLabel];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestFocusList];
    
}

-(void)viewDidLayoutSubviews
{
    [self.focusListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-48);
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
    NSString *httpService = [NSString stringWithFormat:@"%@/SKwork",HTTPBaseURL];
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
    circlesVC.hidesBottomBarWhenPushed = YES;
    circlesVC.userIdNum = self.foucusListArray[indexPath.row].userId;
    [self.navigationController pushViewController:circlesVC animated:YES];
}

#pragma mark - 取消关注
-(void)cancleFocus:(YMButton *)button
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否取消关注！"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *indexPath = button.appendIndexPath;
        NSNumber *focusId = self.foucusListArray[indexPath.row].focusId;
        [WOTHTTPNetwork deleteFocusWithFocusId:focusId response:^(id bean, NSError *error) {
            WOTBaseModel *baseModel = (WOTBaseModel *)bean;
            if ([baseModel.code isEqualToString:@"200"]) {
                [MBProgressHUD showMessage:@"取消成功！" toView:self.view hide:YES afterDelay:0.8f complete:^{
                    [self requestFocusList];
                }];
            } else {
                [MBProgressHUDUtil showMessage:@"取消失败！" toView:self.view];
            }
        }];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)loadNewData
{
    [self requestFocusList];
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
           
            self.foucusListArray = [[NSMutableArray alloc] initWithArray:baseModel.msg];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.notInfoImageView.hidden = YES;
                self.notInfoLabel.hidden = YES;
               [self.focusListTableView reloadData];
            });
        } else {
            if ([baseModel.code isEqualToString:@"202"]) {
               
                if (_foucusListArray.count>0) {
                    [self.foucusListArray removeAllObjects];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.notInfoImageView.hidden = NO;
                    self.notInfoLabel.hidden = NO;
                    [self.focusListTableView reloadData];
                    [MBProgressHUDUtil showMessage:@"还未关注其他人！" toView:self.view];
                });
                return ;
            }
            else
            {
                self.notInfoImageView.hidden = NO;
                self.notInfoLabel.hidden = NO;
                [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
                return ;
            }
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPDATEFocusListNOTIFICATION" object:self];
}


@end
