//
//  WOTActivitiesLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTActivitiesLIstVC.h"
#import "WOTFilterTypeModel.h"
#import "WOTActivitiesListCell.h"
#import "WOTH5VC.h"

@interface WOTActivitiesLIstVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
    
}
@property (weak, nonatomic) IBOutlet UIView *communityView;
@property (weak, nonatomic) IBOutlet UILabel *communityName;
@property (weak, nonatomic) IBOutlet UIImageView *community_arrowdown;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *category_arrowdown;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;


@end

@implementation WOTActivitiesLIstVC
bool ismenu1 =  NO;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.tableVIew.backgroundColor = CLEARCOLOR;
    [self configNav];

    
    [self makeMenuArrays];
    [self.tableVIew registerNib:[UINib nibWithNibName:@"WOTworkSpaceCommonCell" bundle:nil] forCellReuseIdentifier:@"WOTworkSpaceCommonCellID"];
    self.communityName.text = ((WOTFilterTypeModel *)self.menu1Array[0]).filterName;
    self.categoryLabel.text = ((WOTFilterTypeModel *)self.menu2Array[0]).filterName;
    page = 1;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self crectRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的活动";
}


#pragma mark - request
-(void)crectRequest
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getActivitiesWithPage:@(page) response:^(id bean, NSError *error) {
        if (bean) {
            WOTActivityModel_msg *modle = (WOTActivityModel_msg *)bean;
            weakSelf.dataSource = modle.msg.list;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableVIew reloadData];
            });
        }
        else {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
    }];
}

#pragma mark - action
- (IBAction)communityBtnAction:(id)sender {
    ismenu1 = YES;
    [self.menuView1 menuTappedWithSuperView:self.view];
    [self.menuView1 reloadData];
}
- (IBAction)categoryBtnAction:(id)sender {
    ismenu1 = NO;
    
    [self.menuView2 menuTappedWithSuperView:self.view];
    [self.menuView2 reloadData];
}

-(NSMutableArray<WOTFilterTypeModel *> *)menu_filterDataArray {
    
    if (ismenu1) {
        return self.menu1Array;
    }else {
        return self.menu2Array;
    }
    
}


-(void)menu:(DropMenuView *)menu tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(NSArray<__kindof UIImageView *> *)createmenuViewImageViews{
    return [[NSArray alloc]initWithObjects:self.community_arrowdown,self.category_arrowdown, nil];
}

-(NSArray<__kindof UIView *> *)createmenuViewBaseViews{
    return [[NSArray alloc]initWithObjects:self.communityView,self.categoryView, nil];
}


-(NSArray<__kindof UILabel *> *)createmenuViewLabels{
    return [[NSArray alloc]initWithObjects:self.communityName,self.categoryLabel, nil];
}


-(NSArray <WOTActivityModel *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSArray alloc]init];
    }
    return  _dataSource;
}

-(void)makeMenuArrays{
    self.menu1Array = [NSMutableArray array];
    WOTFilterTypeModel *model11 = [[WOTFilterTypeModel alloc]initWithName:@"全部" andId:@"one"];
    WOTFilterTypeModel *model22 = [[WOTFilterTypeModel alloc]initWithName:@"方圆大厦-众创空间" andId:@"two"];
    WOTFilterTypeModel *model33 = [[WOTFilterTypeModel alloc]initWithName:@"腾达大厦-众创空间" andId:@"two"];
    WOTFilterTypeModel *model44 = [[WOTFilterTypeModel alloc]initWithName:@"海淀1区-众创空间" andId:@"two"];
    [self.menu1Array addObject:model11];
    [self.menu1Array addObject:model22];
    [self.menu1Array addObject:model33];
    [self.menu1Array addObject:model44];
    
    
    
    self.menu2Array = [NSMutableArray array];
    WOTFilterTypeModel *model = [[WOTFilterTypeModel alloc]initWithName:@"全部" andId:@"one"];
    WOTFilterTypeModel *model2 = [[WOTFilterTypeModel alloc]initWithName:@"论坛" andId:@"two"];
    WOTFilterTypeModel *model3 = [[WOTFilterTypeModel alloc]initWithName:@"公开课" andId:@"three"];
    WOTFilterTypeModel *model4 = [[WOTFilterTypeModel alloc]initWithName:@"沙龙" andId:@"four"];
    WOTFilterTypeModel *model5 = [[WOTFilterTypeModel alloc]initWithName:@"直播" andId:@"five"];
    WOTFilterTypeModel *model6 = [[WOTFilterTypeModel alloc]initWithName:@"直播" andId:@"five"];
    [self.menu2Array addObject:model];
    [self.menu2Array addObject:model2];
    [self.menu2Array addObject:model3];
    [self.menu2Array addObject:model4];
    [self.menu2Array addObject:model5];
    [self.menu2Array addObject:model6];

    
}

#pragma mark - table data & source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       
    return  250;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTActivitiesListCell *activitycell = [tableView dequeueReusableCellWithIdentifier:@"WOTActivitiesListCellID" forIndexPath:indexPath];
    
    activitycell.activityTitle.text = _dataSource[indexPath.row].title;
    activitycell.activityLocation.text = _dataSource[indexPath.row].spaceName;
    activitycell.activityState.text = [_dataSource[indexPath.row].starTime getDate];
    [activitycell.activityImage sd_setImageWithURL:[_dataSource[indexPath.row].pictureSite ToResourcesUrl]  placeholderImage:[UIImage imageNamed:@"placeholder_activity"]];
    
    return activitycell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTH5VC *h5vc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    h5vc.url = [_dataSource[indexPath.row].htmlLocation stringToResourcesUrl];
    [self.navigationController pushViewController:h5vc animated:YES];
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
