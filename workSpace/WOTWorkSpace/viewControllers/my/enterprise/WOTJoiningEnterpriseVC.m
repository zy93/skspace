//
//  WOTJoiningEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTJoiningEnterpriseVC.h"
#import "WOTMyEnterPriseCell.h"
#import "WOTEnterpriseModel.h"
#import "WOTH5VC.h"
@interface WOTJoiningEnterpriseVC (){
    NSArray<WOTEnterpriseModel *> *endataSource;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation WOTJoiningEnterpriseVC

-(instancetype)init{
    self = [super init];
    if (self) {
        endataSource =  [[NSArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.tableView.showsVerticalScrollIndicator = NO;
     [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"myenterpriseCellID"];
    [self getMyEnterpriseDataSourceFromWeb];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return endataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyEnterPriseCell *enterprisecell = [tableView dequeueReusableCellWithIdentifier:@"myenterpriseCellID" forIndexPath:indexPath];
    enterprisecell.enterpariseName.text = endataSource[indexPath.row].companyName;
    enterprisecell.joinEnterpriseTime.text = endataSource[indexPath.row].spared1;
    [enterprisecell.enterpriseHeaderImage sd_setImageWithURL:[endataSource[indexPath.row].companyPicture ToUrl] placeholderImage:[UIImage imageNamed:@"enterprise_default"]];
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        enterprisecell.lineView.hidden = YES;
    } else {
        enterprisecell.lineView.hidden = NO;
    }
    return enterprisecell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = @"http://www.yiliangang.net:8012/makerSpace/companyInfo.html";
    [self.supervc.navigationController pushViewController:detailvc animated:YES];
}
-(void)getMyEnterpriseDataSourceFromWeb{
//    [[WOTUserSingleton shareUser]setValues];
    [WOTHTTPNetwork getUserEnterpriseWithCompanyId:[WOTUserSingleton shareUser].userInfo.companyId response:^(id bean, NSError *error) {
        WOTEnterpriseModel_msg *dd = (WOTEnterpriseModel_msg*)bean;
        endataSource = dd.msg;
        [self.tableView reloadData];
        
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
