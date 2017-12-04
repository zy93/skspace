//
//  WOTMyActivitiesBaseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyActivitiesBaseVC.h"
#import "WOTMyActivitiesCell.h"
#import "WOTActivityModel.h"
@interface WOTMyActivitiesBaseVC (){
    NSArray<WOTMyActivityModel *> *dataSource0;
    NSArray<WOTActivityModel *> *dataSource1;
}


@end

@implementation WOTMyActivitiesBaseVC

-(instancetype)init{
    self = [super init];
    if (self) {
         _vctype = @"";
        dataSource0 = [[NSArray alloc]init];
        dataSource1 = [[NSArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView.backgroundColor = CLEARCOLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyActivitiesCell" bundle:nil] forCellReuseIdentifier:@"WOTMyActivitiesCellID"];
  
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_vctype isEqualToString:@"0"]) {
        return dataSource0.count;
    } else {
        return dataSource1.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyActivitiesCell *activityCell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyActivitiesCellID" forIndexPath:indexPath];
    if ([_vctype isEqualToString:@"0"]) {
        activityCell.activityTitle.text = dataSource0[indexPath.row].content.title;
        activityCell.activityTime.text = [NSString stringWithFormat:@"%@---%@",dataSource0[indexPath.row].content.starTime,dataSource0[indexPath.row].content.endTime];
        activityCell.activityLocation.text = dataSource0[indexPath.row].content.spared1;
        [activityCell.activityBtn setTitle:dataSource0[indexPath.row].state forState:UIControlStateNormal];
    } else {
        activityCell.activityTitle.text = dataSource1[indexPath.row].title;
        activityCell.activityTime.text = [NSString stringWithFormat:@"%@---%@",dataSource1[indexPath.row].starTime,dataSource1[indexPath.row].endTime];
        activityCell.activityLocation.text = dataSource1[indexPath.row].spared1;
        if ([_vctype isEqualToString:@"1"]) {
            [activityCell.activityBtn setTitle:@"未开始" forState:UIControlStateNormal];
        } else {
            [activityCell.activityBtn setTitle:@"已结束" forState:UIControlStateNormal];
        }
        
    }
    
    return activityCell;

}


-(void)getActivityDataSourceFromWeb:(NSString *)state{
//    [[WOTUserSingleton shareUser]setValues];
    
    [WOTHTTPNetwork getUserActivitiseWithUserId:[[NSNumber alloc]initWithInt:[[WOTUserSingleton shareUser].userInfo.userId intValue]] state:state response:^(id bean, NSError *error) {
        if ([_vctype isEqualToString:@"0"]) {
            WOTMyActivityModel_msg *dd = (WOTMyActivityModel_msg *)bean;
            dataSource0 = dd.msg;
        } else {
            WOTActivityModel_msg *dd = (WOTActivityModel_msg *)bean;
            dataSource1 = dd.msg;
        }
        
        
        [self.tableView reloadData];
    }];
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
