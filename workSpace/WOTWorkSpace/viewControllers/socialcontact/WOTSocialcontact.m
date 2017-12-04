//
//  WOTSocialcontact.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSocialcontact.h"
#import "WOTNearCirclesVC.h"
#import "WOTEnterpriseLIstVC.h"
#import "WOTPublishSocialTrendsVC.h"
#import "MJRefresh.h"
@interface WOTSocialcontact ()

@end

@implementation WOTSocialcontact

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


-(void)setpageMenu{
    NSArray<__kindof UIViewController *> *controllers = [self createViewControllers];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:[self createTitles]];
    self.pageTabView.cutOffLine = YES;
    self.pageTabView.bottomOffLine = NO;
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.pageTabView.delegate = self;
    //    self.pageTabView.bodyBounces = NO;
    //    self.pageTabView.tabSize = CGSizeMake(self.view.frame.size.width, 40);
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    //    self.pageTabView.minScale = 1.0;
    //    self.pageTabView.selectedTabIndex = 4;
    //    self.pageTabView.selectedTabIndex = -1;
    //    self.pageTabView.selectedTabIndex = 4;
    
    //    self.pageTabView.maxNumberOfPageItems = 1;
    self.pageTabView.maxNumberOfPageItems = 5;
    
    //    self.pageTabView.tabItemFont = [UIFont systemFontOfSize:18];
    
    //    self.pageTabView.indicatorHeight = 5;
    self.pageTabView.indicatorWidth = 20;
    //    self.pageTabView.tabBackgroundColor = [UIColor yellowColor];
    //    self.pageTabView.unSelectedColor = [UIColor greenColor];
    
    //    self.pageTabView.tabSize = CGSizeMake(self.view.bounds.size.width-30, 0);
    [self.view addSubview:self.pageTabView];
}


-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)configNavi{
    self.navigationItem.title = @"易创客";
  
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"publishSocial"]];
}

#pragma mark - action
-(void)rightItemAction{
    WOTPublishSocialTrendsVC *publishvc = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"WOTPublishSocialTrendsVCID"];
    [self.navigationController pushViewController:publishvc animated:YES];
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"最近的圈子",@"友邻企业",@"空间集市",nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTNearCirclesVC *circle = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTNearCirclesVCID"];

    [self addChildViewController:circle];
    UIViewController *circle1 = [[UIViewController alloc]init];
    circle1.view.backgroundColor = White;
    [MBProgressHUDUtil showMessage:@"敬请期待" toView:circle1.view];
    
    
    [self addChildViewController:circle1];
    
    UIViewController *circle2 = [[UIViewController alloc]init];
    circle2.view.backgroundColor = White;
    [MBProgressHUDUtil showMessage:@"敬请期待" toView:circle2.view];
    
    
    
    [self addChildViewController:circle2];
    
    
    return self.childViewControllers;
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
