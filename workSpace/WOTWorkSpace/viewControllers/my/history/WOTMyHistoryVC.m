//
//  WOTMyHistoryVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyHistoryVC.h"
#import "WOTMyAppointmentListVC.h"
#import "WOTMyRepairdListVC.h"
#import "WOTMyPublishDemandsLIstVC.h"
#import "WOTMyFeedbackLIstVC.h"
#import "WOTAppointmentRemindPopView.h"
@interface WOTMyHistoryVC ()<UIPopoverPresentationControllerDelegate>
@property(nonatomic,strong)WOTAppointmentRemindPopView *remindPopvc;
@end

@implementation WOTMyHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self configNavi];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_remindPopvc dismissViewControllerAnimated:YES completion:nil];
}
-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的历史";
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"remind_icon"]];
    
}

-(void)rightItemAction{
    //TODO:显示提醒列表
    _remindPopvc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTAppointmentRemindPopViewID"];
//    _remindPopvc.modalPresentationStyle = UIModalPresentationPopover;
//    _remindPopvc.popoverPresentationController.delegate = self;
//    _remindPopvc.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
//    _remindPopvc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
//    _remindPopvc.popoverPresentationController.backgroundColor = CLEARCOLOR;
//    _remindPopvc.preferredContentSize = CGSizeMake(200, 300);
//  
//    [self presentViewController:_remindPopvc animated:YES completion:nil];
    [self.navigationController pushViewController:_remindPopvc animated:YES];
}


-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"预约",@"维修",@"需求",@"意见反馈", nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    
    WOTMyAppointmentListVC *appointmentvc = [[WOTMyAppointmentListVC alloc]init];
    [self addChildViewController:appointmentvc];
    
    WOTMyRepairdListVC *repairvc = [[WOTMyRepairdListVC alloc]init];
    [self addChildViewController:repairvc];
    
    WOTMyPublishDemandsLIstVC *publishvc = [[WOTMyPublishDemandsLIstVC alloc]init];
    [self addChildViewController:publishvc];
    
    WOTMyFeedbackLIstVC *feedbackvc = [[WOTMyFeedbackLIstVC alloc]init];
    [self addChildViewController:feedbackvc];
    
    return self.childViewControllers;
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
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
