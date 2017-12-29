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

@interface WOTEnterpriseIntroduceVC () <WOTEnterpriseIntroduceNameCellDelegate>
{
}
@property (nonatomic, strong) NSArray *tableList;

@end

@implementation WOTEnterpriseIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"企业介绍";
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
//    [WOTHTTPNetwork joinEnterpriseWithEnterpriseId:<#(NSNumber *)#> response:<#^(id bean, NSError *error)response#>];
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
        
        return ([self.model.companyProfile heightWithFont:[UIFont systemFontOfSize:17.f] maxWidth:SCREEN_WIDTH-80] +8+8);
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
        NSURL *ur = [self.model.companyPicture ToResourcesUrl];
        UIImage *im = [UIImage imageNamed:@"placeholder_comm"];
        [cell.logoIV setImageWithURL:ur placeholderImage:im];
        cell.titleLab.text = self.model.companyName;
        cell.subtitleLab.text = self.model.internetEnterprises;
        cell.delegate = self;
        //判断当前用户是否是该企业员工
        if ([[WOTUserSingleton shareUser].userInfo.companyId isEqualToString:(NSString *)self.model.companyId] && !strIsEmpty([WOTUserSingleton shareUser].userInfo.companyId)) {
            cell.applyJoinBtn.hidden = YES;
        }
        
        
        return cell;
    }
    else {
        WOTEnterpriseIntroduceMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTEnterpriseIntroduceMessageCell"];
        NSArray *arr = self.tableList[indexPath.section];
        [cell.iconIV setImage:[UIImage imageNamed:@"placeholder_comm"]];
        if ([arr[indexPath.row] isEqualToString:@"联系人"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.model.contacts?self.model.contacts:@"暂未填写"]];

        }
        else if ([arr[indexPath.row] isEqualToString:@"联系电话"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.model.tel?self.model.tel:@"暂未填写"]];
            
        }
        else if ([arr[indexPath.row] isEqualToString:@"邮箱"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.model.mailbox?self.model.mailbox:@"暂未填写"]];
            
        }
        else if ([arr[indexPath.row] isEqualToString:@"员工人数"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.model.employeesNum?self.model.employeesNum:@"暂未填写"]];
            
        }
        else if ([arr[indexPath.row] isEqualToString:@"企业状态"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:正常营业",arr[indexPath.row]]];
            
        }
        else if ([arr[indexPath.row] isEqualToString:@"企业介绍"]) {
            [cell.titleLab setText:[NSString stringWithFormat:@"%@:%@",arr[indexPath.row],self.model.companyProfile?self.model.companyProfile:@"暂未填写"]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
