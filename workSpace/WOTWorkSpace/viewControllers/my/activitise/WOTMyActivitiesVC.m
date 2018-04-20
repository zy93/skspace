//
//  WOTMyActivitiesVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyActivitiesVC.h"
#import "WOTMyActivitiesBaseVC.h"
#import "WOTHTTPNetwork.h"
#import "SKMyActivityModel.h"
#import "SKMyActivityTableViewCell.h"
#import "NSString+Category.h"
#import "WOTH5VC.h"

@interface WOTMyActivitiesVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray <SKMyActivityModel_list *>*myActivityList;
@property(nonatomic,strong)UITableView *myActivityTableView;
@end

@implementation WOTMyActivitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self requestWithMyActivity];
    [self configNavi];
    [self.view addSubview:self.myActivityTableView];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutSubviews
{
    [self.myActivityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myActivityList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKMyActivityTableViewCell";
    SKMyActivityTableViewCell *cell = (SKMyActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SKMyActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.myActivityImageView sd_setImageWithURL:[self.myActivityList[indexPath.row].content.pictureSite ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_comm"]];
    cell.infoLabel.text = self.myActivityList[indexPath.row].content.activityDescribe;
    cell.spaceNameLabel.text = self.myActivityList[indexPath.row].content.spaceName;
    cell.startTimeLabel.text = [self.myActivityList[indexPath.row].content.startTime substringToIndex:11];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = [self.myActivityList[indexPath.row].content.htmlLocation stringToUrl];
    [self.navigationController pushViewController:detailvc animated:YES];
}
-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的活动";
}

#pragma mark - 请求活动信息列表
-(void)requestWithMyActivity
{
    [WOTHTTPNetwork queryMyActivityWithUserTel:[WOTUserSingleton shareUser].userInfo.tel response:^(id bean, NSError *error) {
        SKMyActivityModel_msg *model_msg = (SKMyActivityModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            self.myActivityList = model_msg.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myActivityTableView reloadData];
            });
            return ;
        }
            
        if ([model_msg.code isEqualToString:@"202"])
        {
            [MBProgressHUDUtil showMessage:@"没有活动！" toView:self.view];
            return;
        }
        
        [MBProgressHUDUtil showMessage:@"信息获取失败！" toView:self.view];
        
        

    }];
}

-(NSArray <SKMyActivityModel_list *> *)myActivityList
{
    if (_myActivityList == nil) {
        _myActivityList = [[NSArray alloc] init];
    }
    return _myActivityList;
}

-(UITableView *)myActivityTableView
{
    if (_myActivityTableView == nil) {
        _myActivityTableView = [[UITableView alloc] init];
        _myActivityTableView.delegate = self;
        _myActivityTableView.dataSource = self;
        _myActivityTableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _myActivityTableView;
}

@end
