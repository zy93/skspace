//
//  WOTServiceVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTServiceVC.h"
#import "WOTRegisterServiceProvidersVC.h"
#import "WOTServiceProvidersApplyCell.h"
#import "WOTGETServiceCell.h"
#import "WOTServiceCell.h"
#import "WOTServiceForProvidersCell.h"
#import "WOTLoginVC.h"
#import "WOTOpenLockScanVC.h"
#import "WOTSliderModel.h"
#import "WOTH5VC.h"
#import "MJRefresh.h"
#import "SKRepairsViewController.h"
#import "SKDemandViewController.h"
#import "SKFacilitatorModel.h"
#import "WOTEnterpriseIntroduceVC.h"
#import "UIDevice+Resolutions.h"

#define getService @"WOTGETServiceCell"
#define serviceScroll @"serviceScroll"

#import "WOTRefreshControlUitls.h"
@interface WOTServiceVC () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate, WOTGETServiceCellDelegate>
{
    NSMutableArray *tableList;
    NSMutableArray *tableIconList;
}
//@property(nonatomic,strong)WOTRefreshControlUitls *refreshControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerConstraint;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *autoScrollView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@property (nonatomic,strong) NSMutableArray *imageUrlStrings;
@property (nonatomic,strong) NSMutableArray *imageTitles;
@property (nonatomic,strong) NSMutableArray *sliderUrlStrings;
@property (nonatomic,strong) NSArray <WOTSliderModel*> *bannerData;
@property (nonatomic,strong) NSArray <SKFacilitatorInfoModel*> *facilitatorData;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewHeight;


@end

@implementation WOTServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configNav];
    [self addData];
    [self AddRefreshHeader];
    //[self StartRefresh];
    CGFloat  buff = [[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina58 ? -44: 0;
    self.scrollViewConstraint.constant = 0;
    self.bannerConstraint.constant = buff;
    self.scrollView.clipsToBounds = NO;
 
//废弃
//   _refreshControl = [[WOTRefreshControlUitls alloc]initWithScroll:self.table];
//    [_refreshControl addTarget:self action:@selector(downLoadRefresh) forControlEvents:UIControlEventAllEvents];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //不要使用点语法，否则会设置失败。。。
    [self.tabBarController.tabBar setHidden:NO];
    [self.tabBarController.tabBar setTranslucent:NO];
    [self.navigationController.navigationBar setHidden:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)configNav{
    self.navigationItem.title = @"服务";
}
#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UIScrollView *pTableView = self.scrollView;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    //[_pageFlowView removeFromSuperview];
    if (_scrollView.mj_footer != nil && [_scrollView.mj_footer isRefreshing])
    {
        [_scrollView.mj_footer endRefreshing];
    }
    
    [self loadData];
}

- (void)StopRefresh
{
    if (_scrollView.mj_header != nil && [_scrollView.mj_header isRefreshing])
    {
        [_scrollView.mj_header endRefreshing];
    }
}


- (NSMutableArray *)imageUrlStrings {
    if (_imageUrlStrings == nil) {
        _imageUrlStrings = [NSMutableArray array];
    }
    return _imageUrlStrings;
}

- (NSMutableArray *)imageTitles {
    if (_imageTitles == nil) {
        _imageTitles = [NSMutableArray array];
    }
    return _imageTitles;
}

- (NSMutableArray *)sliderUrlStrings {
    if (_sliderUrlStrings == nil) {
        _sliderUrlStrings = [NSMutableArray array];
    }
    return _sliderUrlStrings;
}

-(void)addData
{
    NSArray *section1 = @[getService];
    NSArray *section2 = @[serviceScroll];
//    tableIconList = [@[@"visitors_icon", @"maintenance_apply_icon", @"openDoor_icon", @"get_service_icon", @"feedback_icon"] mutableCopy];
//    NSArray *section3 = @[@"可操控设备"];

    tableList = [@[section1, section2] mutableCopy];
    [self.table reloadData];
}

-(void)loadData
{
    [self getNannerData:^{
        [self StopRefresh];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadAutoScrollView];
            
        });
    }];
    [self getFacilitatorData:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
            //[self StopRefresh];
        });
    }];
    
}

#pragma mark - setup View
-(void)loadAutoScrollView{
 
    
//
    for (WOTSliderModel *model in self.bannerData) {
        [_imageTitles addObject:model.proclamationTitle];
        //        NSLog(@"图片地址：%@",[NSString convertUnicode:model.coverPicture]);
        //        NSString *imageUrl = [NSString convertUnicode:model.coverPicture];
        NSLog(@"图片地址url：%@",[model.coverPicture ToResourcesUrl]);
        [_imageUrlStrings addObject:[model.coverPicture ToResourcesUrl]];
    }

    self.autoScrollView.imageURLStringsGroup = _imageUrlStrings;
//    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.autoScrollView.delegate = self;
    self.autoScrollView.titlesGroup = _imageTitles;
    //self.autoScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    //self.autoScrollView.currentPageDotColor = [UIColor blueColor];//dong
    //self.autoScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    int coun = -2; //前两个不算.
//    for (NSArray * arr in tableList) {
//        coun+=arr.count;
//    }
    self.tableHeight.constant = 100+50+250;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetHeight(self.autoScrollView.frame)+ self.tableHeight.constant);
}

#pragma mark - 页面跳转、该页面内请尽量都用此方法
-(void)pushToViewControllerWithStoryBoardName:(NSString * _Nullable)sbName viewControllerName:(NSString *)vcName
{
    UIViewController *vc = nil;
    if (strIsEmpty(sbName)) {
        vc = [[NSClassFromString(vcName) alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
    }
    else {
        vc = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScroll delgate
/** 点击图片回调 */
//MARK:SDCycleScrollView   Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = self.bannerData[index].webpageUrl;
    [self.navigationController pushViewController:detailvc animated:YES];
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
}

#pragma mark - cell delegate
-(void)optionService:(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"意见反馈"]) {
        [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTFeedbackVC"];

    } else if ([serviceName isEqualToString:@"访客预约"]) {
        [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTVisitorsAppointmentVC"];

    } else if ([serviceName isEqualToString:@"问题报修"]) {
        if (![[WOTUserSingleton shareUser].userInfo.spaceId isEqualToNumber:@0]) {
           [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"SKRepairsViewController"];
        }else
        {
            [MBProgressHUDUtil showMessage:@"请先加入企业！" toView:self.view];
        }
        
    } else if ([serviceName isEqualToString:@"发布需求"]) {
        [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"SKDemandViewController"];
    }
}

#pragma mark - Table delegate & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArr = tableList[section];
    return sectionArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = tableList[indexPath.section];
    if ([arr[indexPath.row] isEqualToString:getService]) {
        return 100;
    }
    else {
        return 250;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0? 0:10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *arr = tableList[indexPath.section];
    if ([arr[indexPath.row] isEqualToString:getService]) {
        
        WOTGETServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTGETServiceCell"];
        if (cell == nil) {
            cell = [[WOTGETServiceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTGETServiceCell"];
        }
        cell.mDelegate = self;
        return cell;
    }
    else {
        WOTServiceForProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTServiceForProvidersCell"];
        if (cell == nil) {
            cell = [[WOTServiceForProvidersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WOTServiceForProvidersCell"];
        }
        [cell.joinButton addTarget:self action:@selector(joinButtonMethod) forControlEvents:UIControlEventTouchDown];
        [cell setData:self.facilitatorData];
        cell.imageBlock = ^(NSInteger tapTag){
            NSLog(@"%ld",tapTag);
            __weak typeof(self) weakSelf = self;
            [weakSelf facilitatorInfoMethod:tapTag];
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 申请入驻
-(void)joinButtonMethod
{
    [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"WOTRegisterServiceProvidersVC"];
}

#pragma mark - 获取服务banner数据
-(void)getNannerData:(void(^)())complete{
    
    _imageTitles = [[NSMutableArray alloc] init];
    _imageUrlStrings = [[NSMutableArray alloc] init];
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getServiceBannerData:^(id bean, NSError *error) {
        complete();
        WOTSliderModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.bannerData = model.msg.list;
        }
        //complete();
    }];
    //complete();
}
    
#pragma mark - 获取服务商列表
-(void)getFacilitatorData:(void(^)())complete{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getServiceProviders:^(id bean, NSError *error) {
        complete();
        SKFacilitatorModel *model = (SKFacilitatorModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.facilitatorData = model.msg.list;
            
        }else
        {
            [MBProgressHUDUtil showMessage:@"获取服务商失败！" toView:self.view];
            return ;
        }
        complete();
    }];
    //complete();
}

-(NSArray<SKFacilitatorInfoModel*>*)facilitatorData
{
    if (_facilitatorData == nil) {
        _facilitatorData = [[NSArray alloc] init];
    }
    return _facilitatorData;
}

#pragma mark - 跳转到服务商详细信息界面
-(void)facilitatorInfoMethod:(NSInteger)tapTag
{
    WOTEnterpriseIntroduceVC *vc = [[WOTEnterpriseIntroduceVC alloc] init];
    vc.facilitatorModel = self.facilitatorData[tapTag];
    vc.vcType = INTRODUCE_VC_TYPE_Providers;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
