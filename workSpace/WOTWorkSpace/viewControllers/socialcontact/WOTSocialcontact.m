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
#import "UIColor+ColorChange.h"

@interface WOTSocialcontact ()<XXPageTabViewDelegate>

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
    self.pageTabView.bottomOffLine = YES;
    self.pageTabView.selectedColor = [UIColor colorWithHexString:@"ff7d3d"];
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.pageTabView.delegate = self;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;

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
    return [[NSArray alloc]initWithObjects:@"全部",@"关注",@"评价",nil];
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
