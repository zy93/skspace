//
//  WOTBookStationVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTBookStationVC.h"
#import "XXPageTabView.h"
#import "XXPageTabItemLable.h"
#import "WOTBookStationCell.h"
#import "WOTDatePickerView.h"
#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTOrderVC.h"
#import "WOTSpaceModel.h"
#import "WOTBookStationListModel.h"
#import "SKBookStationVC.h"
#import "SKRoomListVC.h"
#import "JXPopoverView.h"

@interface WOTBookStationVC ()<UITableViewDelegate,UITableViewDataSource, WOTBookStationCellDelegate>
{
    NSArray *allModelList; //所有的
    NSString *cityName;
    NSString *inquireTime;//查询日期;
}

@property (nonatomic, strong) XXPageTabView *pageTabView;
@property (weak, nonatomic) IBOutlet UITableView *tableIView;
@property (weak, nonatomic) IBOutlet UIImageView *notInformationImageView;
@property (weak, nonatomic) IBOutlet UILabel *notBookStationInformationLabel;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong)UIButton *cityButton;
@property (nonatomic, strong)UIBarButtonItem *barButton;
//@property (nonatomic, assign)CGFloat y;
//@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)NSMutableArray *cityList;
@property (nonatomic, strong)NSArray *tableList;
@property (nonatomic, strong)WOTSpaceModel *spaceModel;

@property(nonatomic,strong)MBProgressHUD *HUD;

//@property (nonatomic,strong) NSString *spaceNme;

@end

@implementation WOTBookStationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"订工位";
    self.notInformationImageView.hidden = YES;
    self.notBookStationInformationLabel.hidden = YES;
    //_spaceId = @(56);原来
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bookStationNotificationAction:) name:@"BookStationNotification" object:nil];
    self.cityList = [NSMutableArray new];
    inquireTime = [NSDate getNewTimeZero];
    cityName = @"全部";
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.customView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    [_HUD showAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //    [self configNaviBackItem];
    NSLog(@"%@",cityName);
    [self createRequestCity];
    [self createRequest];
    self.menuArray = [[NSMutableArray alloc] init];
    [self configNavi];
    
}

//-(void)configNavi{
//
//    ///需要更改的地方spaceName
//
//    //解决布局空白问题--dong
//    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
//    if (is7Version) {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
//    }
//    self.navigationController.navigationBar.translucent = NO; //有个万恶的黑色
//
//}
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
#pragma mark - request
-(void)createRequest
{
    NSString *cityNameStr;
    if ([cityName isEqualToString:@"全部"]) {
        cityNameStr = nil;
    }else
    {
        cityNameStr = cityName;
    }
    __weak typeof(self) weakSelf = self;
    if ([WOTSingtleton shared].skTimeType == SKTIMETYPE_LONGTIME) {
        [WOTHTTPNetwork getAllSpaceAndRoomWithCity:cityNameStr block:^(id bean, NSError *error) {
            [_HUD removeFromSuperview];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"error:%@",error);
                    return ;
                }
                WOTSpaceModel_msg *list = bean;
                weakSelf.tableList = list.msg.list;
                if (weakSelf.tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notBookStationInformationLabel.hidden = YES;
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notBookStationInformationLabel.hidden = NO;
                    self.notBookStationInformationLabel.text = @"亲，没有选择城市哦！";
                    NSLog(@"没有数据");
                }
                //[self.table reloadData];
                [weakSelf.tableIView  reloadData];
            });
        }];
    }else
    {
        [WOTHTTPNetwork getAllSpaceSortWithCity:cityNameStr block:^(id bean, NSError *error) {
            [_HUD removeFromSuperview];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"error:%@",error);
                    return ;
                }
                WOTSpaceModel_msg *list = bean;
                weakSelf.tableList = list.msg.list;
                if (weakSelf.tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notBookStationInformationLabel.hidden = YES;
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notBookStationInformationLabel.hidden = NO;
                    self.notBookStationInformationLabel.text = @"亲，没有选择城市哦！";
                    NSLog(@"没有数据");
                }
                //[self.table reloadData];
                [weakSelf.tableIView  reloadData];
            });
        }];
    }
    
    
        
    
    
}

#pragma mark - 选择城市
-(void)selectSpace:(UIButton *)sender
{
    
    if (self.cityList.count) {
        JXPopoverView *popoverView = [JXPopoverView popoverView];
        NSMutableArray *JXPopoverActionArray = [[NSMutableArray alloc] init];
        for (NSString *name in self.cityList) {
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:name handler:^(JXPopoverAction *action) {
                cityName = name;
                [self configNavi];
                //[self.cityButton setTitle:cityName forState:UIControlStateNormal];
                //NSLog(@"测试：%@",name);
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:name,@"name", nil];
                NSNotification *notification =[NSNotification notificationWithName:@"BookStationNotification" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }];
            [JXPopoverActionArray addObject:action1];
        }
        [popoverView showToView:sender withActions:JXPopoverActionArray];
    }
}



#pragma mark - 请求城市列表
-(void)createRequestCity
{
    //    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getSapaceFromGroupBlock:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        WOTSpaceModel_msg *list = bean;
        [self createRequestCityList:list.msg.list];
    }];
}


-(void)createRequestCityList:(NSArray *)array
{
    //NSMutableArray *cityList = [NSMutableArray new];
    if (self.cityList.count > 0) {
        [self.cityList removeAllObjects];
    }
    for (WOTSpaceModel *model in array) {
        //
        BOOL isHaveCity = NO;
        for (NSString *city in self.cityList) {
            if ([model.city isEqualToString:city]) {
                isHaveCity = YES;
                break;
            }
        }
        if (!isHaveCity) {
            [self.cityList addObject:model.city];
        }
        //[self.cityList addObject:((NSDictionary *)model)[@"city"]];
    }
    [self.cityList insertObject:@"全部" atIndex:0];
    
}

#pragma mark - cell delegate
-(void)gotoOrderVC:(WOTBookStationCell *)cell
{
    WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
    [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
    vc.spaceModel = cell.model;
    vc.spaceSourceType = SPACE_SOURCE_TYPE_OTHER;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table datasource & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.tableList.count;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  200;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTBookStationCell *bookcell = [tableView dequeueReusableCellWithIdentifier:@"WOTBookStationCell" forIndexPath:indexPath];
    if (self.tableList) {
        WOTSpaceModel *model = self.tableList[indexPath.row];
        self.spaceModel = model;
        bookcell.model = model;
        //NSLog(@"测试：%@",model);
        //待开发
        bookcell.spaceName.text =model.spaceName;// @"方圆大厦-众创空间";
        NSArray  *array = [model.spacePicture componentsSeparatedByString:@","];
        NSString *imageUrl = [array firstObject];
        [bookcell.spaceImage sd_setImageWithURL:[imageUrl ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
        bookcell.stationNum.text  = [NSString stringWithFormat:@"%@",model.spaceSite]; //@"23个工位可以预定";
        if ([WOTSingtleton shared].skTimeType == SKTIMETYPE_LONGTIME) {
            bookcell.stationNumer.text = [NSString stringWithFormat:@"剩余房间:%@",model.stationSubareaNum];
        }else
        {
            bookcell.stationNumer.text = [NSString stringWithFormat:@"剩余工位:%@",model.sourcecode];
        }
        //bookcell.stationNumer.text = [NSString stringWithFormat:@"剩余房间:%@",model.sourcecode];
//        bookcell.stationPrice.hidden = YES;
//        bookcell.stationPrice.text = [NSString stringWithFormat:@"￥%@/天",model.onlineLocationPrice];//@"¥123元／天";
        bookcell.delegate = self;
        bookcell.model = model;
    } else {
        // NSLog(@"测试：没有数据！");
    }
    
    return bookcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     WOTSpaceModel *model = self.tableList[indexPath.row];
    if ([WOTSingtleton shared].skTimeType == SKTIMETYPE_LONGTIME) {
        NSLog(@"长租");
        SKRoomListVC *roomListVC = [[SKRoomListVC alloc] init];
        roomListVC.spaceModel = model;
        [self.navigationController pushViewController:roomListVC animated:YES];
    }else
    {
        WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
       
        [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
        vc.spaceModel = model;
        vc.spaceSourceType = SPACE_SOURCE_TYPE_OTHER;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)bookStationNotificationAction:(NSNotification *)notification{
    cityName = [notification.userInfo objectForKey:@"name"];
    [self createRequest];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"BookStationNotification"];
}

@end

