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
#import "WOTLoginNaviController.h"
#import "WOTOpenLockScanVC.h"
#import "WOTSliderModel.h"
#import "WOTH5VC.h"
#import "MJRefresh.h"


#define getService @"WOTGETServiceCell"
#define serviceScroll @"serviceScroll"

#import "WOTRefreshControlUitls.h"
@interface WOTServiceVC () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate, WOTGETServiceCellDelegate>
{
    NSMutableArray *tableList;
    NSMutableArray *tableIconList;

}
//@property(nonatomic,strong)WOTRefreshControlUitls *refreshControl;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *autoScrollView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@property (nonatomic,strong) NSMutableArray *imageUrlStrings;
@property (nonatomic,strong) NSMutableArray *imageTitles;
@property (nonatomic,strong) NSMutableArray *sliderUrlStrings;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewHeight;


@end

@implementation WOTServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self loadAutoScrollView];
    [self addData];
    [self AddRefreshHeader];
    [self StartRefresh];
 
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
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
  
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)configNav{
    self.navigationItem.title = @"服务";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UITableView *pTableView = _table;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    if (_table.mj_footer != nil && [_table.mj_footer isRefreshing])
    {
        [_table.mj_footer endRefreshing];
    }
    [self loadData];
}

- (void)StopRefresh
{
    if (_table.mj_header != nil && [_table.mj_header isRefreshing])
    {
        [_table.mj_header endRefreshing];
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
    [self getSliderDataSource:^{
        [self loadAutoScrollView];
        [self StopRefresh];
    }];
}

#pragma mark - setup View
-(void)loadAutoScrollView{
 
    
    self.autoScrollView.imageURLStringsGroup = _imageUrlStrings;
//    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.autoScrollView.delegate = self;
    //self.autoScrollView.titlesGroup = _imageTitles;
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

#pragma mark  - action
-(void)pushVCByVCName:(NSString *)vcName
{
    WOTRegisterServiceProvidersVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SDCycleScroll delgate
/** 点击图片回调 */
//MARK:SDCycleScrollView   Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = _sliderUrlStrings[index];
    [self.navigationController pushViewController:detailvc animated:YES];
    
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
}

#pragma mark - cell delegate
-(void)optionService:(NSString *)serviceName
{
    [self pushVCByVCName:@"WOTGETServiceViewController"];
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
        [cell setData:5]; 
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)getSliderDataSource:(void(^)())complete{
    
    [WOTHTTPNetwork getServeSliderSouceInfo:^(id bean, NSError *error) {
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
            _imageUrlStrings = [[NSMutableArray alloc]initWithArray:@[
                                                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                                                      ]];
            
            // 图片配文字
            _imageTitles = [[NSMutableArray alloc]initWithArray:            @[@"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技"
                                                                              ]];
            
            
            
        }
        if (bean) {
            
            WOTSliderModel_msg *dd = (WOTSliderModel_msg *)bean;
            NSLog(@"ok%@",dd);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
