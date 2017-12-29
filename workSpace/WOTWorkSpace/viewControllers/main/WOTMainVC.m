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
#import "WOTEnumUtils.h"
#import "WOTTEnterpriseListCell.h"
#import "WOTEnterpriseModel.h"
#import "WOTSliderModel.h"
#import "WOTLocationManager.h"
#import "MJRefresh.h"
#import "WOTCardViewItem.h"
#import "WOTRefreshControlUitls.h"
#import "UIImageView+AFNetworking.h"
#import "WOTEnterpriseScrollView.h"
#import "SKGiftBagViewController.h"

@interface WOTMainVC ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,SDCycleScrollViewDelegate,WOTShortcutMenuViewDelegate>
@property(nonatomic,strong)ZYQSphereView *sphereView;
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

//空间
//@property (weak, nonatomic) IBOutlet CardView *spaceView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *spaceView;

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

@property (nonatomic,strong) NSMutableArray *imageUrlStrings;
@property (nonatomic,strong) NSMutableArray *spaceImageUrlStrings;
@property (nonatomic,strong) NSMutableArray *spaceTitleArray;



@property (nonatomic,strong) NSArray *bannerData;  //轮播图list 类型未确定
@property (nonatomic,strong) NSArray <WOTActivityModel*> *activityData; //活动list
@property (nonatomic,strong) NSArray <WOTSpaceModel *>   *spaceData;  //空间list
@property (nonatomic,strong) NSArray <WOTNewsModel  *>   *newsData; //资讯list
@property (nonatomic,  copy) NSString *cityName;
@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self load3DBallView];
    self.spaceImageUrlStrings = [[NSMutableArray alloc] init];
    self.spaceTitleArray = [[NSMutableArray alloc] init];
    [self loadAutoScrollView];
    [self configScrollView];
    self.ballView.delegate = self;
//    self.spaceView.delegate   = self;
//    self.spaceView.dataSource = self;
//    self.spaceView.maxItems   = 3;
//    self.spaceView.scaleRatio = 0.05;
//    [self.spaceView registerXibFile:@"WOTCardViewItem" forItemReuseIdentifier:@"WOTCardViewItem"];

//    self.cardViewHeightConstraint.constant = CARD_ITEM_H + 100;
    
    
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
int a = 0;

-(void)viewDidAppear:(BOOL)animated{
    //必须在页面出现以后，重新设置scrollview 的contengsize
    if (a++<=0) {
        [self loadLocation];
    }
    [super viewDidAppear:animated];
//    NSLog(@"高度：%f",self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+self.enterpriseView.frame.size.height+70);
    self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+self.enterpriseView.frame.size.height+70);
}

#pragma mark - setup view

#pragma mark - 加载所有的数据
-(void)getAllData{
    
//    dispatch_queue_t queue = dispatch_queue_create("com.workspacek.gcd.group", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_enter(group);
//    [self getEnterpriseListDataFromWeb:^{
//        
//    }];
//    dispatch_group_leave(group);
//    dispatch_group_enter(group);
//    [self getActivityDataFromWeb:^{
//        
//    }];
//    dispatch_group_leave(group);
//    dispatch_group_enter(group);
//    [self getInfoDataFromWeb:^{
//        
//    }];
//    dispatch_group_leave(group);
//    dispatch_group_enter(group);
//    [self getSliderDataSource:^{
//        [self loadAutoScrollView];
//        
//    }];
//    dispatch_group_leave(group);
//    dispatch_group_enter(group);
//    [self loadSpaceView];
//    dispatch_group_leave(group);
    
    [self getBannerDataSource:^{
        [self loadAutoScrollView];
    }];
    [self getDataSourceFromWebFWithCity:nil complete:^{
    } loadVIews:^{
        dispatch_async(dispatch_get_main_queue(), ^{
           // [self.spaceView reloadData];
            [self loadAutoScrollView];
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

-(void)configScrollView{
    self.scrollVIew.delegate = self;
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    self.scrollVIew.showsVerticalScrollIndicator = NO;
    self.scrollVIew.backgroundColor = MainColor;
}

#pragma mark -- 获取最近空间
-(void)loadLocation
{
    [[WOTLocationManager shareLocation] getLocationWithBlock:^(CGFloat lat, CGFloat lon,NSString* cityName) {
        [WOTSingtleton shared].cityName = cityName;//得到所在城市
        NSLog(@"lat:%f,lon:%f",lat,lon);
        [WOTHTTPNetwork getSpaceWithLocation:lat lon:lon response:^(id bean, NSError *error) {
            [WOTSingtleton shared].nearbySpace = ((WOTLocationModel_Msg*)bean).msg;
            
        }];
    }];
    
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
        subview.backgroundColor = CLEARCOLOR;
      
        [subview setCorenerRadius:subview.frame.size.width/2 borderColor:CLEARCOLOR];
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
        
        [subbtn setBackgroundColor:CLEARCOLOR];
        subbtn.alpha = 0.5;
        subbtn.tag = i;
        [subbtn setCorenerRadius:subbtn.frame.size.width/2 borderColor:CLEARCOLOR];
        [subbtn addTarget:self action:@selector(subVClick:) forControlEvents:UIControlEventTouchUpInside];
        [subview addSubview:subbtn];
        [views addObject:subview];
        
    }
    
    [_sphereView setItems:views];
    
    _sphereView.isPanTimerStart=YES;
  
    [self.ballView addSubview:_sphereView];
    [_sphereView timerStart];
    
}
*/

#pragma mark - 加载滚动视图
-(void)loadAutoScrollView{
    

    self.autoScrollView.imageURLStringsGroup = _imageUrlStrings;
//    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;//dong删除默认居中
    
//    self.autoScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;  //设置图片填充格式
    self.autoScrollView.delegate = self;
    //self.autoScrollView.titlesGroup = _imageTitles;
    //self.autoScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.autoScrollView.pageDotColor = [[UIColor alloc] initWithRed:13.0/255.0f green:13.0/255.0f blue:13.0/255.0f alpha:0.2];
    //self.autoScrollView.currentPageDotColor = [UIColor blueColor];//dong
    //pageDotColor
    //self.autoScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    self.spaceView.imageURLStringsGroup = _spaceImageUrlStrings;
    self.spaceView.delegate = self;
    self.spaceView.titlesGroup = _spaceTitleArray;
    //self.spaceView.pageDotColor = [[UIColor alloc] initWithRed:13.0/255.0f green:13.0/255.0f blue:13.0/255.0f alpha:0.2];
    //self.spaceView.onlyDisplayText = YES;
}


/*

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
             [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTActivitiesLIstVCID"];
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

-(void)pushToViewControllerWithStoryBoardName:(NSString *)sbName viewControllerName:(NSString *)vcName
{
    UIViewController *stationvc = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    if ([stationvc isKindOfClass:[WOTEnterpriseLIstVC class]]) {
        [((WOTEnterpriseLIstVC *)stationvc) getEnterpriseListDataFromWeb:^{
        }];
    }

    [self.navigationController pushViewController:stationvc animated:YES];
}

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


////page view UI
//- (void)setupUI {
//    if (!_pageFlowView) {
//        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, self.spaceView.frame.size.height-20)];
//        _pageFlowView.delegate = self;
//        _pageFlowView.dataSource = self;
//        _pageFlowView.minimumPageAlpha = 0.1;
//        _pageFlowView.isCarousel = NO;
//        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
//        _pageFlowView.isOpenAutoScroll = YES;
//        
//        //初始化pageControl
//        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 32, SCREEN_WIDTH, 8)];
//        _pageFlowView.pageControl = pageControl;
//        [_pageFlowView addSubview:pageControl];
//    }
//   
//    [self.spaceView addSubview:_pageFlowView];
//    
//    [_pageFlowView reloadData];
//    
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//#pragma mark - NewPagedFlowView Delegate
//- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
//    return CGSizeMake(SCREEN_WIDTH - 60, (SCREEN_WIDTH - 60) * 9 / 16);
//}
//- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
//    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
//    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
//    [self.navigationController pushViewController:detailvc animated:YES];
//}
//
//#pragma mark  NewPagedFlowView Datasource
//- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
//    return self.bannerData.count;
//}
//
//- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
//    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
//    if (!bannerView) {
//        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16)];
//        bannerView.tag = index;
//        bannerView.layer.cornerRadius = 4;
//        bannerView.layer.masksToBounds = YES;
//    }
//    //从网络加载图片用
//    //NSLog(@"网络图片地址：%@",[self.spaceData[index] objectForKey:@"spacePicture"]);
//    NSLog(@"----%@",self.spaceData[index].spacePicture);
//
//      [bannerView.mainImageView sd_setImageWithURL:[[NSString stringWithFormat:@"%@%@",HTTPBaseURL,self.spaceData[index].spacePicture] ToUrl]placeholderImage:[UIImage imageNamed:@"spacedefault"]];
//
//    if ([self.spaceData[index].spacePicture separatedWithString:@","].count!=0) {
//        [bannerView.mainImageView sd_setImageWithURL:[[self.spaceData[index].spacePicture separatedWithString:@","][0] ToUrl] placeholderImage:[UIImage imageNamed:@"spacedefault"]];
//
//        NSLog(@"图片地址：%@",[NSString stringWithFormat:@"%@%@",HTTPBaseURL,[self.spaceData[index].spacePicture separatedWithString:@","][0]]);
//    }
//    return bannerView;
//}
//
//- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
//    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
//}


#pragma mark - shortcut delegate
-(void)pushToVCWithStoryBoardName:(NSString *)sbName vcName:(NSString *)vcName
{
    if ([vcName isEqualToString:@"WOTOpenLockScanVCID"]) {
        SKGiftBagViewController * giftBagVC = [[SKGiftBagViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:giftBagVC animated:YES];
        return;
    }
    
    [self pushToViewControllerWithStoryBoardName:sbName viewControllerName:vcName];
}

//MARK:点击显示新页面
- (IBAction)showWorkSpaceVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    WOTWorkSpaceListVC *spacevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTWorkSpaceListVC"];
    [spacevc setDataSource:self.spaceData];
    [self.navigationController pushViewController:spacevc animated:YES];
}


- (IBAction)showActivitiesVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    WOTActivitiesLIstVC  *acvc = [storyboard instantiateViewControllerWithIdentifier:@"WOTActivitiesLIstVCID"];
    [acvc setDataSource:self.activityData];
    [self.navigationController pushViewController:acvc animated:YES];
    
    
}
- (IBAction)showInformationLIstVC:(id)sender {
    
    [self pushToViewControllerWithStoryBoardName:@"spaceMain" viewControllerName:@"WOTInformationListVC"];
    
}
- (IBAction)showEnterpriseListVC:(id)sender {

    WOTEnterpriseLIstVC *enterprisevc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterpriseLIstVCID"];
    [self.navigationController pushViewController:enterprisevc animated:YES];
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

//MARK:SDCycleScrollView   Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
//    detailvc.url = _sliderUrlStrings[index];
    [self.navigationController pushViewController:detailvc animated:YES];
    
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
}

#pragma mark -  tableView datasource delegate


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
//    [WOTHTTPNetwork getHomeSliderSouceInfo:^(id bean, NSError *error) {
//        if (error) {
//            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
//        }
//        if (bean) {
//
//            WOTSliderModel_msg *dd = (WOTSliderModel_msg *)bean;
//            _imageTitles = [[NSMutableArray alloc]init];
//            _imageUrlStrings = [[NSMutableArray alloc]init];
//            _sliderUrlStrings = [[NSMutableArray alloc]init];
//            for (WOTSliderModel *slider in dd.msg) {
//                [_imageUrlStrings addObject:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,slider.image]];
//                [_imageTitles addObject:slider.headline];
//                if ([slider.url hasPrefix:@"http"] == NO) {
//                    [_sliderUrlStrings addObject:[NSString stringWithFormat:@"%@%@",@"http://",slider.url]];
//                }
//
//            }
//            complete();
//
//        }
//    }];
}
#pragma mark - 网络获取空间数据
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
            for (WOTSpaceModel *spaceModel in model.msg.list) {
                NSLog(@"地址：%@",spaceModel.spacePicture);
                NSArray *array = [spaceModel.spacePicture componentsSeparatedByString:@","];
                [_spaceImageUrlStrings addObject:[NSString stringWithFormat:@"%@/SKwork%@",HTTPBaseURL,array.firstObject]];
                [_spaceTitleArray addObject:spaceModel.spaceName];
                
                
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
