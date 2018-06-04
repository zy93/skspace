//
//  WOTAllOrderListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTAllOrderListVC.h"
#import "WOTOrderLIstBaseVC.h"

@interface WOTAllOrderListVC ()

@end

@implementation WOTAllOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavi];
    // Do any additional setup after loading the view.
    //self.pageTabView.maxNumberOfPageItems = 6;

    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.selectedTabIndex = self.page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"全部",@"会议室", @"工位",@"长租工位",@"场地", @"礼包", nil];
}

-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTOrderLIstBaseVC *vc1 = [[WOTOrderLIstBaseVC alloc]init];
    vc1.orderlisttype = WOTPageMenuVCTypeAll;
    [self addChildViewController:vc1];
    
    WOTOrderLIstBaseVC *vc2 = [[WOTOrderLIstBaseVC alloc]init];
    vc2.orderlisttype = WOTPageMenuVCTypeMeeting;
    [self addChildViewController:vc2];
    
    WOTOrderLIstBaseVC *vc3 = [[WOTOrderLIstBaseVC alloc]init];
    vc3.orderlisttype = WOTPageMenuVCTypeStation;
    [self addChildViewController:vc3];
    
    WOTOrderLIstBaseVC *vc4 = [[WOTOrderLIstBaseVC alloc]init];
    vc4.orderlisttype = WOTPageMenuVCTypeLongTimeStation;
    [self addChildViewController:vc4];
    
    WOTOrderLIstBaseVC *vc5 = [[WOTOrderLIstBaseVC alloc]init];
    vc5.orderlisttype = WOTPageMenuVCTypeSite;
    [self addChildViewController:vc5];
    
    WOTOrderLIstBaseVC *vc6 = [[WOTOrderLIstBaseVC alloc]init];
    vc6.orderlisttype = WOTPageMenuVCTypeGiftBag;
    [self addChildViewController:vc6];
    
    return self.childViewControllers;
}



-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的订单";
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
