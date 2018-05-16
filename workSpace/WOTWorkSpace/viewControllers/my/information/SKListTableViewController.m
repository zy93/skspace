//
//  SKListTableViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKListTableViewController.h"
#import "WOTHTTPNetwork.h"
#import "SKListTableViewCell.h"
#import "SKMyDemandModel.h"
#import "SKMyEnterModel.h"

#import "SKReserveInfoTableViewController.h"
#import "SKDemandInfoViewController.h"
@interface SKListTableViewController ()
@property(nonatomic,strong)NSMutableArray *infoListArray;
@end

@implementation SKListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoListArray = [[NSMutableArray alloc] init];
    if (self.notificationType ==NOTIFICATION_TYPE_ENTER) {
        [self queryAppointmentEnter];
        self.navigationItem.title = @"申请入驻信息";
    }else
    {
        [self queryDemandList];
        self.navigationItem.title = @"我的需求";
    }
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKListTableViewCell"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKListTableViewCell"];
    if (self.notificationType == NOTIFICATION_TYPE_ENTER) {
        SKMyEnterModel *model = self.infoListArray[indexPath.row];
        cell.topLabel.text = @"预约项目：";
        cell.topInfoLabel.text = model.spaceName;
        cell.bottomLabel.text = @"预约时间：";
        cell.bottomInfoLabel.text = model.appointmentTime;
    }else
    {
        SKMyDemandModel *model = self.infoListArray[indexPath.row];
        cell.topLabel.text = @"需求类型：";
        cell.topInfoLabel.text = model.demandType;
        cell.bottomLabel.text = @"需求内容：";
        cell.bottomInfoLabel.text = model.demandContent;
    }
    cell.seeDetailsButton.tag = indexPath.row;
    [cell.seeDetailsButton addTarget:self action:@selector(clickSeeDetails:) forControlEvents:UIControlEventTouchDown];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 点击查看详情
-(void)clickSeeDetails:(UIButton *)button
{
    
    if (self.notificationType == NOTIFICATION_TYPE_ENTER) {
        SKMyEnterModel *model = self.infoListArray[button.tag];
        SKReserveInfoTableViewController *enterVC = [[SKReserveInfoTableViewController alloc] init];
        enterVC.enterModel = model;
        enterVC.enterInterfaceType = ENTER_INTERFACE_TYPE_SHOW;
        [self.navigationController pushViewController:enterVC animated:YES];
    }else
    {
        SKMyDemandModel *model = self.infoListArray[button.tag];
        SKDemandInfoViewController *demandVC = [[SKDemandInfoViewController alloc] init];
        demandVC.typeString = model.demandType;
        demandVC.contentString = model.demandContent;
        [self.navigationController pushViewController:demandVC animated:YES];
    }
}


#pragma mark - 请求预约入驻列表
-(void)queryAppointmentEnter
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork queryMyEnterInfoResponse:^(id bean, NSError *error) {
        SKMyEnterModel_msg *model = (SKMyEnterModel_msg *)bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.infoListArray = [model.msg.list mutableCopy];
            [weakSelf.tableView reloadData];
        }else
        {
            [MBProgressHUDUtil showMessage:@"没有消息！" toView:self.view];
        }
    }];
}

#pragma mark - 需求消息列表
-(void)queryDemandList
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork queryMyDemandResponse:^(id bean, NSError *error) {
        SKMyDemandModel_msg *model = (SKMyDemandModel_msg *)bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.infoListArray = [model.msg.list mutableCopy];
            [weakSelf.tableView reloadData];
        }else
        {
            [MBProgressHUDUtil showMessage:@"没有消息！" toView:self.view];
        }
    }];
}

@end
