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
    return 2;
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
    if (indexPath.row==0) {
        //分钟制转小时制
        long hours = [WOTUserSingleton shareUser].userInfo.workHours.integerValue/60;
        long minute= [WOTUserSingleton shareUser].userInfo.workHours.integerValue%60;
        cell.textLabel.text = @"剩余工位时长";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%ld分钟",hours==0?@"":[NSString stringWithFormat:@"%ld小时",hours],minute];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
    }
    else {
        //分钟制转小时制
        long hours = [WOTUserSingleton shareUser].userInfo.meetingHours.integerValue/60;
        long minute= [WOTUserSingleton shareUser].userInfo.meetingHours.integerValue%60;
        
        cell.textLabel.text = @"剩余工位时长";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%ld分钟",hours==0?@"":[NSString stringWithFormat:@"%ld小时",hours],minute];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
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
