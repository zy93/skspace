//
//  WOTBaseNavigationController.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTBaseNavigationController.h"
#import "WOTConstants.h"


@interface  WOTBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation WOTBaseNavigationController 


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.barTintColor = UICOLOR_WHITE;
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        self.navigationItem.titleView = nil;
        self.navigationBar.tintColor = UICOLOR_GRAY_99;
        self.navigationBar.shadowImage = [[UIImage alloc]init];
        self.tabBarController.tabBar.tintColor = [UIColor blackColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = UICOLOR_MAIN_LINE;
        [self.navigationBar addSubview:line];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;    //让rootView禁止滑动
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
    //返回按钮
    if (viewController.navigationItem.leftBarButtonItem == nil &&
        [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem = [self customLeftBackButton];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - 自定义返回按钮图片
-(UIBarButtonItem*)customLeftBackButton{
    UIImage *image = [UIImage imageNamed:@"back"];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    return backItem;
}

- (void)backBarButtonItemAction
{
    [self popViewControllerAnimated:YES];
}

-(UIViewController *)getPreviousViewController
{
    return  self.viewControllers.count >1? self.viewControllers[self.viewControllers.count-2]:nil;
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
