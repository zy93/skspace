//
//  WOTSurplusTimeVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSurplusTimeVC.h"
#import "WOTSurplusTimeCell.h"

@interface WOTSurplusTimeVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WOTSurplusTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"剩余时长";
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTSurplusTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTSurplusTimeCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTSurplusTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSurplusTimeCell"];
    if (!cell) {
        cell = [[WOTSurplusTimeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTSurplusTimeCell"];
    }
    
        //分钟制转小时制
        long hours = [WOTUserSingleton shareUser].userInfo.workHours.integerValue/60;
        long minute= [WOTUserSingleton shareUser].userInfo.workHours.integerValue%60;
        cell.bookstationValueLab.text = [NSString stringWithFormat:@"%@%ld分钟",hours==0?@"":[NSString stringWithFormat:@"%ld小时",hours],minute];

        //分钟制转小时制
         hours = [WOTUserSingleton shareUser].userInfo.meetingHours.integerValue/60;
         minute= [WOTUserSingleton shareUser].userInfo.meetingHours.integerValue%60;
        cell.meetingValueLab.text = [NSString stringWithFormat:@"%@%ld分钟",hours==0?@"":[NSString stringWithFormat:@"%ld小时",hours],minute];
    
    return cell;
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
