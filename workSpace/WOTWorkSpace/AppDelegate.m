//
//  AppDelegate.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "WOTWXApiManager.h"
//#import "LoginViewController.h"

#define MAP_API_KEY @"47411f2c349b36c1fbdee073cd648149"
@interface AppDelegate ()
@property (nonatomic, strong)WOTTabBarVCViewController *tabbar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.tabbar = [[WOTTabBarVCViewController alloc]init];
    //self.tabbar.delegate = self;
    [self loadTabView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    [self registerPush];
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"59642cfcc62dca6c850020c0"];
    [self ConfigUSharePlatforms];
    
    //配置高德地图key
    [AMapServices sharedServices].apiKey =  MAP_API_KEY;
    
    [WXApi registerApp:APPID enableMTA:YES];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WOTWorkSpace"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


-(void)loadTabView{
   // WOTTabBarVCViewController *tabbar = [[WOTTabBarVCViewController alloc]init];
    self.window.rootViewController =self.tabbar ;
}

#pragma mark - private methods

-(void)ConfigUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa41b37164b2030d6" appSecret:@"66c32b5f5d54e22f958b770eb039718e" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101415512"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"958434094"  appSecret:@"c8126f4af61b6287bd2ce86a54360e7f" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


//支付宝支付
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
       
    }else{
        
        
        [WXApi handleOpenURL:url delegate:[WOTWXApiManager sharedManager]];
        
    }
    return YES;
    
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
      
    }else{
        return [WXApi handleOpenURL:url delegate:[WOTWXApiManager sharedManager]];
    }
    return YES;
    
}


#pragma mark - 微信支付回调方法
- (void)onResp:(BaseResp*)resp
{
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    
    if([resp isKindOfClass:[PayResp class]])
    {
        // 支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                //                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                //                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"success"];
                //                [[NSNotificationCenter defaultCenter] postNotification:notification];
                //                NSNotification *rechargeNoti = [NSNotification notificationWithName:RECHARGE_PAY_NOTIFICATION object:@"recharge_success"];
                //                [[NSNotificationCenter defaultCenter] postNotification:rechargeNoti];
                //
                
                break;
            }
                
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                //                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr]];
                //
                //                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"fail"];
                //                [[NSNotificationCenter defaultCenter] postNotification:notification];
                //                NSNotification *rechargeNoti = [NSNotification notificationWithName:RECHARGE_PAY_NOTIFICATION object:@"fail"];
                //                [[NSNotificationCenter defaultCenter] postNotification:rechargeNoti];
                
                break;
            }
        }
    }
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    //    [alert show];
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{//每次点击都会执行的方法
//    if([viewController.tabBarItem.title isEqualToString:@"我的"]){//判断点击的tabBarItem的title是不是购物车，如果是继续执行
//        if(![WOTSingtleton shared].isuserLogin){//当登录的时候存储一个标识，判断是否登录过，没登录执行下面代码进入登录页
//           // LoginViewController *loginVC = [[LoginViewController alloc] init];
//            LoginViewController *loginVC = [[LoginViewController alloc]init]; //登陆界面
//            //loginVC.selectedIndex = selectedIndex;    //将所选的TabbarItem 传入登陆界面
//            loginVC.hidesBottomBarWhenPushed = YES;   //隐藏Tabbar
//            //[loginVC.navigationController setNavigationBarHidden:YES];
//            [loginVC.navigationController setNavigationBarHidden:YES animated:YES];
//            UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];   //使登陆界面的Navigationbar可以显示出来
//            [((UINavigationController *)tabBarController.selectedViewController) presentViewController:loginNav animated:YES completion:nil]; //跳转登陆界面
//
//
//        }
//    }
//}

@end
