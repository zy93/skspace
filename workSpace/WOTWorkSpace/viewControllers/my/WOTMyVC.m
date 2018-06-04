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
#import "WOTMyRepairdListVC.h"
#import "WOTLoginVC.h"
#import "WOTReservationsMeetingVC.h"
#import "LoginViewController.h"
#import "WOTMyAppointmentHistoryVC.h"
#import "UIDevice+Resolutions.h"
#import "WOTMyInviteVC.h"
#import "WOTSurplusTimeVC.h"
#import "SKMyInfomationNotificationTableViewController.h"
#import "SKInfoNotifationModel.h"

@interface WOTMyVC ()<WOTOrderCellDelegate,WOTOMyCellDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)WOTSettingVC *settingvc;
@property(nonatomic,strong)WOTPersionalInformation *persionalVC;
@property(nonatomic,assign)BOOL isShow;

@end

@implementation WOTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[WOTMycommonCell class] forCellReuseIdentifier:@"mycommonCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyOrderCell" bundle:nil] forCellReuseIdentifier:@"myorderCellID"];
    //解决状态栏空白问题
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(self.view);
        maker.left.mas_equalTo(self.view);
        maker.right.mas_equalTo(self.view);
        maker.bottom.mas_equalTo(self.view);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyuserCell" bundle:nil] forCellReuseIdentifier:@"WOTMyuserCellID"];
    [self.tabBarController.tabBar setHidden:NO];
     self.tabBarController.tabBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self updataUserInfo];
    [self queryNewInfo];
    [self.tableView reloadData];
}

#pragma mark - table delegate 
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
            return 7;
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
            return 95;
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

        if ([WOTSingtleton shared].isuserLogin) {
            mycell.topButton.hidden = YES;
            [mycell.loginButton setHidden:YES];
            [mycell.memberLabel setHidden:NO];
            [mycell.userName setHidden:NO];
           
            NSString *numberString = [[WOTUserSingleton shareUser].userInfo.tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            mycell.userName.text = numberString;
            if (strIsEmpty([WOTUserSingleton shareUser].userInfo.companyName)) {
                mycell.memberLabel.text = @"未加入任何企业";
            }else
            {
                mycell.memberLabel.text = [WOTUserSingleton shareUser].userInfo.companyName;
            }
//            if ([[WOTUserSingleton shareUser].userInfo.userType isEqualToNumber:@0]) {
//                mycell.memberLabel.text = @"普通用户";
//            }else
//            {
//                mycell.memberLabel.text = @"会员用户";
//            }
        }else
        {
            mycell.topButton.hidden = NO;
            [mycell.topButton addTarget:self action:@selector(showLoginView) forControlEvents:UIControlEventTouchDown];
            [mycell.loginButton setHidden:NO];
            [mycell.memberLabel setHidden:NO];
            mycell.memberLabel.text = @"登录后可进行更多操作";
            [mycell.userName setHidden:YES];
        }
        NSLog(@"头像地址%@",[WOTUserSingleton shareUser].userInfo.headPortrait);
        [mycell.headerImage sd_setImageWithURL:[[WOTUserSingleton shareUser].userInfo.headPortrait ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
        mycell.mycelldelegate = self;
        commoncell = mycell;
    } else if (indexPath.section == 1){
        WOTMyOrderCell *ordercell = [tableView dequeueReusableCellWithIdentifier:@"myorderCellID" forIndexPath:indexPath];
        ordercell.delegate = self;
        commoncell = ordercell;
    } else {
        WOTMycommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycommonCellID" forIndexPath:indexPath];
        NSArray *titlearray = [NSArray arrayWithObjects:@"我的企业",@"我的活动",@"我的预约", @"我的维修", @"我的邀请",@"剩余时长",@"我的消息",nil];
        NSArray *imageNameArray = [NSArray arrayWithObjects:@"enterprise",@"activities",@"history", @"repairs_history",@"my_invite", @"my_time",@"myinfo",nil];
        if (indexPath.row == 6) {
            if (_isShow) {
               cell.redDotImage.hidden = NO;
            }else
            {
                cell.redDotImage.hidden = YES;
            }
            
        }else
        {
            cell.redDotImage.hidden = YES;
        }
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
                else if (indexPath.row ==3) {
                    
                    WOTMyRepairdListVC *historyvc = [[WOTMyRepairdListVC alloc]init];
                    historyvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:historyvc animated:YES];
                }
                else if (indexPath.row ==4) {
                    
                    WOTMyInviteVC *vc = [[WOTMyInviteVC alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else if (indexPath.row ==5) {
                    
                    WOTSurplusTimeVC *vc = [[WOTSurplusTimeVC alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else if (indexPath.row == 6)
                {
                    SKMyInfomationNotificationTableViewController *infoTVC = [[SKMyInfomationNotificationTableViewController alloc] init];
                    infoTVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:infoTVC animated:YES];
                }
                
            default:
                break;
        }
    } else {
        if (indexPath.section == 0) {
            return;
        }
        [[WOTConfigThemeUitls shared] showLoginVC:self];
    }
}

-(void)showLoginView
{
    [[WOTConfigThemeUitls shared] showLoginVC:self];
}


#pragma mark - cell delegate

-(void)myOrderCell:(WOTMyOrderCell *)cell showOrder:(NSString *)type
{
    NSArray *arr = @[@"全部订单", @"会议室", @"工位", @"场地", @"礼包"];
    if ([WOTSingtleton shared].isuserLogin) {
        WOTAllOrderListVC *station_ordervc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTAllOrderListVC"];
    
        station_ordervc.page = [arr indexOfObject:type];
        [self.navigationController pushViewController:station_ordervc animated:YES];
    }
    else {
        [[WOTConfigThemeUitls shared] showLoginVC:self];
    }
}

//-(void)showAllOrderList{
//    if ([WOTSingtleton shared].isuserLogin) {
//
//        station_ordervc.page = 0;
//        [self.navigationController pushViewController:station_ordervc animated:YES];
//    } else {
//        [[WOTConfigThemeUitls shared] showLoginVC:self];
//    }
//}
//
//-(void)showStationOrderList{
//        WOTAllOrderListVC *station_ordervc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTAllOrderListVC"];
//        station_ordervc.page = 0;
//        [self.navigationController pushViewController:station_ordervc animated:YES];
//
//}
//
//-(void)showSiteOrderList
//{
//    if ([WOTSingtleton shared].isuserLogin) {
//        WOTAllOrderListVC *station_ordervc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTAllOrderListVC"];
//        station_ordervc.page = 2;
//        [self.navigationController pushViewController:station_ordervc animated:YES];
//    } else {
//        [[WOTConfigThemeUitls shared] showLoginVC:self];
//    }
//}
//
//-(void)showMettingRoomOrderList{
//    if ([WOTSingtleton shared].isuserLogin) {
//        WOTAllOrderListVC *station_ordervc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTAllOrderListVC"];
//        station_ordervc.page = 1;
//        [self.navigationController pushViewController:station_ordervc animated:YES];
//    } else {
//        [[WOTConfigThemeUitls shared] showLoginVC:self];
//    }
//}

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

-(void)queryNewInfo
{
    __weak typeof(self) weakSelf = self;
    if ([WOTUserSingleton shareUser].userInfo.userId) {
        [WOTHTTPNetwork queryNotifationInfoWithReadState:@"未读" response:^(id bean, NSError *error) {
            SKInfoNotifationModel_msg *model = (SKInfoNotifationModel_msg *)bean;
            if ([model.code isEqualToString:@"200"]) {
                weakSelf.isShow = YES;
                
            }else
            {
                AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.tabbar.tabBar hideBadgeOnItemIndex:4];
                weakSelf.isShow = NO;
            }
            [weakSelf.tableView reloadData];
        }];
    }
}

#pragma mark - 更新用户信息
-(void)updataUserInfo
{
    if ([WOTUserSingleton shareUser].userInfo.userId) {
        [[WOTUserSingleton shareUser] updateUserInfo:^{
            
        }];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    
    return YES;
}

@end
