//
//  WOTSearchVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSearchVC.h"
#import "WOTMyEnterPriseCell.h"
#import "WOTEnterpriseIntroduceVC.h"
@interface WOTSearchVC () <UITableViewDelegate>
//@property (
@end

@implementation WOTSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBackItem];
    
    __weak typeof(self) weakSelf = self;
    
    [self configNaviView:@"请输入关键字"  searchBlock:^(NSString *searchString) {
        if (strIsEmpty(searchString)) {
            return ;
        }
        [WOTHTTPNetwork searchEnterprisesWithName:searchString response:^(id bean, NSError *error) {
            WOTEnterpriseModel_msg *model = (WOTEnterpriseModel_msg*)bean;
            if ([model.code isEqualToString:@"200"]) {
                weakSelf.dataSource = model.msg.list;
                [weakSelf.tableView reloadData];
            }
            
        }];


    } clearBlock:^{
        [weakSelf back];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"myenterpriseCellID"];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyEnterPriseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myenterpriseCellID"];
    WOTEnterpriseModel *model = self.dataSource[indexPath.row];
    [cell.enterpriseHeaderImage setImageWithURL:[model.companyPicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
    cell.enterpariseName.text = self.dataSource[indexPath.row].companyName;
    cell.joinEnterpriseTime.text = self.dataSource[indexPath.row].companyType;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTEnterpriseIntroduceVC *vc = [[WOTEnterpriseIntroduceVC alloc] init];
    vc.model = self.dataSource[indexPath.row];
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
