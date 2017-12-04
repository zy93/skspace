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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}
-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"工位订单",@"会议室订单", nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTOrderLIstBaseVC *vc1 = [[WOTOrderLIstBaseVC alloc]init];
    
    vc1.orderlisttype = WOTPageMenuVCTypeStation;
    
    WOTOrderLIstBaseVC *vc2 = [[WOTOrderLIstBaseVC alloc]init];
    
    vc2.orderlisttype = WOTPageMenuVCTypeMetting;
    
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];

    
    return self.childViewControllers;
}



-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的订单";
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"search_icon"]];
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


-(void)rightItemAction{

    WOTSearchVC *searchvc = [[WOTSearchVC alloc]init];
    [self.navigationController pushViewController:searchvc animated:YES];
};

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
