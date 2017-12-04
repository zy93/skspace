//
//  WOTPageMenuParentVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTPageMenuParentVC.h"



@interface WOTPageMenuParentVC ()

@end

@implementation WOTPageMenuParentVC

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self setpageMenu];
   
    
    // Do any additional setup after loading the view.
  
}


- (UIViewController *)makeVC {
    UIViewController *basevc = [[UIViewController alloc]init];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    return basevc;
}

-(void)setpageMenu{
   
    [self makeVC];
    NSArray<__kindof UIViewController *> *controllers = [self createViewControllers];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:[self createTitles]];
    self.pageTabView.cutOffLine = YES;
    self.pageTabView.bottomOffLine = YES;
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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

-(NSArray *)createTitles{
    return [[NSArray alloc]init];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    return [[NSArray alloc]init];
}
#pragma mark - XXPageTabViewDelegate
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
}

#pragma mark - Event response
- (void)scrollToLast:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
}

- (void)scrollToNext:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
}

- (void)refreshPageTabView:(id)sender {
    //移除原有子控制器
    for(UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    
    UIViewController *test1 = [self makeVC];
    UIViewController *test2 = [self makeVC];
    UIViewController *test3 = [self makeVC];
    UIViewController *test4 = [self makeVC];
    UIViewController *test5 = [self makeVC];
    
    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
    [self addChildViewController:test5];
    
    [self.pageTabView reloadChildControllers:self.childViewControllers childTitles:@[@"全部", @"待支付", @"待使用", @"已完成", @"已取消"]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


