//
//  WOTNearCirclesVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTNearCirclesVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WOTSocialContactCell.h"
#import "MJRefresh.h"
#import "WOTFriendsMessageListModel.h"

typedef NS_ENUM(NSInteger, FDSimulatedCacheMode) {
    FDSimulatedCacheModeNone = 0,
    FDSimulatedCacheModeCacheByIndexPath,
    FDSimulatedCacheModeCacheByKey
};

@interface WOTNearCirclesVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation WOTNearCirclesVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    dataSource = @[@"明确指出：到2020年，人工智能总体技术和应用与世界先进水平同步；到2025年，人工智能基础理论实现重大突破，部分技术与应用达到世界领先水平；到2030年，人工智能理论、技术与应用总体达到世界领先水平，成为世界主要人工智能创新中心",@"明确指出：到2020年，人工智能总体技术和应用与世界先进水平同步；到2025年，人工智能基础理论实现重大突破，部分技术与应用达到世界领先水平；到2030年，人工智能理论、技术与应用总体达到世界领先水平，成为世界主要人工智能创新中心",@"技术与应用总体达到世界领先水平，成为世界主要人工智能创新中心",@"明确指出：到2020年，人工智能总体技术和应用与世界先进水平同步；到2025年，人工智能基础理论实现重大突破，部分技术与应用达到世界领先水平；到2030年，人工智能理论、技术与应用总体达到世界领先水平，成为世界主要人工智能创新中心",@"明确指出：到2020年，人工智能总体技术和应用与世界先进水平同步；"];
//    photoArray = [[NSMutableArray alloc]initWithObjects:   [UIImage imageNamed:@"Yosemite00"],
//                     [UIImage imageNamed:@"Yosemite01"],[UIImage imageNamed:@"Yosemite02"],[UIImage imageNamed:@"Yosemite03"],[UIImage imageNamed:@"Yosemite04"],nil];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTSocialContactCell" bundle:nil] forCellReuseIdentifier:@"WOTSocialContactCellID"];
    [self AddRefreshHeader];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void)createRequest
{
    
    if ([WOTUserSingleton shareUser].userInfo.spaceId) {
        [WOTHTTPNetwork getMessageBySapceIdWithSpaceId:[WOTUserSingleton shareUser].userInfo.spaceId response:^(id bean, NSError *error) {
            [self StopRefresh];
            WOTFriendsMessageListModel_msg *model = (WOTFriendsMessageListModel_msg*)bean;
            dataSource = model.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
    else {
        
    }
}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UITableView *pTableView = _tableView;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)StartRefresh
{
    if (_tableView.mj_footer != nil && [_tableView.mj_footer isRefreshing])
    {
        [_tableView.mj_footer endRefreshing];
    }
    [self createRequest];
}

- (void)StopRefresh
{
    if (_tableView.mj_header != nil && [_tableView.mj_header isRefreshing])
    {
        [_tableView.mj_header endRefreshing];
    }
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WOTSocialContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSocialContactCellID"];
    cell.fd_enforceFrameLayout = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        cell.lineView.hidden= YES;
    } else {
        cell.lineView.hidden = NO;
    }
    
    [cell setData:dataSource[indexPath.row]];
    
//    cell.photosArray = photoArray;
//    cell.content.text = dataSource[indexPath.row];
//    cell.contactName.textColor = MainOrangeColor;
//    cell.headerImage.image = [UIImage imageNamed:@"Yosemite01"];
//    cell.contactName.text = @"风清扬";
//    cell.time.text = @"30分钟前";
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WOTFriendsMessageModel *model = dataSource[indexPath.row];
    
    NSArray *arr = [model.sharePicture componentsSeparatedByString:@","];
    
   return  [tableView fd_heightForCellWithIdentifier:@"WOTSocialContactCellID" configuration:^(WOTSocialContactCell *cell) {
        cell.fd_enforceFrameLayout = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
       WOTFriendsMessageModel *model =dataSource[indexPath.row];
       cell.content.text =model.textWord;
    }]+(SCREEN_WIDTH-20)/3.5 * ceil(arr.count*0.3) + 30;
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
