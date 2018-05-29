//
//  SKBookStationVC.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKBookStationVC.h"
#import "WOTBookStationVC.h"
#import "JXPopoverView.h"

@interface SKBookStationVC ()<XXPageTabViewDelegate,UINavigationControllerDelegate>
{
    NSString *cityName;
}
@property (nonatomic, strong)UIButton *cityButton;
@property (nonatomic, strong)UIBarButtonItem *barButton;
@end

@implementation SKBookStationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self configNavi];
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setpageMenu{
    NSArray<__kindof UIViewController *> *controllers = [self createViewControllers];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:[self createTitles]];
    self.pageTabView.bottomOffLine = YES;
    //self.pageTabView.selectedColor = [UIColor colorWithHexString:@"ff7d3d"];
    [self.pageTabView addIndicatorViewWithStyle];
    [self.pageTabView layoutSubviews];
    self.pageTabView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-60);
    NSLog(@"ok:%f",self.view.frame.size.height-60);
    self.pageTabView.delegate = self;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.indicatorWidth = 20;
    
    [self.view addSubview:self.pageTabView];
}

-(void)configNavi{
    self.navigationItem.title = @"订工位";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
    
    self.cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cityButton addTarget:self action:@selector(selectSpace:) forControlEvents:UIControlEventTouchDown];
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
    self.cityButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *imageForButton = [UIImage imageNamed:@"Triangular"];
    [self.cityButton setImage:imageForButton forState:UIControlStateNormal];
    CGSize buttonTitleLabelSize = [cityName sizeWithAttributes:@{NSFontAttributeName:self.cityButton.titleLabel.font}]; //文本尺寸
    CGSize buttonImageSize = imageForButton.size;   //图片尺寸
    self.cityButton.frame = CGRectMake(0,0,
                                       buttonImageSize.width + buttonTitleLabelSize.width,
                                       buttonImageSize.height);
    self.cityButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.cityButton.imageView.frame.size.width - self.cityButton.frame.size.width + self.cityButton.titleLabel.intrinsicContentSize.width, 0, 0);
    
    self.cityButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.cityButton.titleLabel.frame.size.width - self.cityButton.frame.size.width + self.cityButton.imageView.frame.size.width);
    
    self.barButton = [[UIBarButtonItem alloc]initWithCustomView:self.cityButton];
    self.navigationItem.rightBarButtonItem = self.barButton;
    //[self configNaviRightItemWithImage:[UIImage imageNamed:@"publishSocial"]];
}

-(NSArray *)createTitles{
    return [[NSArray alloc]initWithObjects:@"短租工位",@"长租工位",nil];
}

-(NSArray<__kindof UIViewController *> *)createViewControllers{
    WOTBookStationVC *bookStationVC1 = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTBookStationVCID"];
    bookStationVC1.skTimeType = SKTIMETYPE_SHORTPERIOD;
    [self addChildViewController:bookStationVC1];
    
    WOTBookStationVC *bookStationVC2 = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTBookStationVCID"];
    bookStationVC1.skTimeType = SKTIMETYPE_LONGTIME;
    [self addChildViewController:bookStationVC2];
    
    return self.childViewControllers;
}

//#pragma mark - action
//-(void)selectSpace:(UIButton *)sender
//{
//    
//    if (self.cityList.count) {
//        JXPopoverView *popoverView = [JXPopoverView popoverView];
//        NSMutableArray *JXPopoverActionArray = [[NSMutableArray alloc] init];
//        for (NSString *name in self.cityList) {
//            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:name handler:^(JXPopoverAction *action) {
//                cityName = name;
//                [self configNavi];
//                //[self.cityButton setTitle:cityName forState:UIControlStateNormal];
//                [self createRequest];
//                //NSLog(@"测试：%@",name);
//                
//            }];
//            [JXPopoverActionArray addObject:action1];
//        }
//        [popoverView showToView:sender withActions:JXPopoverActionArray];
//    }
//}

@end