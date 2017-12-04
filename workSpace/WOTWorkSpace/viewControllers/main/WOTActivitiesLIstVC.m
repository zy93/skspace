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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

-(void)configNav{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的活动";
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _dataSource.count;
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
    activitycell.activityState.text = @"活动进行中";
    NSString *pictureurl = [_dataSource[indexPath.row].pictureSite separatedWithString:@","].count==0? @"":[_dataSource[indexPath.row].pictureSite separatedWithString:@","][0];
    [activitycell.activityImage sd_setImageWithURL:[pictureurl ToUrl]  placeholderImage:[UIImage imageNamed:@"spacedefault"]];
    
    return activitycell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    //detailvc.url = [NSString stringWithFormat:@"%@%@",@"http://",_dataSource[indexPath.row].spared3];
    [self.navigationController pushViewController:detailvc animated:YES];
}

-(void)getActivityDataFromWeb:(void(^)())complete{
    
    [WOTHTTPNetwork getActivitiesWithSpaceId:nil spaceState:[[NSNumber alloc]initWithInt:1]  response:^(id bean, NSError *error) {
        
        complete();
        if (bean) {
            WOTActivityModel_msg *dd = (WOTActivityModel_msg *)bean;
            _dataSource = dd.msg;
           
            [self.tableVIew reloadData];
            
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
