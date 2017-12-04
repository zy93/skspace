//
//  WOTMyRepairdListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyRepairdListVC.h"

@interface WOTMyRepairdListVC ()

@end

@implementation WOTMyRepairdListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyAppointmentCell *appointmentcell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyAppointmentCellID" forIndexPath:indexPath];
    appointmentcell.appointmentCommunityLabel.text = @"报修类型:";
    appointmentcell.appointmentCommunityValue.text = @"清洁";
      appointmentcell.appontmentObjectLabel.text =@"报修位置:";
    appointmentcell.appointmentObjectValue.text =@"2012旁边饮水机旁";
    appointmentcell.appintmentTimeLabel.text = @"报修时间:";
    appointmentcell.appointmentTimeValue.text = @"2017-07-11 12:30:23";
    appointmentcell.appointmentReasionLabel.text = @"描      述:";
    appointmentcell.appointmentReasionValue.text = @"讨论新项目需求";
    [appointmentcell.remindmeBtn setTitle:@"尚未处理" forState:UIControlStateNormal];
    return appointmentcell;
    
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
