//
//  SKMyInfomationNotificationTableViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKMyInfomationNotificationTableViewController.h"
#import "SKInfoNotificationTableViewCell.h"
#import "SKInfoNotifationModel.h"

#import "WOTEnterpriseApplyVC.h"
#import "WOTMyRepairdListVC.h"
#import "SKListTableViewController.h"

@interface SKMyInfomationNotificationTableViewController ()
@property(nonatomic,strong)NSMutableArray *notifationListArray;


@end

@implementation SKMyInfomationNotificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.notifationListArray = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"消息通知";
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SKInfoNotificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKInfoNotificationTableViewCell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 148;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notifationListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKInfoNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKInfoNotificationTableViewCell"];
    SKInfoNotifationModel *model = self.notifationListArray[indexPath.row];
    if ([model.readState isEqualToString:@"未读"]) {
        cell.redDotImageView.hidden = NO;
        
    }else
    {
        cell.redDotImageView.hidden = YES;
    }
    
    if ([model.type isEqualToString:@"企业申请结果"]) {
        cell.moreButton.hidden = YES;
    }else
    {
        cell.moreButton.hidden = NO;
    }
    cell.notifationTimeLabel.text = model.time;
    cell.notificationLabel.text = model.type;
    cell.notificationInfoLabel.text = model.summary;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moreButton.tag = indexPath.row;
    [cell.moreButton addTarget:self action:@selector(seeNotifationDetails:) forControlEvents:UIControlEventTouchDown];
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self questInfolist];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - 更多按钮
-(void)seeNotifationDetails:(UIButton *)button
{
    SKInfoNotifationModel *model = self.notifationListArray[button.tag];
    if ([model.readState isEqualToString:@"未读"]) {
        [self openNotifationWithNewsId:model.newsId];
    }
    
    if ([model.type isEqualToString:@"企业申请"]) {
        WOTEnterpriseApplyVC *enterpriseVC = [[WOTEnterpriseApplyVC alloc] init];
        [self.navigationController pushViewController:enterpriseVC animated:YES];
    }
    
    if ([model.type isEqualToString:@"维修反馈"]) {
        WOTMyRepairdListVC *myRepairdVC = [[WOTMyRepairdListVC alloc] init];
        [self.navigationController pushViewController:myRepairdVC animated:YES];
    }
    
    if ([model.type isEqualToString:@"需求反馈"]) {
        SKListTableViewController *myDemand = [[SKListTableViewController alloc] init];
        myDemand.notificationType = NOTIFICATION_TYPE_DEMAND;
        [self.navigationController pushViewController:myDemand animated:YES];
    }
    
    if ([model.type isEqualToString:@"预约入驻反馈"]) {
        SKListTableViewController *myEnter = [[SKListTableViewController alloc] init];
        myEnter.notificationType = NOTIFICATION_TYPE_ENTER;
        [self.navigationController pushViewController:myEnter animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKInfoNotifationModel *model = self.notifationListArray[indexPath.row];
    if ([model.type isEqualToString:@"企业申请结果"]) {
        if ([model.readState isEqualToString:@"未读"]) {
            [self openNotifationWithNewsId:model.newsId];
            [self questInfolist];
        }
    }
}

#pragma mark - 请求消息列表
-(void)questInfolist
{
    __weak typeof(self) weakSelf = self;

    [WOTHTTPNetwork queryNotifationInfoWithReadState:nil response:^(id bean, NSError *error) {
        SKInfoNotifationModel_msg *model = (SKInfoNotifationModel_msg *)bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.notifationListArray = [model.msg.list mutableCopy];
            [weakSelf.tableView reloadData];
        }else if ([model.code isEqualToString:@"202"])
        {
            [MBProgressHUDUtil showMessage:@"没有消息" toView:self.view];
            return ;
        }else
        {
            [MBProgressHUDUtil showMessage:@"网络出错！" toView:self.view];
            return ;
        }
    }];
}

#pragma mark - 打开通知
-(void)openNotifationWithNewsId:(NSNumber *)newsId
{
    [WOTHTTPNetwork modifyNotifationTypeWithNewsId:newsId readState:@"已读" response:^(id bean, NSError *error) {
        WOTBaseModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            
        }
    }];
}



@end
