//
//  WOTMyEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyEnterpriseVC.h"
#import "WOTEnterpriseIntroduceVC.h"
#import "WOTJoiningEnterpriseVC.h"
#import "WOTCreateEnterpriseVC.h"
#import "WOTEnterpriseApplyVC.h"
#import "WOTMyEnterPriseCell.h"
#import "WOTEnterpriseModel.h"

@interface WOTMyEnterpriseVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSArray <WOTEnterpriseModel *>*tableList;

@end

@implementation WOTMyEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavi];
    // Do any additional setup after loading the view.
    [self.table registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTMyEnterPriseCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //[self querySingleInfo];
//    [self.tabBarController.tabBar setHidden:YES];
    [self createRequest];
}
-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的企业";
    if (!strIsEmpty([WOTUserSingleton shareUser].userInfo.companyIdAdmin)) {
        [self configNaviRightItemWithImage:[UIImage imageNamed:@"message"]];
    }
}

-(void)rightItemAction{
    //跳转页面
    WOTEnterpriseApplyVC *vc = [[WOTEnterpriseApplyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)joiningEnterprise:(id)sender {
    WOTSearchVC *searchvc = [[WOTSearchVC alloc]init];
    [self.navigationController pushViewController:searchvc animated:YES];
}

- (IBAction)createEnterprise:(id)sender {
    WOTCreateEnterpriseVC *vc = [[WOTCreateEnterpriseVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 查询个人信息
//-(void)querySingleInfo
//{
//    //querySingularManInfoWithUserId
//    [WOTHTTPNetwork querySingularManInfoWithUserId:[WOTUserSingleton shareUser].userInfo.userId response:^(id bean, NSError *error) {
//        WOTLoginModel_msg *model_msg = (WOTLoginModel_msg *)bean;
//        if ([model_msg.code isEqualToString:@"200"]) {
//            [[WOTUserSingleton shareUser] saveUserInfoToPlistWithModel:model_msg.msg];
//            [self createRequest];
//        }
//    }];
//}

-(void)createRequest
{
    NSString *adminList = [WOTUserSingleton shareUser].userInfo.companyIdAdmin;
    NSString *employees = [WOTUserSingleton shareUser].userInfo.companyId;
    NSMutableString *result = [NSMutableString new];
    if (!strIsEmpty(adminList)) {
        result = [adminList mutableCopy];
    }
    if (!strIsEmpty(employees)) {
        NSString *a =  [NSString stringWithFormat:@"%@%@",strIsEmpty(result)?@"":@",",employees];
        [result appendString:a];
    }
    if (strIsEmpty(result)) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getUserEnterpriseWithCompanyId:result response:^(id bean, NSError *error) {
        WOTEnterpriseModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.tableList = model.msg.list;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.table reloadData];
            });
        }
    }];
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTMyEnterPriseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyEnterPriseCell"];
    WOTEnterpriseModel *model = self.tableList[indexPath.row];
    [cell.enterpriseHeaderImage setImageWithURL:[model.companyPicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_comm"]];
    cell.enterpariseName.text = model.companyName;
    cell.joinEnterpriseTime .text = model.companyProfile;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSelectEnterprise) {
        self.selectEnterpriseBlock(self.tableList[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        WOTEnterpriseIntroduceVC *vc = [[WOTEnterpriseIntroduceVC alloc] init];
        vc.model = self.tableList[indexPath.row];
        vc.vcType = INTRODUCE_VC_TYPE_Enterprise;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
