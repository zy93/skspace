//
//  WOTMyAppointmentListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyAppointmentListVC.h"
#import "WOTAppointmentModel.h"
@interface WOTMyAppointmentListVC ()<WOTMyAppointRemindingDelegate>{
   
}
@property(nonatomic,strong)NSArray<WOTAppointmentModel *> *appintmentDataSource;
@end

@implementation WOTMyAppointmentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyAppointmentCell" bundle:nil] forCellReuseIdentifier:@"WOTMyAppointmentCellID"];
    
    [self getDataSourceFromWeb];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _appintmentDataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyAppointmentCell *appointmentcell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyAppointmentCellID" forIndexPath:indexPath];
    appointmentcell.appointmentCommunityValue.text = _appintmentDataSource[indexPath.row].visitorName;
    appointmentcell.appointmentObjectValue.text =_appintmentDataSource[indexPath.row].visitorName;
    appointmentcell.appointmentTimeValue.text = _appintmentDataSource[indexPath.row].visitTime;
    appointmentcell.appointmentReasionValue.text = _appintmentDataSource[indexPath.row].visitInfo;
    appointmentcell.delegate = self;
    appointmentcell.index = indexPath.row;
    return appointmentcell;
    
}


-(void)getDataSourceFromWeb{
//    [[WOTUserSingleton shareUser]setValues];
   [WOTHTTPNetwork getMyAppointmentWithUserId:[[NSNumber alloc]initWithInt:[[WOTUserSingleton shareUser].userInfo.userId intValue]] response:^(id bean, NSError *error) {
       if (bean) {
           WOTAppointmentModel_msg *dd = (WOTAppointmentModel_msg *)bean;
           _appintmentDataSource = dd.msg;
           [self.tableView reloadData];
       }
       if (error) {
           [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
       }
   }];
    
}


//设置提醒代理方法
-(void)settingRemindWithIndex:(NSInteger)index isRemind:(BOOL)isRemid{
    //
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
