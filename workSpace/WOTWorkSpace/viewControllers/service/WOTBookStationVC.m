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
#import "JXPopoverView.h"

@interface WOTBookStationVC ()<UITableViewDelegate,UITableViewDataSource, WOTBookStationCellDelegate>
{
    NSArray *allModelList; //所有的
    NSArray *tableList;
    NSString *cityName;
    NSString *inquireTime;//查询日期;
}

@property (nonatomic, strong) XXPageTabView *pageTabView;
@property (weak, nonatomic) IBOutlet UIView *tomorrowView;
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UIView *selectDateView;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorVIewCenter;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableIView;
@property(nonatomic,strong)WOTDatePickerView *datepickerview;
@property (weak, nonatomic) IBOutlet UIImageView *notInformationImageView;
@property (weak, nonatomic) IBOutlet UILabel *notBookStationInformationLabel;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong)UIBarButtonItem *barButton;
//@property (nonatomic, assign)CGFloat y;
//@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)NSMutableArray *cityList;
@property (nonatomic, strong)UIButton *cityButton;
@property (nonatomic, strong)WOTSpaceModel *spaceModel;


//@property (nonatomic,strong) NSString *spaceNme;

@end

@implementation WOTBookStationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

    self.navigationItem.title = @"订工位";
    
    //_spaceId = @(56);原来
    self.cityList = [NSMutableArray new];
    inquireTime = [NSDate getNewTimeZero];
    cityName = [WOTSingtleton shared].cityName;
    //cityName = ((WOTFilterTypeModel *)self.menuArray[0]).filterName;
//    WOTLocationModel *model = [WOTSingtleton shared].nearbySpace;
//    NSLog(@"最近空间%@",model.spaceName);
//    _spaceId = model.spaceId;
    if ((!cityName) || [cityName isEqualToString:@""]) {
        cityName = @"未定位";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
//    [self configNaviBackItem];
    NSLog(@"%@",cityName);
    [self createRequestCity];
    [self createRequest];
    self.menuArray = [[NSMutableArray alloc] init];
    [self configNavi];
}

-(void)configNavi{
    
    ///需要更改的地方spaceName
    
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

    //解决布局空白问题--dong
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO; //有个万恶的黑色

}

-(void)setupView
{
    self.viewWidth.constant = self.view.frame.size.width/3;
    self.view.backgroundColor = MainColor;
    self.tableIView.backgroundColor = CLEARCOLOR;
    [self setTextColor:UIColorFromRGB(0x5484e7) tomorrowcolor:[UIColor blackColor] timecolor:[UIColor blackColor]];
    
    __weak typeof(self) weakSelf = self;

    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSLog(@"%ld年%ld月%ld日",year,month,day);
        inquireTime = [NSString stringWithFormat:@"%02d/%02d/%02d %02d:%02d",(int)year, (int)month, (int)day,(int)hour,(int)min];
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}

#pragma mark - request
-(void)createRequest
{
   
    if ([cityName isEqualToString:@""]) {
        self.notInformationImageView.hidden = NO;
        self.notBookStationInformationLabel.hidden = NO;
        self.notBookStationInformationLabel.text = @"亲，暂时没有会议室哦！";
        [self.tableIView  reloadData];
        //return;
    }else
    {
        [WOTHTTPNetwork getAllSpaceWithCity:cityName block:^(id bean, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
                return ;
            }
            WOTSpaceModel_msg *list = bean;
            //        tableList = list.msg;
            //tableDic = [self sortByCity:list.msg];
            tableList = list.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notBookStationInformationLabel.hidden = YES;
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notBookStationInformationLabel.hidden = NO;
                    self.notBookStationInformationLabel.text = @"亲，暂时没有会议室哦！";
                    NSLog(@"没有数据");
                }
                //[self.table reloadData];
                [self.tableIView  reloadData];
            });
        }];
    
    }
    
    
}


#pragma mark - action

- (IBAction)selectedToday:(id)sender {
    self.indicatorVIewCenter.constant = self.todayView.frame.origin.x;
    [self setTextColor:UIColorFromRGB(0x5484e7) tomorrowcolor:[UIColor blackColor] timecolor:[UIColor blackColor]];
    inquireTime = [NSDate getNewTimeZero];
    _datepickerview.hidden = YES;
}

- (IBAction)selectedTomorrow:(id)sender {
    self.indicatorVIewCenter.constant = self.tomorrowView.frame.origin.x;
     [self setTextColor:[UIColor blackColor] tomorrowcolor:UIColorFromRGB(0x5484e7) timecolor:[UIColor blackColor]];
    inquireTime = [NSDate getTomorrowTimeZero];
    _datepickerview.hidden = YES;
}

- (IBAction)selectedTime:(id)sender {
    self.indicatorVIewCenter.constant = self.selectDateView.frame.origin.x;
    [self setTextColor:[UIColor blackColor] tomorrowcolor:[UIColor blackColor] timecolor:UIColorFromRGB(0x5484e7)];
    _datepickerview.hidden = NO;
}

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
                [self createRequest];
                //NSLog(@"测试：%@",name);
                
            }];
            [JXPopoverActionArray addObject:action1];
        }
        [popoverView showToView:sender withActions:JXPopoverActionArray];
    }
}
-(void)createRequestCity
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getSapaceFromGroupBlock:^(id bean, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error);
            return ;
        }
        WOTSpaceModel_msg *list = bean;
        //        tableList = list.msg;
      [self createRequestCityList:list.msg];
    }];
}

-(void)createRequestCityList:(NSArray *)array
{
    //NSMutableArray *cityList = [NSMutableArray new];
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
        //[self.cityList addObject:model.city];
    }
    
}

#pragma mark -

-(void)setTextColor:(UIColor *)todaycolor tomorrowcolor:(UIColor *)tomorrowcolor timecolor:(UIColor *)timecolor{
    self.todayLabel.textColor = todaycolor;
    self.tomorrowLabel.textColor = tomorrowcolor;
    self.selectedTimeLabel.textColor = timecolor;
}

#pragma mark - cell delegate
-(void)gotoOrderVC:(WOTBookStationCell *)cell
{
    WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
    vc.startTime = inquireTime;//arr.firstObject;
    vc.endTime = inquireTime;//arr.lastObject;
    vc.spaceId = self.spaceId;
//    vc.conferenceId = cell.model.conferenceId;
    [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
    vc.spaceModel = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table datasource & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  tableList.count;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    return  225;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTBookStationCell *bookcell = [tableView dequeueReusableCellWithIdentifier:@"WOTBookStationCellID" forIndexPath:indexPath];
    if (tableList) {
        WOTSpaceModel *model = tableList[indexPath.row];
        self.spaceModel = model;
        bookcell.model = model;
        //NSLog(@"测试：%@",model);
        //待开发
        bookcell.spaceName.text =model.spaceName;// @"方圆大厦-众创空间";
        [bookcell.spaceImage sd_setImageWithURL:[model.spacePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
        bookcell.stationNum.text  = [NSString stringWithFormat:@"%ld工位可以预定",model.alreadyTakenNum.integerValue]; //@"23个工位可以预定";
        bookcell.stationPrice.text = [NSString stringWithFormat:@"￥%ld/天",model.stationPrice.integerValue];//@"¥123元／天";
        bookcell.delegate = self;
        bookcell.model = model;
    } else {
       // NSLog(@"测试：没有数据！");
        
    }
   
    return bookcell;
}





//- (UIViewController *)makeVC {
//    UIViewController *basevc = [[UIViewController alloc]init];
//    
//    
//    return basevc;
//}
//
//-(void)setpageMenu{
//    
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    UIViewController *vc2 = [[UIViewController alloc]init];
//   
//    NSArray<__kindof UIViewController *> *controllers = @[vc1,vc2,vc2];
//    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:controllers childTitles:@[@"今日",@"明日",@"选择日期"]];
//    self.pageTabView.cutOffLine = NO;
//    [self.pageTabView layoutSubviews];
//    self.pageTabView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
//    self.pageTabView.delegate = self;
//    self.pageTabView.tabSize = CGSizeMake(self.view.frame.size.width, 40);
//    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
//    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
//    self.pageTabView.maxNumberOfPageItems = 5;
//    self.pageTabView.indicatorWidth = 20;
// 
//    [self.view addSubview:self.pageTabView];
//}
//
//#pragma mark - XXPageTabViewDelegate
//- (void)pageTabViewDidEndChange {
//    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
//    if (self.pageTabView.selectedTabIndex == 2) {
//        NSLog(@"显示选择时间");
//    }
//}
//
//#pragma mark - Event response
//- (void)scrollToLast:(id)sender {
//    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
//}
//
//- (void)scrollToNext:(id)sender {
//    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
//}
//
//- (void)refreshPageTabView:(id)sender {
//    //移除原有子控制器
//    for(UIViewController *vc in self.childViewControllers) {
//        [vc removeFromParentViewController];
//    }
//    
//    UIViewController *test1 = [self makeVC];
//    UIViewController *test2 = [self makeVC];
//    UIViewController *test3 = [self makeVC];
//    UIViewController *test4 = [self makeVC];
//    UIViewController *test5 = [self makeVC];
//    
//    [self addChildViewController:test1];
//    [self addChildViewController:test2];
//    [self addChildViewController:test3];
//    [self addChildViewController:test4];
//    [self addChildViewController:test5];
//    
//    [self.pageTabView reloadChildControllers:self.childViewControllers childTitles:@[@"全部", @"待支付", @"待使用", @"已完成", @"已取消"]];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
