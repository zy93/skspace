//
//  WOTInformationListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTInformationListVC.h"
#import "WOTInformationLIstCell.h"
#import "WOTCommonHeaderVIew.h"
#import "WOTH5VC.h"
@interface WOTInformationListVC ()
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UIImageView *notInformationView;
@property (weak, nonatomic) IBOutlet UILabel *notInfoLabel;

@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation WOTInformationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notInformationView.hidden = YES;
    self.notInfoLabel.hidden = YES;
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.tableView.backgroundColor = UICOLOR_CLEAR;
    _dataSource = [[NSMutableArray alloc]init];
    [self configNav];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTInformationLIstCell" bundle:nil] forCellReuseIdentifier:@"WOTInformationLIstCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTCommonHeaderVIew" bundle:nil] forHeaderFooterViewReuseIdentifier:@"WOTCommonHeaderVIewID"];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
     page = 0;
    [self createRequest];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.customView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    [_HUD showAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;

}
-(void)configNav{
    [self configNaviBackItem];  
    self.navigationItem.title = @"最新资讯";
}
-(void)loadMoreTopic
{
    [self createRequest];
}

#pragma mark - 停止刷新
- (void)stoploadMoreTopic
{
    if (self.tableView.mj_footer != nil && [self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark - request
-(void)createRequest
{
//    if (page == 0 && self.dataSource.count) {
//        [self.dataSource removeAllObjects];
//    }
    page ++;
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork getNewsWithPage:@(page) response:^(id bean, NSError *error) {
        WOTNewsModel_msg *model = (WOTNewsModel_msg *)bean;
        if ([model.code isEqualToString:@"200"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_HUD removeFromSuperview];
                [weakSelf.dataSource addObjectsFromArray:model.msg.list];
                [self stoploadMoreTopic];
                [weakSelf.tableView reloadData];
            });
        }else if ([model.code isEqualToString:@"202"]) {
            self.notInformationView.hidden = NO;
            self.notInfoLabel.hidden = NO;
            [self stoploadMoreTopic];
            [_HUD removeFromSuperview];
            [MBProgressHUDUtil showMessage:@"没有更多数据" toView:self.view];
            return ;
        }
        else {
            self.notInformationView.hidden = NO;
            self.notInfoLabel.hidden = NO;
            [_HUD removeFromSuperview];
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
    }];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return section == 0 ? 10:0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WOTInformationLIstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTInformationLIstCellID"forIndexPath:indexPath];
    cell.infoValue.text = _dataSource[indexPath.row].messageInfo;
    cell.infoTime.text = _dataSource[indexPath.row].issueTime;
    [cell.infoImage setImageWithURL:[_dataSource[indexPath.row].pictureSite ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_activity"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTH5VC *detailvc = [WOTH5VC loadH5VC];
    detailvc.url = [_dataSource[indexPath.row].htmlLocation stringToUrl];
    detailvc.titleStr = _dataSource[indexPath.row].title;
    detailvc.infoStr = _dataSource[indexPath.row].messageInfo;
    [self.navigationController pushViewController:detailvc animated:YES];
}
//
-(void)getInfoDataFromWeb:(void(^)())complete{
    
//    [WOTHTTPNetwork getAllNewInformation:^(id bean, NSError *error) {
//        complete();
//        if (bean) {
//            WOTNewInformationModel_msg *dd = (WOTNewInformationModel_msg *)bean;
//            
//            [_dataSource addObject:dd.msg.space];
//            [_dataSource addObject:dd.msg.firm];
//        }
//        if (error) {
//            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
//        }
//        
//    }];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
