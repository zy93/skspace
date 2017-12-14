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
#import "WOTworkSpaceLIstVC.h"
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
@interface WOTMainVC ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,SDCycleScrollViewDelegate,WOTShortcutMenuViewDelegate,CardViewDelegate,CardViewDataSource>
@property(nonatomic,strong)ZYQSphereView *sphereView;
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;
@property(nonatomic,strong)WOTworkSpaceLIstVC *spacevc;

//空间
@property (weak, nonatomic) IBOutlet CardView *spaceView;

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
@property (nonatomic,strong) NSMutableArray *imageTitles;
@property (nonatomic,strong) NSMutableArray *sliderUrlStrings;
@property (strong,nonatomic)NSMutableArray<WOTSpaceModel *> *spacedataSource;
@property (strong,nonatomic)NSArray<WOTActivityModel *> *activitydataSource;
@property(nonatomic,strong)NSMutableArray<NSArray<WOTNewInformationModel *> *> *infodataSource;
@property(nonatomic,strong)NSString *activityImageUrl;
@property(nonatomic,copy)NSString *cityName;
//@property(nonatomic,strong)WOTRefreshControlUitls *refreshControl;
@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self load3DBallView];
    
    [self loadAutoScrollView];
    [self configScrollView];
   
    self.ballView.delegate = self;
//    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
//    if (is7Version) {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
//    }
    
    self.spaceView.delegate   = self;
    self.spaceView.dataSource = self;
    self.spaceView.maxItems   = 3;
    self.spaceView.scaleRatio = 0.05;
    [self.spaceView registerXibFile:@"WOTCardViewItem" forItemReuseIdentifier:@"WOTCardViewItem"];

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
int a = 0;

-(void)viewDidAppear:(BOOL)animated{
    //必须在页面出现以后，重新设置scrollview 的contengsize
    if (a++<=0) {
        [self loadLocation];
    }
    [super viewDidAppear:animated];
    NSLog(@"高度：%f",self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+self.enterpriseView.frame.size.height+70);
    self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+self.enterpriseView.frame.size.height+70);
    //废弃
    //    _refreshControl = [[WOTRefreshControlUitls alloc]initWithScroll:self.scrollVIew];//在viewdidload 中添加，由于scrollview的contentSize不正确，不能下啦
    //    [_refreshControl addTarget:self action:@selector(downLoadRefresh) forControlEvents:UIControlEventAllEvents];
    
}

#pragma mark - setup view

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
    
    
    [self getEnterpriseListDataFromWeb:^{
        [self StopRefresh];
    }];
    
    [self getActivityDataFromWeb:^{
    }];
    
    [self getInfoDataFromWeb:^{
    }];
    [self getSliderDataSource:^{
        [self loadAutoScrollView];
    }];
    [self getDataSourceFromWebFWithCity:nil complete:^{
    } loadVIews:^{
//        [self setupUI];
        [self.spaceView reloadData];
    }];
    
}

-(void)configScrollView{
    self.scrollVIew.delegate = self;
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    self.scrollVIew.showsVerticalScrollIndicator = NO;
    self.scrollVIew.backgroundColor = MainColor;
}

#pragma mark --懒加载
- (NSMutableArray *)spacePageViewDataSource {
    if (_spacePageViewDataSource == nil) {
        _spacePageViewDataSource = [NSMutableArray array];
    }
    return _spacePageViewDataSource;
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

-(NSString *)activityImageUrl{
    if (_activityImageUrl == nil) {
        _activityImageUrl = @"";
    }
    return  _activityImageUrl;
}
-(NSMutableArray<NSArray<WOTNewInformationModel *> *> *)infodataSource{
    if (_infodataSource == nil) {
        _infodataSource = [[NSMutableArray alloc]init];
    }
    return _infodataSource;
}

-(void)loadShortcutMenuView
{
    
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
    if ([stationvc isKindOfClass:[WOTActivitiesLIstVC class]]) {
        [((WOTActivitiesLIstVC *)stationvc) getActivityDataFromWeb:^{
        }];
    }
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


//MARK: main scrollview delegate
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

#pragma mark - NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 60, (SCREEN_WIDTH - 60) * 9 / 16);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    //detailvc.url = [NSString stringWithFormat:@"%@%@",@"http://",_spacePageViewDataSource[subIndex].spared3];
    [self.navigationController pushViewController:detailvc animated:YES];
}

#pragma mark  NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.spacePageViewDataSource.count;
    
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
    //NSLog(@"网络图片地址：%@",[_spacedataSource[index] objectForKey:@"spacePicture"]);
    NSLog(@"----%@",_spacedataSource[index].spacePicture);
    
      [bannerView.mainImageView sd_setImageWithURL:[[NSString stringWithFormat:@"%@%@",HTTPBaseURL,_spacedataSource[index].spacePicture] ToUrl]placeholderImage:[UIImage imageNamed:@"spacedefault"]];
    
    if ([_spacedataSource[index].spacePicture separatedWithString:@","].count!=0) {
        [bannerView.mainImageView sd_setImageWithURL:[[_spacedataSource[index].spacePicture separatedWithString:@","][0] ToUrl] placeholderImage:[UIImage imageNamed:@"spacedefault"]];
        
        NSLog(@"图片地址：%@",[NSString stringWithFormat:@"%@%@",HTTPBaseURL,[_spacedataSource[index].spacePicture separatedWithString:@","][0]]);
    }
    
    //从本地加载图片用
//    bannerView.mainImageView.image = self.imageArray[index];
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}


#pragma mark - shortcut delegate
-(void)pushToVCWithStoryBoardName:(NSString *)sbName vcName:(NSString *)vcName
{
    if (strIsEmpty(sbName)) {
        [self showNewInfoVC];
        return;
    }
    if ([vcName isEqualToString:@"WOTOpenLockScanVCID"]) {
        [MBProgressHUDUtil showMessage:@"敬请期待" toView:self.view];
        return;
    }
    
    [self pushToViewControllerWithStoryBoardName:sbName viewControllerName:vcName];
}

//MARK:点击显示新页面
- (IBAction)showWorkSpaceVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    _spacevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTworkSpaceLIstVCID"];
    [_spacevc setDataSource:_spacedataSource];
    [self.navigationController pushViewController:_spacevc animated:YES];
}


- (IBAction)showActivitiesVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
  WOTActivitiesLIstVC  *acvc = [storyboard instantiateViewControllerWithIdentifier:@"WOTActivitiesLIstVCID"];
    [acvc setDataSource:_activitydataSource];
    [self.navigationController pushViewController:acvc animated:YES];
    
    
}
- (IBAction)showInformationLIstVC:(id)sender {
    
    [self showNewInfoVC];
    
}
- (IBAction)showEnterpriseListVC:(id)sender {

    WOTEnterpriseLIstVC *enterprisevc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterpriseLIstVCID"];
    [self.navigationController pushViewController:enterprisevc animated:YES];
}
//activity section imageClick
- (IBAction)showActivityDetail:(id)sender {
    
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    //detailvc.url = [NSString stringWithFormat:@"%@%@",@"http://",_activitydataSource[0].spared3];
    [self.navigationController pushViewController:detailvc animated:YES];
    
    
}
//new information section imageClick 
- (IBAction)showInfoDetail:(id)sender {
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    
    if (_infodataSource[0].count  >0) {
        detailvc.url = [NSString stringWithFormat:@"%@%@",@"http://",_infodataSource[0][0].spared3];
    }
    
    
    [self.navigationController pushViewController:detailvc animated:YES];
    
    
}

#pragma mark - Card Delegate & DataSource
-(NSInteger)numberOfItemsInCardView:(CardView *)cardView
{
    return self.spacePageViewDataSource.count;
}

-(CardViewItem *)cardView:(CardView *)cardView itemAtIndex:(NSInteger)index
{
    WOTCardViewItem *item = (WOTCardViewItem *)[cardView dequeueReusableCellWithIdentifier:@"WOTCardViewItem"];
    WOTSpaceModel *model = self.spacePageViewDataSource[index];
    
//    NSArray *urlArr= [model.spacePicture componentsSeparatedByString:@","];
//    [item.bgIV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,urlArr.firstObject]]];
    [item.bgIV setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512661579794&di=963501da40aa0f561266d5c0307f95ee&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fd01373f082025aafa9b293e2f0edab64034f1a12.jpg"]];
    [item.title setText:model.spaceName];
    return item;
}

-(CGRect)cardView:(CardView *)cardView rectForItemAtIndex:(NSInteger)index
{
    return CGRectMake(0, 0, SCREEN_WIDTH-40, self.spaceView.height - 35);
}

-(void)cardView:(CardView *)cardView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"卡片%ld被选中", (long)index);
}

//MARK:SDCycleScrollView   Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = _sliderUrlStrings[index];
    [self.navigationController pushViewController:detailvc animated:YES];
    
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
}

#pragma mark -  tableView datasource delegate
-(void)showNewInfoVC{
    WOTInformationListVC *infovc = [[WOTInformationListVC alloc]init];
    infovc.dataSource = _infodataSource;
    [self.navigationController pushViewController:infovc animated:YES];
}

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
-(void)getSliderDataSource:(void(^)())complete{
    [WOTHTTPNetwork getHomeSliderSouceInfo:^(id bean, NSError *error) {
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
            _imageUrlStrings = [[NSMutableArray alloc]initWithArray:@[
                                                                     @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                                                     @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                                                     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                                                     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                                                     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                                                     ]];
            
            // 图片配文字
            _imageTitles = [[NSMutableArray alloc]initWithArray:            @[@"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技"
                                                                              ]];
            
            
            
        }
        if (bean) {
         
            WOTSliderModel_msg *dd = (WOTSliderModel_msg *)bean;
            _imageTitles = [[NSMutableArray alloc]init];
            _imageUrlStrings = [[NSMutableArray alloc]init];
            _sliderUrlStrings = [[NSMutableArray alloc]init];
            for (WOTSliderModel *slider in dd.msg) {
                [_imageUrlStrings addObject:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,slider.image]];
                [_imageTitles addObject:slider.headline];
                if ([slider.url hasPrefix:@"http"] == NO) {
                    [_sliderUrlStrings addObject:[NSString stringWithFormat:@"%@%@",@"http://",slider.url]];
                }
                
            }
            complete();
            
        }
    }];
}

//从网络获取空间数据
-(void)getDataSourceFromWebFWithCity:( NSString * __nullable )city complete:(void(^)())complete loadVIews:(void(^)())loadViews{
    [self.spacePageViewDataSource removeAllObjects];
    
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getSapaceFromGroupBlock:^(id bean, NSError *error) {
        complete();
        if (bean != nil) {
            WOTSpaceModel_msg *dd = (WOTSpaceModel_msg *)bean;
            NSLog(@"测试：%@",dd.msg.list);
            weakSelf.spacedataSource = [dd.msg.list mutableCopy];
            
            if (_spacedataSource.count>5) {
                for (int index = 0; index < 5; index++) {
                    [weakSelf.spacePageViewDataSource addObject:_spacedataSource[index]];
                }
            } else {
                for (int index = 0; index < _spacedataSource.count; index++) {
                    [weakSelf.spacePageViewDataSource addObject:_spacedataSource[index]];
                }
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
    [WOTHTTPNetwork getActivitiesResponse:^(id bean, NSError *error)  {
        complete();
        if (bean) {
            WOTActivityModel_msg *dd = (WOTActivityModel_msg *)bean;
            _activitydataSource = dd.msg.list;
            if (_activitydataSource.count>0) {
                if ([_activitydataSource[0].pictureSite separatedWithString:@","].count !=0 ) {
                    _activityImageUrl = [_activitydataSource[0].pictureSite separatedWithString:@","][0];
                    
                    [weakSelf.activityIV sd_setImageWithURL:[_activityImageUrl ToUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                    
                }
            }

        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
}



-(void)getInfoDataFromWeb:(void(^)())complete{
    
//    [WOTHTTPNetwork getAllNewInformation:^(id bean, NSError *error) {
//        complete();
//        if (bean) {
//            WOTNewInformationModel_msg *dd = (WOTNewInformationModel_msg *)bean;
//            _infodataSource = [[NSMutableArray alloc]init];
//            [_infodataSource addObject:dd.msg.space];
//            [_infodataSource addObject:dd.msg.firm];
//
//            if (_infodataSource[0].count  >0) {
//                WOTNewInformationModel *model = _infodataSource[0][0];
//
//
//                [_infoImage sd_setImageWithURL: [[model.pictureSite separatedWithString:@","][0] ToUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//                _InfoMessage.text = model.messageInfo;
//                _InfoTime.text = model.issueTime;
//            } else {
//                _infoImage.image = [UIImage imageNamed:@"placeholder"];
//                _InfoMessage.text = @"";
//                _InfoTime.text = @"";
//            }
//
//        }
//        if (error) {
//            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
//        }
//
//    }];
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
