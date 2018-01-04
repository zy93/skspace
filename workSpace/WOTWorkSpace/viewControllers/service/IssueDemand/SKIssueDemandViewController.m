//
//  SKIssueDemandViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKIssueDemandViewController.h"
#import "Masonry.h"
#import "SKAddDemandInfoViewController.h"

@interface SKIssueDemandViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *demandTypeTableView;

@property (nonatomic,strong)NSArray *typeArray;

@property (nonatomic,strong)NSString *demandTypeStr;

@end

@implementation SKIssueDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发布需求";
    self.demandTypeStr = @"选择您的需求类型";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self.view addSubview:self.demandTypeTableView];
    [self layoutSubviews];
}

-(void)loadData
{
    self.typeArray = @[@"人力资源服务",@"财税会计服务",@"法律政策咨询",@"品牌宣传推广",@"投融资对接",@"IT技术支持",@"其他"];
}

-(UITableView *)demandTypeTableView
{
    if (_demandTypeTableView == nil) {
        _demandTypeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _demandTypeTableView.delegate = self;
        _demandTypeTableView.dataSource = self;
        [_demandTypeTableView setTableFooterView:[UIView new]];
    }
    return _demandTypeTableView;
}

-(void)layoutSubviews
{
    [self.demandTypeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =  @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.typeArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKAddDemandInfoViewController *addInfoVC = [[SKAddDemandInfoViewController alloc] init];
    addInfoVC.typeString = self.typeArray[indexPath.row];
    [self.navigationController pushViewController:addInfoVC animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    //获取indexPath
////    NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:section];
////    if (0 == indexPath.section) {//第一组
////        return 30;
////    }else
////        return 15;
//    return 0;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.demandTypeStr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
