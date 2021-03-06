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
#import "SKFocusCirclesViewController.h"
#import "SKCommentViewController.h"
#import "SKFocusListViewController.h"
#import "XXPageTabView.h"
#import "XXPageTabItemLable.h"

@interface WOTSocialcontact ()<XXPageTabViewDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)XXPageTabView *pageTabView;
@end

@implementation WOTSocialcontact

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self configNavi];
    [self setpageMenu];
    
}


-(void)setpageMenu{
    NSArray<__kindof UIViewController *> *controllers = [self createViewControllers];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:[self createTitles]];
    self.pageTabView.selectedColor = [UIColor colorWithHexString:@"ff7d3d"];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-60);
    NSLog(@"ok:%f",self.view.frame.size.height-60);
    self.pageTabView.delegate = self;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;
    self.pageTabView.selectedTabIndex = 0;
    [self.view addSubview:self.pageTabView];
    [self.pageTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view.mas_top);
        }
        make.left.right.bottom.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)configNavi{
    self.navigationItem.title = @"社交";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"publishSocial"]];
}

#pragma mark - action
-(void)rightItemAction{
    if ([WOTUserSingleton shareUser].userInfo.userId == nil) {
        [MBProgressHUDUtil showMessage:@"请先登录!" toView:self.view];
        return;
    }
    WOTPublishSocialTrendsVC *publishvc = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"WOTPublishSocialTrendsVCID"];
    [self.navigationController pushViewController:publishvc animated:YES];
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"全部",@"关注",@"评论",nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTNearCirclesVC *circle = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTNearCirclesVCID"];
    [self addChildViewController:circle];
    
    SKFocusListViewController *circle1 = [[SKFocusListViewController alloc]init];
    circle1.view.backgroundColor = UICOLOR_WHITE;
    [self addChildViewController:circle1];
    
    SKCommentViewController *circle2 = [[SKCommentViewController alloc]init];
    circle2.view.backgroundColor = UICOLOR_WHITE;
    [self addChildViewController:circle2];
    
    
    return self.childViewControllers;
}

@end
