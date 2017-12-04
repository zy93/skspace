//
//  WOTOrderLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTOrderLIstVC.h"


@interface WOTOrderLIstVC ()



@end

@implementation WOTOrderLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
      [self configNavi];
   
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
-(void)configNavi{
    [self configNaviBackItem];
   
    if (self.vctype == WOTPageMenuVCTypeMetting) {
            self.navigationItem.title = @"会议室订单";
    } else if (self.vctype == WOTPageMenuVCTypeStation){
        self.navigationItem.title = @"工位订单";
    }

}








-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"全部",@"待支付",@"待使用",@"已完成",@"已取消", nil];
}
-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTOrderLIstBaseVC *basevc = [[WOTOrderLIstBaseVC alloc]init];
    basevc.orderlisttype = self.vctype;
    [self addChildViewController:basevc];
    WOTOrderLIstBaseVC *basevc1 = [[WOTOrderLIstBaseVC alloc]init];
    basevc1.orderlisttype = self.vctype;
    [self addChildViewController:basevc1];
    WOTOrderLIstBaseVC *basevc2 = [[WOTOrderLIstBaseVC alloc]init];
    basevc2.orderlisttype = self.vctype;
    [self addChildViewController:basevc2];
    WOTOrderLIstBaseVC *basevc3 = [[WOTOrderLIstBaseVC alloc]init];
    basevc3.orderlisttype = self.vctype;
    [self addChildViewController:basevc3];
    WOTOrderLIstBaseVC *basevc4 = [[WOTOrderLIstBaseVC alloc]init];
    basevc4.orderlisttype = self.vctype;
    [self addChildViewController:basevc4];
    
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
