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


#define ssstr @"我们通过三方面打造共享办公：\n1、通过办公租赁、双创运营、办公服务、金融服务来打造企业共享办公生态圈；\n2、打造孵化器、产业园的升级版平台；通过社区内大企业带动小微企业的入驻模式给小型、小微型企业更多成长空间。另一方面通过线上做为入口，办理会员、注册、入驻，完善服务、聚集数据。通过智能信息化的手段来运营，在平台上完善客户、会员、门禁、监控、宽带、楼宇智能化等系统；\n3、实现社区平台的品牌化、服务标准化、共享化、社交化、智能化、数据化，完善企业办公生态圈服务体系。"

@interface WOTProvidersVC () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation WOTProvidersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"服务商信息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTFirstCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTSecondCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTSecondCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTThirdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTThirdCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSArray *arr = [self.facilitatorModel.firmLogo componentsSeparatedByString:@","];
        [cell.iconIV setImageWithURL:[arr.firstObject ToResourcesUrl] placeholderImage:[UIImage imageNamed:@""]];
        cell.titleLab.text = self.facilitatorModel.firmName;
        arr = [self.facilitatorModel.businessScope componentsSeparatedByString:@","];
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
        cell.titleLab.text = @"服务商介绍";
        NSString *str = strIsEmpty(self.facilitatorModel.facilitatorDescribe)?ssstr:self.facilitatorModel.facilitatorDescribe;

        cell.textView.text = str;
        return cell;
    }
    else if (indexPath.row==2) {
        WOTThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTThirdCell"];
        if (!cell) {
            cell = [[WOTThirdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTThirdCell"];
        }
        cell.titleLab.text = @"联系信息";
        cell.nameValueLab.text = self.facilitatorModel.contacts;
        cell.webValueLab.text = @"http://www.yiliangang.com";
        cell.addrssValueLab.text = strIsEmpty(self.facilitatorModel.city)?@"暂无":self.facilitatorModel.city;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
