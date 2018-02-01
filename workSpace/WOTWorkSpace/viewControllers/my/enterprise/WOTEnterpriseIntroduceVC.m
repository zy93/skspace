//
//  WOTEnterpriseIntroduceVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseIntroduceVC.h"
#import "WOTEnterpriseIntroduceNameCell.h"
#import "WOTEnterpriseIntroduceMessageCell.h"
#import "WOTApplyJoinEnterpriseModel.h"


@interface WOTEnterpriseIntroduceVC () <WOTEnterpriseIntroduceNameCellDelegate>
{
}
@property(nonatomic, strong) NSArray *tableList;
@property(nonatomic, strong) NSArray *iconList;
@property(nonatomic, strong) NSString *contact;
@property(nonatomic, strong) NSString *tel;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSNumber *employeeNumber;
@property(nonatomic, strong) NSString *enterpriseState;
@property(nonatomic, strong) NSString *enterpriseIntroduce;
@property(nonatomic, strong) NSString *companyName;
@property(nonatomic, strong) NSString *companyPicture;

@end

@implementation WOTEnterpriseIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"企业介绍";
    if (self.vcType == INTRODUCE_VC_TYPE_Enterprise) {
        self.contact = self.model.contacts;
        self.tel = self.model.tel;
        self.email = self.model.mailbox;
        self.employeeNumber = self.model.employeesNum;
        self.enterpriseIntroduce = self.model.companyProfile;
        self.companyName = self.model.companyName;
        self.companyPicture = self.model.companyPicture;
    }else
    {
        self.contact = self.facilitatorModel.contacts;
        self.tel = self.facilitatorModel.tel;
        self.enterpriseIntroduce= @"暂未填写";
        self.companyName = self.facilitatorModel.firmName;
        self.companyPicture = self.facilitatorModel.firmLogo;

    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [imageView setImage:[UIImage imageNamed:@"Yosemite02"]];
    self.tableView.tableHeaderView =  imageView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTEnterpriseIntroduceNameCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTEnterpriseIntroduceNameCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTEnterpriseIntroduceMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTEnterpriseIntroduceMessageCell"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - cell delegate
-(void)enterpriseCellApplyJoin:(WOTEnterpriseIntroduceNameCell *)cell
{
    [WOTHTTPNetwork applyJoinEnterpriseWithEnterpriseId:self.model.companyId enterpriseName:self.model.companyName response:^(id bean, NSError *error) {
        WOTApplyJoinEnterpriseModel_msg *joinModel = bean;
        if ([joinModel.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"申请已提交，等待企业管理员审核!" toView:self.view];
        }
    }];
}


#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.tableList[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 70;
    }
    else if (indexPath.section == 3) {
        
        return ([self.enterpriseIntroduce heightWithFont:[UIFont systemFontOfSize:17.f] maxWidth:SCREEN_WIDTH-80] +8+8);
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.tableList.count-1) {
        return 10;
    }
    else {
        return 0.001;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        WOTEnterpriseIntroduceNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTEnterpriseIntroduceNameCell"];
        NSURL *ur = [self.companyPicture ToResourcesUrl];
        UIImage *im = [UIImage imageNamed:@"placeholder_comm"];
        [cell.logoIV setImageWithURL:ur placeholderImage:im];
        cell.titleLab.text = self.companyName;
        cell.subtitleLab.text = self.model.internetEnterprises;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //加载button
        if (self.vcType == INTRODUCE_VC_TYPE_Enterprise) {
            //判断当前用户是否是该企业员工
            if ([WOTUitls stringArrayContainsStringWithArrayStr:[WOTUserSingleton shareUser].userInfo.companyId string:self.model.companyId] ||
                [WOTUitls stringArrayContainsStringWithArrayStr:[WOTUserSingleton shareUser].userInfo.companyIdAdmin string:self.model.companyId]) {
                cell.applyJoinBtn.hidden = YES;
            }
            else {
                cell.applyJoinBtn.hidden = NO;
            }
        }else
        {
            cell.applyJoinBtn.hidden = YES;
        }
        return cell;
    }
    else {
        WOTEnterpriseIntroduceMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTEnterpriseIntroduceMessageCell"];
        NSArray *arr = self.tableList[indexPath.section];
        if (indexPath.section!=0) {
            [cell.iconIV setImage:[UIImage imageNamed:self.iconList[indexPath.section][indexPath.row]]];
        }
        else {
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([arr[indexPath.row] isEqualToString:@"联系人"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.contact?self.contact:@"暂未填写"]];
        }
        else if ([arr[indexPath.row] isEqualToString:@"联系电话"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.tel?self.tel:@"暂未填写"]];
        }
        else if ([arr[indexPath.row] isEqualToString:@"邮箱"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.email?self.email:@"暂未填写"]];
        }
        else if ([arr[indexPath.row] isEqualToString:@"员工人数"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.employeeNumber?self.employeeNumber:@"暂未填写"]];
        }
        else if ([arr[indexPath.row] isEqualToString:@"企业状态"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:正常营业",arr[indexPath.row]]];
        }
        else if ([arr[indexPath.row] isEqualToString:@"企业介绍"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.enterpriseIntroduce?self.enterpriseIntroduce:@"暂未填写"]];
        }
        
         return cell;
    }
}



#pragma mark - load
-(NSArray *)tableList
{
    if (!_tableList) {
        _tableList = @[@[@"企业名称"], @[@"联系人", @"联系电话", @"邮箱"], @[@"员工人数", @"企业状态"], @[@"企业介绍"]];
    }
    return _tableList;
}

-(NSArray *)iconList
{
    if (!_iconList) {
        _iconList = @[@[@"企业名称"], @[@"enterprise_contacts", @"enterprise_tel", @"enterprise_email"], @[@"enterprise_number", @"enterprise_state"], @[@"enterprise_introduce"]];
    }
    return _iconList;
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
