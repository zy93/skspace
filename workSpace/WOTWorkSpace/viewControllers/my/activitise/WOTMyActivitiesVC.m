//
//  WOTMyActivitiesVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyActivitiesVC.h"
#import "WOTMyActivitiesBaseVC.h"

@interface WOTMyActivitiesVC ()
@end

@implementation WOTMyActivitiesVC

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
-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的活动";
}



-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"全部",@"未开始",@"已结束",nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTMyActivitiesBaseVC *basevc = [[WOTMyActivitiesBaseVC alloc]init];
    basevc.vctype = @"0";
    [basevc getActivityDataSourceFromWeb:@"0"];
    [self addChildViewController:basevc];
    WOTMyActivitiesBaseVC *basevc1 = [[WOTMyActivitiesBaseVC alloc]init];
    basevc1.vctype = @"1";
    [basevc1 getActivityDataSourceFromWeb:@"1"];
    [self addChildViewController:basevc1];
    WOTMyActivitiesBaseVC *basevc2 = [[WOTMyActivitiesBaseVC alloc]init];
     basevc2.vctype = @"2";
    [basevc2 getActivityDataSourceFromWeb:@"2"];
    [self addChildViewController:basevc2];
   
    
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
