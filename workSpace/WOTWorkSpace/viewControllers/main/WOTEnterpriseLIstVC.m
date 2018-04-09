//
//  WOTEnterpriseLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTEnterpriseLIstVC.h"
#import "WOTEnterpriseListSytle2Cell.h"
#import "WOTSingtleton.h"
#import "WOTEnterpriseModel.h"
#import "NSString+Category.h"
#import "WOTEnterpriseIntroduceVC.h"
#import "WOTProvidersVC.h"

@interface WOTEnterpriseLIstVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray <WOTEnterpriseModel *> *tableList;


@end

@implementation WOTEnterpriseLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];   
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTEnterpriseListSytle2Cell" bundle:nil] forCellReuseIdentifier:@"WOTEnterpriseListSytle2Cell"];
    self.tableView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self createRequest];
    self.navigationItem.title = @"尚科企业";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createRequest
{
    
    [WOTHTTPNetwork getEnterprisesWithSpaceId:[WOTSingtleton shared].nearbySpace.spaceId response:^(id bean, NSError *error) {
        WOTEnterpriseModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            self.tableList = model.msg.list;
            [self.tableView reloadData];
        }
    }];
    
}


#pragma mark - table delgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.tableList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return  125;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTEnterpriseListSytle2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTEnterpriseListSytle2Cell"];
    WOTEnterpriseModel *model = self.tableList[indexPath.row];
    [cell.iconIV setImageWithURL:[model.companyPicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_comm"]];
    cell.titleLab.text = model.companyName;
    cell.locationLab.text = model.spaceName;
    [cell.locationIV setImage:[UIImage imageNamed:@"location_enterprise"]];
    cell.model = model;
    NSArray *arr = [model.companyType componentsSeparatedByString:@","];
    CGFloat a = 20;
    if (arr) {
        if (arr.count==1) {
            cell.subtitleLab1.text = arr.firstObject;
            cell.subtitleLab1Constraint.constant = [((NSString *)arr.firstObject) widthWithFont:[UIFont systemFontOfSize:15]]+a;
            cell.subtitleLab2.hidden = YES;
            cell.subtitleLab3.hidden = YES;
        }
        else if (arr.count==2) {
            cell.subtitleLab1.text = arr.firstObject;
            cell.subtitleLab2.text = arr.lastObject;
            cell.subtitleLab1Constraint.constant = [((NSString *)arr.firstObject) widthWithFont:[UIFont systemFontOfSize:15]]+ a;
            cell.subtitleLab2Constraint.constant = [((NSString *)arr.lastObject) widthWithFont:[UIFont systemFontOfSize:15]]+a;
            cell.subtitleLab3.hidden = YES;

        }
        else if (arr.count >=3) {
            cell.subtitleLab1.text = arr.firstObject;
            cell.subtitleLab2.text = arr[1];
            cell.subtitleLab3.text = arr.lastObject;
            cell.subtitleLab1Constraint.constant = [((NSString *)arr.firstObject) widthWithFont:[UIFont systemFontOfSize:15]]+a;
            cell.subtitleLab2Constraint.constant = [((NSString *)arr[1]) widthWithFont:[UIFont systemFontOfSize:15]]+a;
            cell.subtitleLab3Constraint.constant = [((NSString *)arr.lastObject) widthWithFont:[UIFont systemFontOfSize:15]]+a;

        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WOTProvidersVC *vc = [[WOTProvidersVC alloc] init];
    vc.companyType = CompanyTypeEnterprise;
    vc.enterpriseModel = self.tableList[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
