//
//  WOTMyVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyVC.h"

#import "WOTMyuserCell.h"
#import "WOTMycommonCell.h"
#import "WOTMyOrderCell.h"
#import "WOTMyActivitiesVC.h"
#import "WOTMyHistoryVC.h"
#import "WOTLoginVC.h"
#import "WOTLoginNaviController.h"
#import "WOTReservationsMeetingVC.h"
@interface WOTMyVC ()<WOTOrderCellDelegate,WOTOMyCellDelegate>
@property(nonatomic,strong)WOTSettingVC *settingvc;
@property(nonatomic,strong)WOTPersionalInformation *persionalVC;


@end

@implementation WOTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    [self.tableView registerClass:[WOTMycommonCell class] forCellReuseIdentifier:@"mycommonCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderCell" bundle:nil] forCellReuseIdentifier:@"myorderCellID"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyuserCell" bundle:nil] forCellReuseIdentifier:@"WOTMyuserCellID"];
    [self.tabBarController.tabBar setHidden:NO];
     self.tabBarController.tabBar.translucent = NO;
    [self.navigationController.navigationBar setHidden:YES];
    
    [self.tableView reloadData];
    
}


-(void)viewWillLayoutSubviews{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(self.view).offset(-20);
        maker.left.mas_equalTo(self.view);
        maker.right.mas_equalTo(self.view);
        maker.bottom.mas_equalTo(self.view);
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
     return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 270;
            break;
        case 1:
            return 125;
            break;
        case 2:
            return 50;
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    } else {
        return 10;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *commoncell;
    
    if (indexPath.section == 0) {
        WOTMyuserCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyuserCellID" forIndexPath:indexPath];
        if ([WOTSingtleton shared].isuserLogin) {
//            [[WOTUserSingleton shareUser] setValues];
            mycell.userName.text = [WOTUserSingleton shareUser].userInfo.userName;
            mycell.constellation.text = [WOTUserSingleton shareUser].userInfo.constellation;
            mycell.signature.text = [WOTUserSingleton shareUser].userInfo.spared1;
            mycell.sexImage.image = [[WOTUserSingleton shareUser].userInfo.sex isEqualToString:@"man"]? [UIImage imageNamed:@"boy"]:[UIImage imageNamed:@"girl"];
           // NSLog(@"测试：%@",[WOTUserSingleton shareUser].userInfo.headPortrait);
            [mycell.headerImage sd_setImageWithURL:[[WOTUserSingleton shareUser].userInfo.headPortrait ToUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
            
        } else {
            mycell.userName.text = @"登录／注册";
            mycell.constellation.text = @"";
            mycell.signature.text = @"";
            mycell.headerImage.image = [UIImage imageNamed:@"unlogin"];
            mycell.sexImage.image = [UIImage imageNamed:@""];
        }
        mycell.bgImage.image = [UIImage imageNamed:@"mybgimage"];
        mycell.mycelldelegate = self;
    
        commoncell = mycell;
    } else if (indexPath.section == 1){
        WOTMyOrderCell *ordercell = [tableView dequeueReusableCellWithIdentifier:@"myorderCellID" forIndexPath:indexPath];
        ordercell.celldelegate = self;
        commoncell = ordercell;
    } else {
        WOTMycommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycommonCellID" forIndexPath:indexPath];
        NSArray *titlearray = [NSArray arrayWithObjects:@"我的企业",@"我的活动",@"我的历史",nil];
        NSArray *imageNameArray = [NSArray arrayWithObjects:@"enterprise",@"activities",@"history",nil];
        cell.nameLabel.text = titlearray[indexPath.row];
        cell.cellImage.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
        commoncell = cell;
    }
    
    return commoncell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([WOTSingtleton shared].isuserLogin) {
        switch (indexPath.section) {
            case 0:
                //enter to mymainvc
                break;
            case 1:
                break;
            case 2:
                if (indexPath.row ==0 ) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
                    WORTMyEnterpriseVC *myenterprisevc = [storyboard instantiateViewControllerWithIdentifier:@"WORTMyEnterpriseVCID"];
                    [self.navigationController pushViewController:myenterprisevc animated:YES];
                    
                    
                } else if (indexPath.row == 1){
                    WOTMyActivitiesVC *activityvc = [[WOTMyActivitiesVC alloc]init];
                    [self.navigationController pushViewController:activityvc animated:YES];
                } else {
                    WOTMyHistoryVC *historyvc = [[WOTMyHistoryVC alloc]init];
                    [self.navigationController pushViewController:historyvc animated:YES];
                }
            default:
                break;
        }
    } else {
        [[WOTConfigThemeUitls shared] showLoginVC:self];
        
    }
   
}


/**订单celldelegate*/
-(void)showAllOrderList{
    if ([WOTSingtleton shared].isuserLogin) {
        WOTAllOrderListVC *station_ordervc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTAllOrderListVC"];
 // [[WOTAllOrderListVC alloc]init];
        [self.navigationController pushViewController:station_ordervc animated:YES];
    } else {
        [[WOTConfigThemeUitls shared] showLoginVC:self];
    }
    
    
}

-(void)showStationOrderList{
    if ([WOTSingtleton shared].isuserLogin) {
        WOTOrderLIstVC *station_ordervc = [[WOTOrderLIstVC alloc]init];
        station_ordervc.vctype = WOTPageMenuVCTypeStation;
        [self.navigationController pushViewController:station_ordervc animated:YES];
    } else {
        [[WOTConfigThemeUitls shared] showLoginVC:self];
    }
    
}
-(void)showMettingRoomOrderList{
    if ([WOTSingtleton shared].isuserLogin) {
//        WOTReservationsMeetingVC *mettingroom_ordervc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTReservationsMeetingVC"];
//        [self.navigationController pushViewController:mettingroom_ordervc animated:YES];
        WOTOrderLIstVC *station_ordervc = [[WOTOrderLIstVC alloc]init];
        station_ordervc.vctype = WOTPageMenuVCTypeMetting;
        [self.navigationController pushViewController:station_ordervc animated:YES];
        
    } else {
        [[WOTConfigThemeUitls shared] showLoginVC:self];
    }

}

-(void)showSettingVC{
    _settingvc =[[UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"WOTSettingVC"];
    
    [self.navigationController pushViewController:_settingvc animated:YES];
}

-(void)showPersonalInformationVC
{
    /*
    if ([WOTSingtleton shared].isuserLogin) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
        
        _persionalVC = [storyboard instantiateViewControllerWithIdentifier:@"WOTPersionalInformationID"];
        [self.navigationController pushViewController:_persionalVC animated:YES];
    } else{
//        WOTLoginVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTLoginVC"];
//        WOTLoginNaviController *nav = [[WOTLoginNaviController alloc]initWithRootViewController:vc];
//        
//        [self presentViewController:nav animated:YES completion:^{
//            
//        }];
        [[WOTConfigThemeUitls shared] showLoginVC:self];
    }
   */
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
