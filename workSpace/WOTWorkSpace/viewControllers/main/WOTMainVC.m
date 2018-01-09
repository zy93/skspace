//
//  WOTMainVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMainVC.h"

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "ZYQSphereView.h"
#import "WOTWorkSpaceListVC.h"
#import "WOTH5VC.h"
#import "WOTEnterpriseLIstVC.h"
#import "WOTActivitiesLIstVC.h"
#import "WOTInformationListVC.h"
#import "WOTBookStationVC.h"
#import "WOTTEnterpriseListCell.h"
#import "WOTEnterpriseModel.h"
#import "WOTSliderModel.h"
#import "WOTLocationManager.h"
#import "WOTCardViewItem.h"
#import "WOTRefreshControlUitls.h"
#import "UIImageView+AFNetworking.h"
#import "WOTEnterpriseScrollView.h"
#import "SKGiftBagViewController.h"
#import "WOTVisitorsAppointmentVC.h"
#import "SDCycleScrollView.h"
#import "ZYQSphereView.h"
#import "WOTSpaceModel.h"
#import "WOTShortcutMenuView.h"
#import "CardView.h"

@interface WOTMainVC ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,SDCycleScrollViewDelegate,WOTShortcutMenuViewDelegate>
@property(nonatomic,strong)ZYQSphereView *sphereView;
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

//空间
//@property (weak, nonatomic) IBOutlet CardView *spaceView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *autoScrollView;
@property (weak, nonatomic) IBOutlet UIView *spaceView;

@property (weak, nonatomic) IBOutlet WOTShortcutMenuView *ballView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (weak, nonatomic) IBOutlet UIView *workspaceView;
@property (weak, nonatomic) IBOutlet UIView *enterpriseView;

//企业
@property (weak, nonatomic) IBOutlet WOTEnterpriseScrollView *enterpriseScrollView;
//活动
@property (weak, nonatomic) IBOutlet UIImageView *activityIV;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLab;
@property (weak, nonatomic) IBOutlet UILabel *activityDateLab;

//资讯
@property (weak, nonatomic) IBOutlet UIImageView *newsIV;
@property (weak, nonatomic) IBOutlet UILabel *newsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *newsDateLab;


@property (nonatomic,strong) NSArray <WOTSliderModel*>   *bannerData;   //轮播图list
@property (nonatomic,strong) NSArray <WOTActivityModel*> *activityData;//活动list
@property (nonatomic,strong) NSArray <WOTSpaceModel *>   *spaceData;  //空间list
@property (nonatomic,strong) NSArray <WOTNewsModel  *>   *newsData; //资讯list
@property (nonatomic,  copy) NSString *cityName;
@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self load3DBallView];
    self.ballView.delegate = self;
    [self configScrollView];
    [self getAllData];
    [self AddRefreshHeader];
     // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = NO;
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

int a = 0;
-(void)viewDidAppear:(BOOL)animated{
    //必须在页面出现以后，重新设置scrollview 的contengsize
    if (a++<=0) {
        [self loadLocationSpace];
    }
    [super viewDidAppear:animated];
    self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+self.enterpriseView.frame.size.height+70);
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

-(void)configScrollView{
    self.scrollVIew.delegate = self;
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    self.scrollVIew.showsVerticalScrollIndicator = NO;
    self.scrollVIew.backgroundColor = UICOLOR_MAIN_BACKGROUND;
}

#pragma mark - 加载所有的数据
-(void)getAllData{
    [self getBannerDataSource:^{
        [self loadAutoScrollView];
    }];
    [self getDataSourceFromWebFWithCity:nil complete:^{
    } loadVIews:^{
        dispatch_async(dispatch_get_main_queue(), ^{
           // [self.spaceView reloadData];
            //[self loadAutoScrollView];
            [self loadSpaceView];
        });
    }];
    [self getEnterpriseListDataFromWeb:^{
        [self StopRefresh];
    }];
    
    [self getActivityDataFromWeb:^{
    }];
    
    [self getInfoDataFromWeb:^{
    }];
    
}


#pragma mark - load View
-(void)loadAutoScrollView{
    
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    
    for (WOTSliderModel *model in self.bannerData) {
        [titleArr addObject:model.proclamationTitle];
//        NSLog(@"图片地址：%@",[NSString convertUnicode:model.coverPicture]);
//        NSString *imageUrl = [NSString convertUnicode:model.coverPicture];
        NSLog(@"图片地址url：%@",[model.coverPicture ToResourcesUrl]);
        [imageArr addObject:[model.coverPicture ToResourcesUrl]];
    }
    
    self.autoScrollView.imageURLStringsGroup = imageArr;
    self.autoScrollView.delegate = self;
    self.autoScrollView.titlesGroup = titleArr;
    self.autoScrollView.pageDotColor = UICOLOR_GRAY_66;
    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;//dong删除默认居中
    self.autoScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;  //设置图片填充格式
//    self.autoScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
//    self.autoScrollView.currentPageDotColor = [UIColor blueColor];//dong pageDotColor
//    self.autoScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
}

- (void)loadSpaceView {
    if (!_pageFlowView) {
        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, self.spaceView.frame.size.height-10)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        
        //初始化pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 10, SCREEN_WIDTH, 8)];
        _pageFlowView.pageControl = pageControl;
        [_pageFlowView addSubview:pageControl];
    }
    
    [self.spaceView addSubview:_pageFlowView];
    
    [_pageFlowView reloadData];
    
}


-(void)loadLocationSpace
{
    [[WOTLocationManager shareLocation] getLocationWithBlock:^(CGFloat lat, CGFloat lon,NSString* cityName) {
        [WOTSingtleton shared].cityName = cityName;//得到所在城市
        NSLog(@"lat:%f,lon:%f",lat,lon);
        [WOTHTTPNetwork getSpaceWithLocation:lat lon:lon response:^(id bean, NSError *error) {
            [WOTSingtleton shared].nearbySpace = ((WOTLocationModel_Msg*)bean).msg;
            
        }];
    }];
    
}

//MARK:点击显示新页面
#pragma mark - action
- (IBAction)showWorkSpaceVC:(id)sender {
    [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTWorkSpaceListVC"];
}

- (IBAction)showActivitiesVC:(id)sender {
    [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTActivitiesLIstVC"];
}
- (IBAction)showInformationLIstVC:(id)sender {
    [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTInformationListVC"];
}
- (IBAction)showEnterpriseListVC:(id)sender {
    [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTEnterpriseLIstVC"];
}
//跳转活动详情页
- (IBAction)showActivityDetail:(id)sender {
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    WOTActivityModel *model = self.activityData.firstObject;
    detailvc.url = [model.htmlLocation stringToResourcesUrl];
    [self.navigationController pushViewController:detailvc animated:YES];
}
//跳转新闻详情页
- (IBAction)showInfoDetail:(id)sender {
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    WOTNewsModel *model = self.newsData.firstObject;
    detailvc.url = [model.htmlLocation stringToResourcesUrl];
    [self.navigationController pushViewController:detailvc animated:YES];
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
    if ([vc isKindOfClass:[WOTVisitorsAppointmentVC class]]) {
        if (![WOTSingtleton shared].isuserLogin) {
            [[WOTConfigThemeUitls shared] showLoginVC:self];
            return;
        }
    } else if ([vc isKindOfClass:[WOTActivitiesLIstVC class]]) {
        [(WOTActivitiesLIstVC*)vc setDataSource:self.activityData];
    }
    else if ([vc isKindOfClass:[WOTWorkSpaceListVC class]]) {
        [(WOTWorkSpaceListVC *)vc setDataSource:self.spaceData];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

/*
-(void)load3DBallView{
   
    if (IS_IPHONE_5) {
         _sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(-1,11, self.ballView.frame.size.width-30, self.ballView.frame.size.height-30)];
    } else {
         _sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(-1,11, self.ballView.frame.size.width, self.ballView.frame.size.height)];
    }
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (int i = 0; i < [WOTSingtleton shared].ballTitle.count; i++) {
        UIView * subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80,80)];
//        subview.backgroundColor = UIColorFromRGB(0x86d3ff);
        subview.backgroundColor = UICOLOR_CLEAR;
      
        [subview setCorenerRadius:subview.frame.size.width/2 borderColor:UICOLOR_CLEAR];
        UIImageView *bgimage = [[UIImageView alloc]initWithFrame:subview.bounds];
        [bgimage setImage:[UIImage imageNamed:@"ball_iconbgimage"]];
        [subview addSubview:bgimage];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(23, 10, 35,35)];
        icon.image = [UIImage imageNamed:[WOTSingtleton shared].ballImage[i]];
        [subview addSubview:icon];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5,50,70,25)];
        title.text = [WOTSingtleton shared].ballTitle[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:14.0];
        title.textColor = RGBA(129.0, 225.0, 250.0, 1.0);
        [subview addSubview:title];
        UIButton *subbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80,80)];
        
        [subbtn setBackgroundColor:UICOLOR_CLEAR];
        subbtn.alpha = 0.5;
        subbtn.tag = i;
        [subbtn setCorenerRadius:subbtn.frame.size.width/2 borderColor:UICOLOR_CLEAR];
        [subbtn addTarget:self action:@selector(subVClick:) forControlEvents:UIControlEventTouchUpInside];
        [subview addSubview:subbtn];
        [views addObject:subview];
        
    }
    
    [_sphereView setItems:views];
    
    _sphereView.isPanTimerStart=YES;
  
    [self.ballView addSubview:_sphereView];
    [_sphereView timerStart];
    
}
 
//3D球点击事件
-(void)subVClick:(UIButton*)sender{
    
    NSLog(@"%@",[WOTSingtleton shared].ballTitle[sender.tag]);
    
    BOOL isStart=[_sphereView isTimerStart];
    
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform=CGAffineTransformMakeScale(1, 1);
            if (isStart) {
                [_sphereView timerStart];
            }
        }];
    }];
//    WOT3DBallVCType balltype = [[[WOTEnumUtils alloc]init] Wot3DballVCtypeenumToString:[WOTSingtleton shared].ballTitle[sender.tag]];

    switch (sender.tag) {
        case 0:
           //资讯
            [self showNewInfoVC];
            break;
        case 1:
            //友邻
           
            [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTEnterpriseLIstVCID"];
            break;
        
        case 2:
            //订工位
            
            [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTBookStationVCID"];
            break;
        case 3:
            //订会议室
            [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTReservationsMeetingVC"];
            break;
        case 4:
            //开门
            
             [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTOpenLockScanVCID"];
            break;
        case 5:
            //活动
             [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTActivitiesLIstVC"];
            break;
        case 6:
         
            //访客
             [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTVisitorsAppointmentVC"];
            break;
        case 7:
            //一键报修
             [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTMainAppleRepairVCID"];
            break;
        case 8:
            //一键反馈
             [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTFeedbackVC"];
            break;
       
            
        default:
            break;
    }
}
*/


#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UIScrollView *pTableView = _scrollVIew;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    //[self.scrollVIew removeFromSuperview];
    //[self.spaceView removeFromSuperview];
    [_pageFlowView removeFromSuperview];
    if (_scrollVIew.mj_footer != nil && [_scrollVIew.mj_footer isRefreshing])
    {
        [_scrollVIew.mj_footer endRefreshing];
    }
    [self getAllData];
}

- (void)StopRefresh
{
    if (_scrollVIew.mj_header != nil && [_scrollVIew.mj_header isRefreshing])
    {
        [_scrollVIew.mj_header endRefreshing];
    }
}


#pragma mark - main scrollview delegate
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - NewPagedFlowView Delegate & Datasource
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 60, (SCREEN_WIDTH - 60) * 9 / 16);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    [self.navigationController pushViewController:detailvc animated:YES];
}

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.spaceData.count>5?5:self.spaceData.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //从网络加载图片用    
    [bannerView.mainImageView sd_setImageWithURL:[self.spaceData[index].spacePicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_space"]];
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}


#pragma mark - shortcut delegate
-(void)shortcutMenu:(WOTShortcutMenuView *)menu pushToVCWithStoryBoardName:(NSString *)sbName vcName:(NSString *)vcName
{
    [self pushToViewControllerWithStoryBoardName:sbName viewControllerName:vcName];
}


//#pragma mark - Card Delegate & DataSource  空间卡片
//-(NSInteger)numberOfItemsInCardView:(CardView *)cardView
//{
//    return self.spaceData.count;
//}
//
//-(CardViewItem *)cardView:(CardView *)cardView itemAtIndex:(NSInteger)index
//{
//    WOTCardViewItem *item = (WOTCardViewItem *)[cardView dequeueReusableCellWithIdentifier:@"WOTCardViewItem"];
//    WOTSpaceModel *model = self.spaceData[index];
//
//    NSArray *urlArr= [model.spacePicture componentsSeparatedByString:@","];
//    NSString *urlstr = urlArr.firstObject;
//    [item.bgIV setImageWithURL:[urlstr ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_space"]];
//    [item.title setText:model.spaceName];
//    return item;
//}
//
//-(CGRect)cardView:(CardView *)cardView rectForItemAtIndex:(NSInteger)index
//{
//    return CGRectMake(0, 0, SCREEN_WIDTH-40, self.spaceView.height - 35);
//}
//
//-(void)cardView:(CardView *)cardView didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"卡片%ld被选中", (long)index);
//}

#pragma mark - SDCycleScrollView Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
//    detailvc.url = _sliderUrlStrings[index];
    [self.navigationController pushViewController:detailvc animated:YES];
}

#pragma mark -  Network
-(void)getEnterpriseListDataFromWeb:(void(^)())complete{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getEnterprisesWithSpaceId:[[NSNumber alloc]initWithInt:69] response:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTEnterpriseModel_msg *dd = (WOTEnterpriseModel_msg *)bean;
            [weakSelf.enterpriseScrollView setData:dd.msg.list];
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
    }];
}

-(void)getBannerDataSource:(void(^)())complete{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getHomeSliderSouceInfo:^(id bean, NSError *error) {
        WOTSliderModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.bannerData = model.msg.list;
            complete();
        }
        else {
            
        }
    }];
}

-(void)getDataSourceFromWebFWithCity:( NSString * __nullable )city complete:(void(^)())complete loadVIews:(void(^)())loadViews{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getSapaceWithPage:@1 pageSize:@5 response:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTSpaceModel_msg *model = (WOTSpaceModel_msg *)bean;
            weakSelf.spaceData = model.msg.list;
            if (self.spaceData.count>5) {
                    weakSelf.spaceData = [model.msg.list subarrayWithRange:NSMakeRange(0, 4)];
            } else {
                    weakSelf.spaceData = model.msg.list ;
            }
            loadViews();
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
    }];
    
}


-(void)getActivityDataFromWeb:(void(^)())complete{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getActivitiesWithPage:@(1) response:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTActivityModel_msg *model = (WOTActivityModel_msg *)bean;
            weakSelf.activityData = model.msg.list;
            WOTActivityModel *activModle= model.msg.list.firstObject;
            [weakSelf.activityIV setImageWithURL:[activModle.pictureSite ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_activity"]];
            [weakSelf.activityNameLab setText:activModle.title];
            [weakSelf.activityDateLab setText:[activModle.starTime getDate]];

        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
}



-(void)getInfoDataFromWeb:(void(^)())complete{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getNewsWithPage:@(1) response:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTNewsModel_msg *model = (WOTNewsModel_msg *)bean;
            weakSelf.newsData = model.msg.list;
            WOTNewsModel *newsModle = model.msg.list.firstObject;
            [weakSelf.newsIV setImageWithURL:[newsModle.pictureSite ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_activity"]];
            [weakSelf.newsNameLab setText:newsModle.title];
            [weakSelf.newsDateLab setText:[newsModle.issueTime getDate]];
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }

    }];
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
