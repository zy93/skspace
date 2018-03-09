//
//  WOTMyInviteVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyInviteVC.h"
#import "WOTMyInvityCell.h"
#import "WOTLoginModel.h"
#import "WOTShareVC.h"

@interface WOTMyInviteVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * table;
@property (nonatomic, strong) UIButton *inviteBtn;
@property (nonatomic, strong) WOTMyInviteModel_model * inviteModel;

@end

@implementation WOTMyInviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的邀请";
    [self loadViews];
    [self.table registerNib:[UINib nibWithNibName:@"WOTMyInvityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTMyInvityCell"];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)loadViews {
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.table.backgroundColor = UICOLOR_CLEAR;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    self.inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.inviteBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
    self.inviteBtn.backgroundColor = UICOLOR_MAIN_ORANGE;
    self.inviteBtn.layer.cornerRadius = 5.f;
    [self.inviteBtn addTarget:self action:@selector(inviteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.inviteBtn];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.equalTo(self.inviteBtn.mas_top).with.offset(-20);;
    }];
    
    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.height.mas_offset(40);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(IS_IPHONE_X?-40:-20);
    }];
}

-(void)createRequest
{
    [WOTHTTPNetwork getUserInviteResponse:^(id bean, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.inviteModel = bean;
            [self.table reloadData];
        });
    }];
}

#pragma mark - action
-(void)inviteBtnClick:(UIButton *)sender
{
    NSString *shareUrl = @"http://219.143.170.98:10011/SKwork/SKmaker/share/shareRegistration.html";
    WOTShareVC *vc = [[WOTShareVC alloc] init];
    vc.shareUrl = [NSString stringWithFormat:@"%@?byInvitationCode=%@",shareUrl,[WOTUserSingleton shareUser].userInfo.meInvitationCode];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inviteModel.msg.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UICOLOR_MAIN_ORANGE;
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"当前账户收益总额(元)";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15.f];
    [view addSubview:lab];
    UILabel *value = [[UILabel alloc] init];
    value.text= [NSString stringWithFormat:@"%.2f",self.inviteModel.msg.sum.floatValue];
    value.textColor = [UIColor whiteColor];
    value.font = [UIFont systemFontOfSize:30.f];
    [view addSubview:value];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_offset(20);
    }];
    
    [value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15);
        make.left.mas_offset(20);
    }];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    WOTMyInvityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyInvityCell"];
    if (!cell) {
        cell = [[WOTMyInvityCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTMyInvityCell"];
    }
    WOTLoginModel *model = self.inviteModel.msg.list[indexPath.row];
    
    [cell.iconIV setImageWithURL:[model.headPortrait ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
    cell.titleLab.text = model.realName;
    cell.subtitleLab.text = model.tel;
    cell.money.text = model.rebateSum.integerValue==0?nil:[NSString stringWithFormat:@"+%.2f",model.rebateSum.floatValue];
    
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
