//
//  WOTBaseNavigationController.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTBaseNavigationController.h"
#import "WOTConstants.h"


@implementation WOTBaseNavigationController 


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.barTintColor = NavigationBGColor;
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        self.navigationItem.titleView = nil;
        self.navigationBar.tintColor = UIColorFromRGB(0x888888);
        self.navigationBar.shadowImage = [[UIImage alloc]init];
        self.tabBarController.tabBar.tintColor = [UIColor blackColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = UIColor_black_b3;
        [self.navigationBar addSubview:line];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    
    //    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    
    viewController.navigationItem.leftBarButtonItems = @[backBarButtonItem];
    
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
