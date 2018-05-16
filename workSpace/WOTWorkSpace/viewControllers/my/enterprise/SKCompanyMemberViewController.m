//
//  SKCompanyMemberViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/14.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKCompanyMemberViewController.h"
#import "SKMemberTableViewCell.h"
#import "SKCompanyMemberModel.h"

@interface SKCompanyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray <SKCompanyMemberModel*>*memberlistArray;
@end

@implementation SKCompanyMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"企业成员";
    self.memberlistArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;

    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKMemberTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKMemberTableViewCell"];
    [self layoutSubviews];
    [self questMemberList];
    
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.memberlistArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMemberTableViewCell"];
    SKCompanyMemberModel *model_msg = self.memberlistArray[indexPath.row];
    [cell.memberHeadView sd_setImageWithURL:[model_msg.headPortrait ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
    cell.memberNameLabel.text = model_msg.userName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了关注");
        if ([[WOTUserSingleton shareUser].userInfo.userId isEqualToNumber:self.memberlistArray[indexPath.row].userId]) {
            [MBProgressHUDUtil showMessage:@"不能删除管理员！" toView:self.view];
            return ;
        }else
        {
            [self deleteMemberWithCompanyId:self.enterpriseModel.companyId userId:self.memberlistArray[indexPath.row].userId];
        }
        
        
    }];
    
    return @[action0];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[WOTUserSingleton shareUser].userInfo.companyIdAdmin rangeOfString:self.enterpriseModel.companyId].location == NSNotFound) {
        NSLog(@"string 不存在 martin");
        return NO;
    } else {
        NSLog(@"string 包含 martin");
        return YES;
    }
    
}

#pragma mark - 请求企业成员列表
-(void)questMemberList
{
    __weak typeof (self) weakSelf = self;
    [WOTHTTPNetwork queryEnterpriseMemberWithCompanyId:self.enterpriseModel.companyId response:^(id bean, NSError *error) {
        SKCompanyMemberModel_msg *model = (SKCompanyMemberModel_msg *)bean;
        if ([model.code isEqualToString:@"200"]) {
            SKCompanyMemberModel_list *model_list = model.msg;
            weakSelf.memberlistArray = [model_list.list mutableCopy];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [MBProgressHUDUtil showMessage:@"" toView:self.view];
            return ;
        }
    }];
}

#pragma mark - 删除企业成员
-(void)deleteMemberWithCompanyId:(NSString *)companyId userId:(NSNumber *)userId
{
    __weak typeof (self) weakSelf = self;
    [WOTHTTPNetwork deleteEnterpriseMemberWithCompanyId:companyId userId:userId response:^(id bean, NSError *error) {
        WOTBaseModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"删除成功！" toView:self.view];
            [weakSelf questMemberList];
        }
        else
        {
            [MBProgressHUDUtil showMessage:@"删除失败！" toView:self.view];
            return ;
        }
    }];
}
@end
