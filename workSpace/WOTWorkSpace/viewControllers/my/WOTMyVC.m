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
#import "WOTReservationsMeetingVC.h"
#import "LoginViewController.h"
#import "WOTMyAppointmentHistoryVC.h"

@interface WOTMyVC ()<WOTOrderCellDelegate,WOTOMyCellDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)WOTSettingVC *settingvc;
@property(nonatomic,strong)WOTPersionalInformation *persionalVC;


@end

@implementation WOTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    [self.tableView registerClass:[WOTMycommonCell class] forCellReuseIdentifier:@"mycommonCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderCell" bundle:nil] forCellReuseIdentifier:@"myorderCellID"];
//    if (![WOTSingtleton shared].isuserLogin) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
            return 4;
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
            return 100;
            break;
        case 2:
            return 50;
            break;
        default:
            break;
    }
    return  0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  0.00001;
} 

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *commoncell;
    
    if (indexPath.section == 0) {
        WOTMyuserCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyuserCellID" forIndexPath:indexPath];
        [mycell.loginButton addTarget:self action:@selector(showLoginView) forControlEvents:UIControlEventTouchDown];
        if ([WOTSingtleton shared].isuserLogin) {
            [mycell.loginButton setHidden:YES];
            [mycell.memberLabel setHidden:NO];
            [mycell.userName setHidden:NO];
            NSString *numberString = [[WOTUserSingleton shareUser].userInfo.tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            mycell.userName.text = numberString;
            if ([[WOTUserSingleton shareUser].userInfo.userType isEqualToNumber:@0]) {
                mycell.memberLabel.text = @"普通用户";
            }else
            {
                mycell.memberLabel.text = @"会员用户";
            }
            
        }else
        {
            [mycell.loginButton setHidden:NO];
            [mycell.memberLabel setHidden:NO];
            mycell.memberLabel.text = @"登录后可进行更多操作";
            [mycell.userName setHidden:YES];
        }
        
       
       
        [mycell.headerImage sd_setImageWithURL:[[WOTUserSingleton shareUser].userInfo.headPortrait ToUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
        mycell.mycelldelegate = self;
        commoncell = mycell;
    } else if (indexPath.section == 1){
        WOTMyOrderCell *ordercell = [tableView dequeueReusableCellWithIdentifier:@"myorderCellID" forIndexPath:indexPath];
        ordercell.celldelegate = self;
        commoncell = ordercell;
    } else {
        WOTMycommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycommonCellID" forIndexPath:indexPath];
        NSArray *titlearray = [NSArray arrayWithObjects:@"我的企业",@"我的活动",@"我的预约", @"我的维修",nil];
        NSArray *imageNameArray = [NSArray arrayWithObjects:@"enterprise",@"activities",@"history", @"repairs_history",nil];
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
                if (indexPath.row == 0) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"My" bundle:[NSBundle mainBundle]];
                    WOTMyEnterpriseVC *myenterprisevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTMyEnterpriseVC"];
                    [self.navigationController pushViewController:myenterprisevc animated:YES];
                    
                    
                } else if (indexPath.row == 1){
                    WOTMyActivitiesVC *activityvc = [[WOTMyActivitiesVC alloc]init];
                    [self.navigationController pushViewController:activityvc animated:YES];
                } else if (indexPath.row ==2) {
                    WOTMyAppointmentHistoryVC *vc = [[WOTMyAppointmentHistoryVC alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else {
                    
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

-(void)showLoginView
{
    [[WOTConfigThemeUitls shared] showLoginVC:self];
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

-(void)showSiteOrderList
{
    if ([WOTSingtleton shared].isuserLogin) {
        WOTOrderLIstVC *station_ordervc = [[WOTOrderLIstVC alloc]init];
        station_ordervc.vctype = WOTPageMenuVCTypeSite;
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
