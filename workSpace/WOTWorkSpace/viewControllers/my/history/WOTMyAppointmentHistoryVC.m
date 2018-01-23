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
    [WOTHTTPNetwork disposeAppointmentWithVisitorId:cell.model.visitorId result:@"预约成功" response:^(id bean, NSError *error) {
        WOTVisitorsModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"已同意对方的预约" toView:self.view];
            [self createRequest];
        }
        else {
            [MBProgressHUDUtil showMessage:@"操作失败" toView:self.view];
        }
    }];
}

-(void)cellreject:(WOTMyAppointmentCell *)cell sender:(UIButton *)sender
{
    [WOTHTTPNetwork disposeAppointmentWithVisitorId:cell.model.visitorId result:@"预约失败" response:^(id bean, NSError *error) {
        WOTVisitorsModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"已拒绝对方的预约" toView:self.view];
            [self createRequest];
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
        [model.infoState isEqualToString:@"等待答复"]) {
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
    cell.delegate = self;
    cell.titleLab.text = @"预约访问";
    cell.stateLab.text = model.infoState;
    cell.secondLab.text = [NSString stringWithFormat:@"预约时间：%@", [model.appointmentVisitTime substringToIndex:11]];
    cell.threeLab.text = [NSString stringWithFormat:@"预约地点：%@",model.spaceName];
    if ([model.targetId isEqual:[WOTUserSingleton shareUser].userInfo.userId]
        ) {
        if ([model.infoState isEqualToString:@"等待答复"]) {
            cell.cellType = APPOINTMENT_CELL_TYPE_BUTTON;
        }
        else {
            cell.cellType = APPOINTMENT_CELL_TYPE_DEFAULT;
        }
        cell.firstLab.text = [NSString stringWithFormat:@"来访对象：%@",model.visitorName];
    }
    else {
        cell.cellType = APPOINTMENT_CELL_TYPE_DEFAULT;
        cell.firstLab.text = [NSString stringWithFormat:@"访问对象：%@",model.targetName];
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
