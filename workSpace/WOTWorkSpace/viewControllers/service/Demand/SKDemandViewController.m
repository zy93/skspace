//
//  SKDemandViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKDemandViewController.h"
#import "Masonry.h"
#import "SKDemandInfoViewController.h"

@interface SKDemandViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *demandTableView;
@property(nonatomic,strong)NSString *headerStr;
@property(nonatomic,strong)NSArray *typeArray;
@end

@implementation SKDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布需求";
    [self loadData];
    [self.view addSubview:self.demandTableView];
    
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 布局约束
-(void)layoutSubviews
{
    [self.demandTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.typeArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = CGRectMake(15, 0, 200, 40);
    [headerView addSubview:label];
    if (section == 0) {
        label.text = self.headerStr;
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKDemandInfoViewController *demandInfoVC = [[SKDemandInfoViewController alloc] init];
    demandInfoVC.typeString = self.typeArray[indexPath.row];
    [self.navigationController pushViewController:demandInfoVC animated:YES];
}

#pragma mark - 加载数据
-(void)loadData
{
    self.headerStr = @"选择您的需求类型";
    self.typeArray = @[@"金融服务",@"人力资源&党建",@"品牌营销推广",@"智能信息化",@"政府事务",@"工商财税注册",@"其他"];
}
-(UITableView *)demandTableView
{
    if (_demandTableView == nil) {
        _demandTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _demandTableView.delegate = self;
        _demandTableView.dataSource = self;
    }
    return _demandTableView;
}



@end
