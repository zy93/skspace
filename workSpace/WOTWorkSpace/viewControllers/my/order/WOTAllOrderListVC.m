//
//  WOTAllOrderListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTAllOrderListVC.h"
#import "WOTOrderLIstBaseVC.h"
#import "XXPageTabView.h"
#import "XXPageTabItemLable.h"
@interface WOTAllOrderListVC ()<XXPageTabViewDelegate>
@property (nonatomic,strong)XXPageTabView *pageTabView;
@end

@implementation WOTAllOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavi];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"全部",@"会议室",@"工位",@"长租工位",@"场地",@"礼包"]];
    self.pageTabView.delegate = self;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;
    self.pageTabView.selectedTabIndex = self.page;
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

- (void)pageTabViewDidEndChange {
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的订单";
}



@end
