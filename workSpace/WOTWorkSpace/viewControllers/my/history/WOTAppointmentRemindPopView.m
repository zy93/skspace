//
//  WOTAppointmentRemindPopView.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/3.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTAppointmentRemindPopView.h"
#import "WOTMyAppointmentCell.h"
@interface WOTAppointmentRemindPopView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation WOTAppointmentRemindPopView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
      [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyAppointmentCell" bundle:nil] forCellReuseIdentifier:@"WOTMyAppointmentCellID"];
    // Do any additional setup after loading the view.
}
-(void)configNav{
    self.navigationItem.title = @"我的提醒";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyAppointmentCell *appointmentcell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyAppointmentCellID" forIndexPath:indexPath];
    appointmentcell.appointmentCommunityValue.text =
    @"aaa";
    appointmentcell.appointmentObjectValue.text = @"bbb";
    appointmentcell.appointmentTimeValue.text = @"2017-08-02 12:22:22";
    appointmentcell.appointmentReasionValue.text = @"ccc";
    return appointmentcell;
    
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
