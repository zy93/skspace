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
#import "WOTProvidersVC.h"
#import "SKCompanyMemberViewController.h"
#import "UIColor+ColorChange.h"
#import "WOTApplyJoinEnterpriseModel.h"

@interface WOTMyEnterpriseVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSArray <WOTEnterpriseModel *>*tableList;

@property (nonatomic,strong)UIImageView *notInfoImageView;
@property (nonatomic,strong)UILabel *notInfoLabel;
@property (nonatomic,strong)UIButton *finishButton;
@end

@implementation WOTMyEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //[self configNavi];
    // Do any additional setup after loading the view.
    [self.table registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTMyEnterPriseCell"];
    self.notInfoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotInformation"]];
    self.notInfoImageView.hidden = YES;
    [self.view addSubview:self.notInfoImageView];
    
    self.notInfoLabel = [[UILabel alloc] init];
    self.notInfoLabel.hidden = YES;
    self.notInfoLabel.text = @"亲,暂时没有加入任何企业！";
    self.notInfoLabel.textColor = [UIColor colorWithRed:145/255.f green:145/255.f blue:145/255.f alpha:1.f];
    self.notInfoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.notInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.notInfoLabel];
    if ([self.firstString isEqualToString:@"firstLogin"]) {
        self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.finishButton addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchDown];
        self.finishButton.backgroundColor = [UIColor colorWithHexString:@"ff7f3d"];
        self.finishButton.layer.cornerRadius = 5.f;
        self.finishButton.layer.borderWidth = 1.f;
        self.finishButton.layer.borderColor =[UIColor colorWithHexString:@"ff7f3d"].CGColor;
        [self.view addSubview:self.finishButton];
    }
    [self layoutSubviews];
    
}



-(void)layoutSubviews
{
    if ([self.firstString isEqualToString:@"firstLogin"]) {
        [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(10);
            make.right.equalTo(self.view).with.offset(-10);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
            make.height.mas_offset(48);
        }];
    }
    [self.notInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-50);
        make.height.width.mas_offset(70);
    }];
    
    [self.notInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.notInfoImageView.mas_bottom).with.offset(10);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //[self querySingleInfo];
//    [self.tabBarController.tabBar setHidden:YES];
    [self configNavi];
    [self createRequest];
}
-(void)configNavi{
    self.navigationItem.title = @"我的企业";
    
    if ([self.firstString isEqualToString:@"firstLogin"]) {
        NSLog(@"第一次登陆");
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.size = CGSizeMake(50, 20);
        [rightButton setTitle:@"跳过" forState:UIControlStateNormal];
        [rightButton setTitleColor:UICOLOR_MAIN_ORANGE forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [rightButton addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        self.navigationItem.leftBarButtonItem.customView.hidden = YES;
        self.navigationItem.hidesBackButton = YES;
    }else
    {
        if (!strIsEmpty([WOTUserSingleton shareUser].userInfo.companyIdAdmin)) {
            
            [self createRequestInfo];
        }
        [self configNaviBackItem];
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

#pragma mark - 查询是否有消息
-(void)createRequestInfo
{
    [WOTHTTPNetwork getApplyJoinEnterpriseListWithEnterpriseIds:[WOTUserSingleton shareUser].userInfo.companyIdAdmin response:^(id bean, NSError *error) {
        WOTApplyJoinEnterpriseModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configNaviRightItemWithImage:[UIImage imageNamed:@"message-no"]];
            });
        }
        
        if ([model.code isEqualToString:@"202"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self configNaviRightItemWithImage:[UIImage imageNamed:@"message"]];
                });
        }
    }];
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
                self.notInfoImageView.hidden = YES;
                self.notInfoLabel.hidden = YES;
                [weakSelf.table reloadData];
            });
        }
        self.notInfoImageView.hidden = NO;
        self.notInfoLabel.hidden = NO;
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
//        WOTProvidersVC *vc = [[WOTProvidersVC alloc] init];
//        vc.companyType = CompanyTypeEnterprise;
//        vc.enterpriseModel = self.tableList[indexPath.row];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        SKCompanyMemberViewController *vc = [[SKCompanyMemberViewController alloc] init];
        vc.enterpriseModel = self.tableList[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
//        WOTEnterpriseIntroduceVC *vc = [[WOTEnterpriseIntroduceVC alloc] init];
//        vc.model = self.tableList[indexPath.row];
//        vc.vcType = INTRODUCE_VC_TYPE_Enterprise;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 跳过按钮
-(void)skipAction
{
    NSNotification *notification = [NSNotification notificationWithName:@"SkipNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark - 完成
-(void)finishButtonAction
{
    NSNotification *notification = [NSNotification notificationWithName:@"SkipNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
