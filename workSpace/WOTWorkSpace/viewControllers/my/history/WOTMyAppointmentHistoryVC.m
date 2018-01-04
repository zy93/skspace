//
//  WOTMyAppointmentHistoryVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/3.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyAppointmentHistoryVC.h"
#import "WOTMyAppointmentCell.h"
#import "WOTAppointmentModel.h"
@interface WOTMyAppointmentHistoryVC ()<WOTMyAppointmentCellDelegate>

@property (nonatomic, strong) NSArray *tableList;

@end

@implementation WOTMyAppointmentHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
      [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyAppointmentCell" bundle:nil] forCellReuseIdentifier:@"WOTMyAppointmentCell"];
    // Do any additional setup after loading the view.
    [self createRequest];
}
-(void)configNav{
    self.navigationItem.title = @"我的预约";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getMyAppointmentResponse:^(id bean, NSError *error) {
        WOTAppointmentModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.tableList = model.msg.list;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - cell delegate
-(void)cellAgree:(WOTMyAppointmentCell *)cell sender:(UIButton *)sender
{
    [WOTHTTPNetwork disposeAppointmentWithVisitorId:cell.model.visitorId result:@"2" response:^(id bean, NSError *error) {
        WOTVisitorsModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"操作成功" toView:self.view];
        }
        else {
            [MBProgressHUDUtil showMessage:@"操作失败" toView:self.view];
        }
    }];
}

-(void)cellreject:(WOTMyAppointmentCell *)cell sender:(UIButton *)sender
{
    [WOTHTTPNetwork disposeAppointmentWithVisitorId:cell.model.visitorId result:@"1" response:^(id bean, NSError *error) {
        WOTVisitorsModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"操作成功" toView:self.view];
        }
        else {
            [MBProgressHUDUtil showMessage:@"操作失败" toView:self.view];
        }
    }];
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WOTAppointmentModel *model = self.tableList[indexPath.row];
    if ([model.targetId isEqual:[WOTUserSingleton shareUser].userInfo.userId] &&
        [model.infoState isEqualToString:@"0"]) {
        return 210;
    }
    return 170;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyAppointmentCell" forIndexPath:indexPath];
    WOTAppointmentModel *model = self.tableList[indexPath.row];
    cell.titleLab.text = @"预约访问";
    cell.delegate = self;
    cell.stateLab.text = model.infoState.integerValue == 0? @"等待答复" : model.infoState.integerValue == 1? @"预约失败" : @"预约成功";
    cell.firstLab.text = [NSString stringWithFormat:@"访问对象：%@",model.targetName];
    cell.secondLab.text = [NSString stringWithFormat:@"预约时间：%@",model.visitTime];
    cell.threeLab.text = [NSString stringWithFormat:@"预约地点：%@",model.spaceName];
    if ([model.targetId isEqual:[WOTUserSingleton shareUser].userInfo.userId] &&
        [model.infoState isEqualToString:@"0"]) {
        cell.cellType = APPOINTMENT_CELL_TYPE_BUTTON;
    }
    else {
        cell.cellType = APPOINTMENT_CELL_TYPE_DEFAULT;
    }
    cell.model = model;
    
    return cell;
    
}
//adaptivePresentationStyleForPresentationController
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
