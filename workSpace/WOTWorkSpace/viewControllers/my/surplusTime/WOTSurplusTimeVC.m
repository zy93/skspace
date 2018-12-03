//
//  WOTSurplusTimeVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSurplusTimeVC.h"

@interface WOTSurplusTimeVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView * topIV;
@property (nonatomic, strong) UITableView * table;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *timeArray;
@end

@implementation WOTSurplusTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"剩余时长";
    [self.navigationController setNavigationBarHidden:NO];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    

    self.topIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"surplus_time"]];
    self.topIV.layer.cornerRadius = 5.f;
    self.topIV.clipsToBounds = YES;
    [self.view addSubview:self.topIV];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.layer.cornerRadius = 5.f;
    self.table.clipsToBounds = YES;
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.scrollEnabled = NO;
    [self.view addSubview:self.table];
    
    [self.topIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(230*[WOTUitls GetLengthAdaptRate]);
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topIV.mas_bottom).with.offset(2);
        make.left.equalTo(self.topIV.mas_left);
        make.right.equalTo(self.topIV.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self queryAllCompany];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SurplusTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SurplusTableViewCell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.detailTextLabel.text = self.timeArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
    return cell;
}

#pragma mark - 将分钟转化为显示的字符串
-(NSString *)timeIntChaneStr:(NSNumber *)hoursNumber
{
    long hours = hoursNumber.integerValue/60;
    long minute= hoursNumber.integerValue%60;
    NSString *str = [NSString stringWithFormat:@"%@%ld分钟",hours==0?@"":[NSString stringWithFormat:@"%ld小时",hours],minute];
    return str;
}

-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
        [_titleArray addObject:@"个人剩余工位时长"];
        [_titleArray addObject:@"个人剩余会议室时长"];
    }
    return _titleArray;
}

-(NSMutableArray *)timeArray
{
    if (!_timeArray) {
        _timeArray = [[NSMutableArray alloc] init];
        [_timeArray addObject:[self timeIntChaneStr:[WOTUserSingleton shareUser].userInfo.workHours]];
        [_timeArray addObject:[self timeIntChaneStr:[WOTUserSingleton shareUser].userInfo.meetingHours]];
    }
    return _timeArray;
}

#pragma mark - 请求所有企业
-(void)queryAllCompany
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
        WOTEnterpriseModel_msg *model_msg = bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            for (WOTEnterpriseModel *model in model_msg.msg.list) {
                [weakSelf.titleArray addObject:[NSString stringWithFormat:@"%@剩余会议室时长",model.companyName]];
                [weakSelf.timeArray addObject:[self timeIntChaneStr:model.givingRemainingTime]];
            }
            [weakSelf.table reloadData];
        }
    }];
}

@end
