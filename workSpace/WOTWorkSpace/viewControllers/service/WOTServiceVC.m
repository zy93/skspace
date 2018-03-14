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
#import "SKNewFacilitatorModel.h"
#import "WOTH5VC.h"
#import "MJRefresh.h"
#import "SKRepairsViewController.h"
#import "SKDemandViewController.h"
#import "SKFacilitatorModel.h"
#import "WOTEnterpriseIntroduceVC.h"
#import "UIDevice+Resolutions.h"
#import "WOTProvidersVC.h"
#import "WOTGetProvidersCell.h"
#import "WOTFeaturedProvidersCell.h"
#import "WOTFeaturedProvidersTitleCell.h"
#import "SKDemandInfoViewController.h"
#import "SKDemandViewController.h"

#define getService @"WOTGETServiceCell"
#define getProviders @"WOTGetProvidersCell"
#define providersTitle @"WOTFeaturedProvidersTitleCell"
#define providers @"WOTFeaturedProvidersCell"


#import "WOTRefreshControlUitls.h"
@interface WOTServiceVC () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate, WOTGETServiceCellDelegate, WOTGetProvidersCellDelegate, WOTFeaturedProvidersCellDelegate>
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
    self.navigationItem.title = @"服务";

    //解决状态栏空白问题
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self loadData];
    [self addData];
    [self AddRefreshHeader];
    //[self StartRefresh];
    self.scrollViewConstraint.constant = 0;
    
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
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    NSArray *section2 = @[getProviders];
    NSMutableArray *section3 = [@[providersTitle] mutableCopy];
//    tableIconList = [@[@"visitors_icon", @"maintenance_apply_icon", @"openDoor_icon", @"get_service_icon", @"feedback_icon"] mutableCopy];
//    NSArray *section3 = @[@"可操控设备"];

    tableList = [@[section1, section2, section3] mutableCopy];
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
            [self.view setNeedsLayout];
            [self.table reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
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
    self.tableHeight.constant = 110+155+55+((((NSArray *)tableList[2]).count-1)*350*[WOTUitls GetLengthAdaptRate]);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetHeight(self.autoScrollView.frame)+ self.tableHeight.constant);
}

#pragma mark - 页面跳转、该页面内请尽量都用此方法
-(void)pushToViewControllerWithStoryBoardName:(NSString * _Nullable)sbName viewControllerName:(NSString *)vcName object:(id)object
{
    UIViewController *vc = nil;
    if (strIsEmpty(sbName)) {
        vc = [[NSClassFromString(vcName) alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
    }
    else {
        vc = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    }
    
    if ([vc isKindOfClass:[WOTH5VC class]]) {
        ((WOTH5VC *)vc).url = object;
    }
    else if ([vc isKindOfClass:[SKDemandInfoViewController class]]) {
        ((SKDemandInfoViewController *)vc).typeString = object;
    }
    else if ([vc isKindOfClass:[WOTProvidersVC class]]) {
        ((WOTProvidersVC *)vc).facilitatorModel = object;
    }
    else if ([vc isKindOfClass:[WOTProvidersVC class]]) {
        ((WOTProvidersVC *)vc).facilitatorModel = object;
    }

    [self.tabBarController.tabBar setHidden:YES];
    [self.tabBarController.tabBar setTranslucent:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScroll delgate
/** 点击图片回调 */
//MARK:SDCycleScrollView   Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTworkSpaceDetailVC" object:self.bannerData[index].webpageUrl];
}

#pragma mark - cell delegate
-(void)optionService:(NSString *)serviceName
{
    if ([serviceName isEqualToString:@"意见反馈"]) {
        [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTFeedbackVC" object:nil];

    } else if ([serviceName isEqualToString:@"访客预约"]) {
        if (![WOTSingtleton shared].isuserLogin) {
            [[WOTConfigThemeUitls shared] showLoginVC:self];
            return;
        }else
        {
            [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTVisitorsAppointmentVC" object:nil];
        }
    } else if ([serviceName isEqualToString:@"问题报修"]) {
        if (![[WOTUserSingleton shareUser].userInfo.spaceId isEqualToNumber:@0]) {
           [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"SKRepairsViewController" object:nil];
        }else
        {
            [MBProgressHUDUtil showMessage:@"请先加入企业！" toView:self.view];
        }
        
    } else if ([serviceName isEqualToString:@"发布需求"]) {
        [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"SKDemandViewController" object:nil];
    }
}

-(void)getProvidersCell:(WOTGetProvidersCell *)cell selectType:(NSString *)type
{
    if ([type isEqualToString:@"更多"]) {
        [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"SKDemandViewController" object:nil];

    }
    else {
        [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"SKDemandInfoViewController" object:type];

    }
    
}

-(void)featuredProvidersCell:(WOTFeaturedProvidersCell *)cell selectIndex:(NSIndexPath *)index
{
    SKFacilitatorModel *model = tableList[index.section][index.row];
    [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"WOTProvidersVC" object:model];

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
    if ([arr[indexPath.row] isKindOfClass:[NSString class]]) {
        if ([arr[indexPath.row] isEqualToString:getService]) {
            return 100;
        }
        else if ([arr[indexPath.row] isEqualToString:getProviders]) {
            return 145;
        }
        else if ([arr[indexPath.row] isEqualToString:providersTitle]) {
            return 45;
        }
        else
            return 50;
    }
    else {
        return 340*[WOTUitls GetLengthAdaptRate];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0? 0:10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *arr = tableList[indexPath.section];
    if ([arr[indexPath.row] isKindOfClass:[NSString class]]) {
        if ([arr[indexPath.row] isEqualToString:getService]) {
            
            WOTGETServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:getService];
            if (cell == nil) {
                cell = [[WOTGETServiceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:getService];
            }
            cell.mDelegate = self;
            return cell;
        }
        else if ([arr[indexPath.row] isEqualToString:getProviders]){
            WOTGetProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:getProviders];
            if (cell == nil) {
                cell = [[WOTGetProvidersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:getProviders];
            }
            cell.delegate = self;
            return cell;
        }
        else { //if ([arr[indexPath.row] isEqualToString:providersTitle])
            WOTFeaturedProvidersTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:providersTitle];
            if (cell == nil) {
                cell = [[WOTFeaturedProvidersTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:providersTitle];
            }
            return cell;
        }
    }
    else {
        WOTFeaturedProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:providers];
        if (cell == nil) {
            cell = [[WOTFeaturedProvidersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:providers];
        }
        SKFacilitatorInfoModel *model = arr[indexPath.row];
        [cell.iconIV setImageWithURL:[model.firmLogo ToResourcesUrl]];
        cell.titleLab.text = model.firmName;
        [cell.contentIV setImageWithURL:[model.firmShow ToResourcesUrl]];
        cell.delegate = self;
        cell.index = indexPath;
        NSArray *typeArr = [model.facilitatorType componentsSeparatedByString:@","];
        if (typeArr.count==0) {
            cell.type1Lab.hidden = YES;
            cell.type2Lab.hidden = YES;
            cell.type3Lab.hidden = YES;
            cell.type4Lab.hidden = YES;
        }
        else if (typeArr.count == 1) {
            cell.type1Lab.hidden = NO;
            cell.type1Lab.text = typeArr.firstObject;
            cell.type2Lab.hidden = YES;
            cell.type3Lab.hidden = YES;
            cell.type4Lab.hidden = YES;
        }
        else if (typeArr.count == 2) {
            cell.type1Lab.hidden = NO;
            cell.type1Lab.text = typeArr.firstObject;
            cell.type2Lab.hidden = NO;
            cell.type2Lab.text = typeArr.lastObject;
            cell.type3Lab.hidden = YES;
            cell.type4Lab.hidden = YES;
        }
        else if (typeArr.count == 3) {
            cell.type1Lab.hidden = NO;
            cell.type1Lab.text = typeArr.firstObject;
            cell.type2Lab.hidden = NO;
            cell.type2Lab.text = typeArr[1];
            cell.type3Lab.hidden = NO;
            cell.type3Lab.text = typeArr.lastObject;
            cell.type4Lab.hidden = YES;
        }
        else if (typeArr.count == 4) {
            cell.type1Lab.hidden = NO;
            cell.type1Lab.text = typeArr.firstObject;
            cell.type2Lab.hidden = NO;
            cell.type2Lab.text = typeArr[1];
            cell.type3Lab.hidden = NO;
            cell.type3Lab.text = typeArr[2];
            cell.type4Lab.hidden = NO;
            cell.type4Lab.text = typeArr.lastObject;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2 && indexPath.row==0) {
        [self joinButtonMethod];
    }
}

#pragma mark - 申请入驻
-(void)joinButtonMethod
{
    [self pushToViewControllerWithStoryBoardName:@"" viewControllerName:@"WOTRegisterServiceProvidersVC" object:nil];
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
    [WOTHTTPNetwork getServiceVCServiceProviders:^(id bean, NSError *error) {
        SKNewFacilitatorModel *model = (SKNewFacilitatorModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.facilitatorData = model.msg;
            NSMutableArray *section3 = [@[providersTitle] mutableCopy];
            [section3 addObjectsFromArray:model.msg];
            [tableList removeLastObject];
            [tableList addObject:section3];
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
//    WOTEnterpriseIntroduceVC *vc = [[WOTEnterpriseIntroduceVC alloc] init];
//    vc.facilitatorModel = self.facilitatorData[tapTag];
//    vc.vcType = INTRODUCE_VC_TYPE_Providers;
    [self pushToViewControllerWithStoryBoardName:nil viewControllerName:@"WOTProvidersVC" object:self.facilitatorData[tapTag]];
    
}

@end
