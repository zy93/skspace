//
//  WOTTabBarVCViewController.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTTabBarVCViewController.h"
#import "LoginViewController.h"
#import "CLTabBar.h"
#import "WOTOpenDoorView.h"
#import "HCScanQRViewController.h"

@interface WOTTabBarVCViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation WOTTabBarVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    // 自定义TabBar
    CLTabBar *tabBar = [[CLTabBar alloc] init];
    HCScanQRViewController *vc = [[HCScanQRViewController alloc] init];
    vc.transitioningDelegate = self;
    tabBar.composeButtonClick = ^{
        NSLog(@"点击按钮,弹出菜单");
        if ([WOTUserSingleton shareUser].userInfo.userId == nil) {
            [MBProgressHUDUtil showMessage:@"请先登录!" toView:self.view];
            return;
        }
        NSString *companyId;
        if (strIsEmpty([WOTUserSingleton shareUser].userInfo.companyId) && strIsEmpty([WOTUserSingleton shareUser].userInfo.companyIdAdmin)) {
            companyId = @"0";
        } else {
            companyId = [NSString stringWithFormat:@"%@,%@",[WOTUserSingleton shareUser].userInfo.companyId,[WOTUserSingleton shareUser].userInfo.companyIdAdmin];
        }
        [MBProgressHUDUtil showLoadingWithMessage:@"" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
            
            [WOTHTTPNetwork getQRcodeInfoWithUserId:[WOTUserSingleton shareUser].userInfo.userId companyId:companyId response:^(id bean, NSError *error) {
                WOTBaseModel *model = (WOTBaseModel *)bean;
                if ([model.code isEqualToString:@"200"]) {
                    // weakSelf.QRcodeStr = model.msg;
                    [hud hide:YES];
                    [WOTSingtleton shared].QRcodeStr = model.msg;
                    WOTOpenDoorView *view = [[WOTOpenDoorView alloc] init];
                    [view showWithController:self];
                    view.btnClick = ^(NSString *str) {
                        CATransition *animation = [CATransition animation];
                        animation.duration = 0.5;
                        animation.timingFunction = UIViewAnimationCurveEaseInOut;
                        animation.type = @"oglFlip";
                        //animation.type = kCATransitionPush;
                        animation.subtype = kCATransitionFromRight;
                        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                        //            [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                        [self.view.window.layer addAnimation:animation forKey:nil];
                        [self presentViewController:vc animated:NO completion:^{
                            
                        }];
                        [vc successfulGetQRCodeInfo:^(NSString *QRCodeInfo) {
                            NSLog(@"QR Info : %@", QRCodeInfo);
                            [vc dismissViewControllerAnimated:YES completion:nil];
                        }];
                        
                    };
                }
                else
                {
                    [hud hide:YES];
                    if ([model.code isEqualToString:@"202"]) {
                        [MBProgressHUDUtil showMessage:@"请先进行访客预约！" toView:self.view];
                        return ;
                    }
                    [MBProgressHUDUtil showMessage:@"信息获取失败！" toView:self.view];
                    return ;
                }
            }];
        }];
        
    };
    
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    [self loadSubControllers];
    [self configTab];

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSubControllers{

    [self addChildViewControllerWithStoryboardName:@"spaceMain" ClassName:@"WOTMainVCID" title:@"首页" imageName:@"main"];
    [self addChildViewControllerWithStoryboardName:@"Socialcontact" ClassName:@"WOTSocialcontactID" title:@"社交" imageName:@"socialcontact"];
    [self addChildViewControllerWithStoryboardName:@"Service" ClassName:@"WOTServiceVC" title:@"服务" imageName:@"service"];
    [self addChildViewControllerWithStoryboardName:@"My" ClassName:@"WOTMyVC" title:@"我的" imageName:@"my"];
}
-(void)configTab{
   
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"fgcolor"]];
    
}

- (void)addChildViewControllerWithStoryboardName:(NSString *)storyboardName ClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName {
//    Class Clz = NSClassFromString(className);
    UIViewController *vController = [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:className];;
    vController.title = title;
    vController.tabBarItem.image = [[UIImage imageNamed:imageName]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_select", imageName]];
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:252.f/255.f green:91.f/255.f blue:17.f/255.f alpha:1] forKey:NSForegroundColorAttributeName];
    [vController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    [vController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateHighlighted];

    NSDictionary *dic = @{NSForegroundColorAttributeName:UICOLOR_GRAY_66,NSFontAttributeName:[UIFont fontWithName:@"Arial" size:10.f]};
    [vController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];

    
    WOTBaseNavigationController *navController = [[WOTBaseNavigationController alloc] initWithRootViewController:vController];
    [self addChildViewController:navController];

}

#pragma mark - 获取二维码信息
-(void)getQRcodeInfo
{
    __weak __typeof(self)weakSelf = self;
    
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
