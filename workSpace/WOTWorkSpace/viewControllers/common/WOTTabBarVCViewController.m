//
//  WOTTabBarVCViewController.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTTabBarVCViewController.h"
#import "LoginViewController.h"

@interface WOTTabBarVCViewController ()

@end

@implementation WOTTabBarVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubControllers];
    [self configTab];

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSubControllers{
    NSMutableArray *vcarray = [[NSMutableArray alloc]init];
    
    WOTMainVC *mainvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTMainVCID"];
    WOTMainNavigationController *mainnav = [[WOTMainNavigationController alloc]initWithRootViewController:mainvc];
    
    mainvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"main"] selectedImage:[UIImage imageNamed:@"main_select"]];

    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:252.f/255.f green:91.f/255.f blue:17.f/255.f alpha:1] forKey:NSForegroundColorAttributeName];
    [mainvc.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];

    
    WOTSocialcontact *socialvc = [[UIStoryboard storyboardWithName:@"Socialcontact" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSocialcontactID"];
    socialvc.navigationItem.title = @"众创空间移动客户端";
    
    WOTSocialcontactNaviController *socialnav = [[WOTSocialcontactNaviController alloc]initWithRootViewController:socialvc];
    socialnav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"社交" image:[UIImage imageNamed:@"socialcontact"] selectedImage:[UIImage imageNamed:@"socialcontact_select"]];
    [socialnav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    

    WOTOpenDoorVC *openVC = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOpenDoorVC"];
    UIImage *img = [UIImage imageNamed:@"openDoor"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImg = [UIImage imageNamed:@"openDoor_select"];
    selectImg = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    openVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"开门" image:img selectedImage:selectImg];
    openVC.tabBarItem.imageInsets  = UIEdgeInsetsMake(-10, 0, 10, 0);
    [openVC.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    WOTBaseNavigationController *scanQRNav = [[WOTBaseNavigationController alloc]initWithRootViewController:openVC];

    
    
    WOTServiceVC *servicevc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTServiceVC"];
    servicevc.navigationItem.title = @"众创空间移动客户端";
    WOTServiceNaviController *servicnav = [[WOTServiceNaviController alloc]initWithRootViewController:servicevc];
    servicnav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"服务" image:[UIImage imageNamed:@"service"] selectedImage:[UIImage imageNamed:@"service_select"]];
    [servicnav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
//    WOTMyNaviController *myvc = [[WOTMyNaviController alloc]initWithRootViewController:[[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTMyVCID"]];
    WOTMyNaviController *myvc = [[WOTMyNaviController alloc]initWithRootViewController:[[WOTMyVC alloc]init]];
    
    myvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"my"] selectedImage:[UIImage imageNamed:@"my_select"]];
    [myvc.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    [vcarray addObject:mainnav];
    [vcarray addObject:socialnav];
    [vcarray addObject:openVC];
    [vcarray addObject:servicnav];
    [vcarray addObject:myvc];
    self.viewControllers = vcarray;
}
-(void)configTab{
   
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"fgcolor"]];
    
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
