//
//  WOTProvidersVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTProvidersVC.h"
#import "WOTFirstCell.h"
#import "WOTSecondCell.h"
#import "WOTThirdCell.h"
#import "WOTApplyJoinEnterpriseModel.h"
#import "SKSingleFacilitatorModel.h"

#define ssstr @"我们通过三方面打造共享办公：\n1、通过办公租赁、双创运营、办公服务、金融服务来打造企业共享办公生态圈；\n2、打造孵化器、产业园的升级版平台；通过社区内大企业带动小微企业的入驻模式给小型、小微型企业更多成长空间。另一方面通过线上做为入口，办理会员、注册、入驻，完善服务、聚集数据。通过智能信息化的手段来运营，在平台上完善客户、会员、门禁、监控、宽带、楼宇智能化等系统；\n3、实现社区平台的品牌化、服务标准化、共享化、社交化、智能化、数据化，完善企业办公生态圈服务体系。"

@interface WOTProvidersVC () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIButton * getProvidersBtn;
@end

@implementation WOTProvidersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.companyType == CompanyTypeFacilitator) {
        self.navigationItem.title = @"服务商信息";
    }else
    {
        self.navigationItem.title = @"企业信息";
    }
    
    if (self.sourceType == SOURCE_TYPE_BANNER) {
        [self querySingleServiceProvider];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTSecondCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTThirdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTThirdCell"];
    
    self.getProvidersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.companyType == CompanyTypeFacilitator) {
        [self.getProvidersBtn setTitle:@"获取服务支持" forState:UIControlStateNormal];
    }else
    {
        [self.getProvidersBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    }
    
    [self.getProvidersBtn.layer setCornerRadius:5.f];
    [self.getProvidersBtn setBackgroundColor:UICOLOR_MAIN_ORANGE];
    [self.getProvidersBtn addTarget:self action:@selector(getProvidersBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getProvidersBtn];
    
    [self.getProvidersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(45);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-65);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action
-(void)getProvidersBtnClick:(UIButton *)sender
{
    if (![WOTSingtleton shared].isuserLogin) {
        [MBProgressHUDUtil showMessage:@"请先登录！" toView:self.view];
        return;
    }
    
    if (self.companyType == CompanyTypeFacilitator) {
        [self getServiceSupport];
    }else
    {
        [self applyToJoin];
    }
    
}

#pragma mark - 获取服务支持
-(void)getServiceSupport
{
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"userName":[WOTUserSingleton shareUser].userInfo.userName,
                                 @"spaceId":[WOTUserSingleton shareUser].userInfo.spaceId,
                                 @"tel":[WOTUserSingleton shareUser].userInfo.tel,
                                 @"facilitatorId":self.facilitatorModel.facilitatorId,
                                 @"firmName":self.facilitatorModel.firmName,
                                 @"dealState":@"未处理",
                                 @"needType":@"服务商",
                                 };
    [WOTHTTPNetwork obtainSupportWithParams:parameters response:^(id bean, NSError *error) {
        WOTBaseModel *model = (WOTBaseModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"申请成功，我们将安排服务人员尽快与您联系！" toView:self.view];
        }
        else
        {
            [MBProgressHUDUtil showMessage:@"申请失败！" toView:self.view];
        }
    }];
}

#pragma mark - 申请加入
-(void)applyToJoin
{
    NSLog(@"公司id:%@",[WOTUserSingleton shareUser].userInfo.companyId);
    if ([WOTUitls stringArrayContainsStringWithArrayStr:[WOTUserSingleton shareUser].userInfo.companyId string:self.enterpriseModel.companyId] ||
        [WOTUitls stringArrayContainsStringWithArrayStr:[WOTUserSingleton shareUser].userInfo.companyIdAdmin string:self.enterpriseModel.companyId]) {
        [MBProgressHUDUtil showMessage:@"已经是企业的员工！" toView:self.view];
    }
    else
    {
        if (!self.enterpriseModel.companyId) {
            [MBProgressHUDUtil showMessage:@"企业已经被删除" toView:self.view];
            return;
        }
        [WOTHTTPNetwork applyJoinEnterpriseWithEnterpriseId:self.enterpriseModel.companyId enterpriseName:self.enterpriseModel.companyName response:^(id bean, NSError *error) {
            WOTApplyJoinEnterpriseModel_msg *joinModel = bean;
            if ([joinModel.code isEqualToString:@"200"]) {
                [MBProgressHUDUtil showMessage:@"申请已提交，等待企业管理员审核!" toView:self.view];
                NSString *summary = [NSString stringWithFormat:@"%@申请加入您管理的%@企业",[WOTUserSingleton shareUser].userInfo.userName,self.enterpriseModel.companyName];
                [WOTHTTPNetwork sendMessageWithUserId:self.enterpriseModel.contactsUserId type:@"企业申请" summary:summary response:^(id bean, NSError *error) {
                    
                }];
            }
            
            if ([joinModel.code isEqualToString:@"205"]) {
                [MBProgressHUDUtil showMessage:@"申请已提交" toView:self.view];
                return ;
            }
            
            if ([joinModel.code isEqualToString:@"206"]) {
                [MBProgressHUDUtil showMessage:@"企业已经被删除" toView:self.view];
                
            }
        }];
        
    }
    
}

#pragma mark - table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 110;
    }
    else if (indexPath.row==1) {
        NSString *str = strIsEmpty(self.facilitatorModel.facilitatorDescribe)?ssstr:self.facilitatorModel.facilitatorDescribe;
        return 80+([str heightWithFont:[UIFont systemFontOfSize:13.f] maxWidth:SCREEN_WIDTH-40]);
    }
    else if (indexPath.row==2) {
        return 160;
    }
    else {
        return 95;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        WOTFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTFirstCell"];
        if (!cell) {
            cell = [[WOTFirstCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTFirstCell"];
        }
        NSArray *arr;
        if (self.companyType == CompanyTypeFacilitator) {
            arr = [self.facilitatorModel.firmLogo componentsSeparatedByString:@","];
            [cell.iconIV setImageWithURL:[arr.firstObject ToResourcesUrl] placeholderImage:[UIImage imageNamed:@""]];
            cell.titleLab.text = self.facilitatorModel.firmName;
            arr = [self.facilitatorModel.businessScope componentsSeparatedByString:@","];
        }else
        {
            arr = [self.enterpriseModel.companyPicture componentsSeparatedByString:@","];
            [cell.iconIV setImageWithURL:[arr.firstObject ToResourcesUrl] placeholderImage:[UIImage imageNamed:@""]];
            cell.titleLab.text = self.enterpriseModel.companyName;
            arr = [self.enterpriseModel.companyType componentsSeparatedByString:@","];
        }
        
        if (arr.count<=0) {
            cell.subtitle1Lab.hidden = YES;
            cell.subtitle2Lab.hidden = YES;
            cell.subtitle3Lab.hidden = YES;
        }
        else if (arr.count==1) {
            cell.subtitle1Lab.hidden = NO;
            cell.subtitle2Lab.hidden = YES;
            cell.subtitle3Lab.hidden = YES;
            cell.subtitle1Lab.text = arr.firstObject;
        }
        else if (arr.count==2) {
            cell.subtitle1Lab.hidden = NO;
            cell.subtitle2Lab.hidden = NO;
            cell.subtitle3Lab.hidden = YES;
            cell.subtitle1Lab.text = arr.firstObject;
            cell.subtitle2Lab.text = arr.lastObject;
        }
        else  {
            cell.subtitle1Lab.hidden = NO;
            cell.subtitle2Lab.hidden = NO;
            cell.subtitle3Lab.hidden = NO;
            cell.subtitle1Lab.text = arr.firstObject;
            cell.subtitle2Lab.text = arr[1];
            cell.subtitle3Lab.text = arr.lastObject;
        }
        return cell;
    }
    else if (indexPath.row==1) {
        WOTSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSecondCell"];
        if (!cell) {
            cell = [[WOTSecondCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTSecondCell"];
        }
        NSString *str;
        if (self.companyType == CompanyTypeFacilitator) {
            cell.titleLab.text = @"服务商介绍";
            str = strIsEmpty(self.facilitatorModel.introduce)?ssstr:self.facilitatorModel.introduce;
        }else
        {
            cell.titleLab.text = @"企业介绍";
            str = strIsEmpty(self.enterpriseModel.companyProfile)?ssstr:self.enterpriseModel.companyProfile;
        }
        cell.textView.text = str;
        return cell;
    }
    else if (indexPath.row==2) {
        WOTThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTThirdCell"];
        if (!cell) {
            cell = [[WOTThirdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTThirdCell"];
        }
        cell.titleLab.text = @"联系信息";
        if (self.companyType == CompanyTypeFacilitator) {
            cell.nameValueLab.text = self.facilitatorModel.contacts;
            cell.addrssValueLab.text = strIsEmpty(self.facilitatorModel.city)?@"暂无":self.facilitatorModel.city;
            cell.webValueLab.text = strIsEmpty(self.facilitatorModel.website)?@"暂无":self.facilitatorModel.website;
        }else
        {
            cell.nameValueLab.text = self.enterpriseModel.contacts;
            cell.addrssValueLab.text = strIsEmpty(self.enterpriseModel.companySite)?@"暂无":self.enterpriseModel.companySite;
            cell.webValueLab.text = strIsEmpty(self.enterpriseModel.website)?@"暂无":self.enterpriseModel.website;;
        }
        
        return cell;
    }
    else {
        WOTSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSecondCell"];
        if (!cell) {
            cell = [[WOTSecondCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTSecondCell"];
        }
        [cell.iconIV setImage:[UIImage imageNamed:@"shequ"]];
        cell.titleLab.text = @"服务社区";
        cell.textView.text = @"全部社区";
        return cell;
    }
}

#pragma mark - 请求当个服务商
-(void)querySingleServiceProvider
{
    __weak typeof(self)weakSelf = self;
    [WOTHTTPNetwork querySingleFacilitator:self.singleFacilitatorId response:^(id bean, NSError *error) {
        SKSingleFacilitatorModel *model = (SKSingleFacilitatorModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.facilitatorModel = model.msg;
            [weakSelf.tableView reloadData];
        }else
        {
            [MBProgressHUDUtil showMessage:@"请求失败！" toView:self.view];
        }
    }];
}


@end
