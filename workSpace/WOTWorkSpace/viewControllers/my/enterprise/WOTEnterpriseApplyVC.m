//
//  WOTEnterpriseApplyVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseApplyVC.h"
#import "WOTApplyCell.h"

@interface WOTEnterpriseApplyVC () <UITableViewDelegate, UITableViewDataSource, WOTApplyCellDelegate>
@property (nonatomic, strong) NSArray *tableList;
@end

@implementation WOTEnterpriseApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTApplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTApplyCell"];
    [self configNav];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configNav
{
    self.navigationItem.title = @"消息列表";
}


-(void)createRequest
{
//
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getApplyJoinEnterpriseListWithEnterpriseIds:[WOTUserSingleton shareUser].userInfo.companyIdAdmin response:^(id bean, NSError *error) {
        WOTApplyJoinEnterpriseModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            weakSelf.tableList = model.msg.list;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    }];
    
}


#pragma mark - cell delegate
-(void)cell:(WOTApplyCell *)cell clickBtn:(UIButton *)sender
{
    [WOTHTTPNetwork disposeApplyJoinEnterprise:cell.model.id response:^(id bean, NSError *error) {
        WOTApplyJoinEnterpriseModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"已同意" toView:self.view];
            [self createRequest];
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
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTApplyCell"];
    if (!cell) {
        cell = [[WOTApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WOTApplyCell"];
    }
    WOTApplyModel *model = self.tableList[indexPath.row];
    [cell.iconIV setImageWithURL:[model.headPortrait ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_comm"]];
    cell.titleLab.text = model.userName;
    cell.delegate = self;
    cell.subtitleLab.text  = [NSString stringWithFormat:@"申请加入企业[%@]",model.companyName];
    cell.model = model;
    if ([model.applyForState isEqualToString:@"待处理"]) {
        cell.agreeBtn.hidden = NO;
    }
    else {
        cell.agreeBtn.hidden = YES;
    }
    
    return cell;
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
