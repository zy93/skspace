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


@end

@implementation WOTInformationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.tableView.backgroundColor = CLEARCOLOR;
    [self configNav];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTInformationLIstCell" bundle:nil] forCellReuseIdentifier:@"WOTInformationLIstCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTCommonHeaderVIew" bundle:nil] forHeaderFooterViewReuseIdentifier:@"WOTCommonHeaderVIewID"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}
-(void)configNav{
    [self configNaviBackItem];  
    self.navigationItem.title = @"我的资讯";
}
-(NSMutableArray<NSArray<WOTNewInformationModel *> *>*)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return _dataSource[0].count;
            break;
        case 1:
            return _dataSource[1].count;
            break;
        default:
            break;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WOTCommonHeaderVIew *view = [[NSBundle mainBundle]loadNibNamed:@"WOTCommonHeaderVIew" owner:nil options:nil].lastObject;
    if (section == 0) {
        view.headerTitle.text = @"空间资讯";
    } else {
        view.headerTitle.text = @"企业资讯";
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return section == 0 ? 10:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WOTInformationLIstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTInformationLIstCellID"forIndexPath:indexPath];
    cell.infoValue.text = _dataSource[indexPath.section][indexPath.row].messageInfo;
    cell.infoTime.text = _dataSource[indexPath.section][indexPath.row].issueTime;
    NSString *urlstring = [_dataSource[indexPath.section][indexPath.row].pictureSite separatedWithString:@","].count != 0? [_dataSource[indexPath.section][indexPath.row].pictureSite separatedWithString:@","][0]:@"";
    [cell.infoImage sd_setImageWithURL:[urlstring ToUrl] placeholderImage:[UIImage imageNamed:@"infoImage"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTH5VC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
       //detailvc.url = [NSString stringWithFormat:@"%@%@",@"http://",_dataSource[indexPath.section][indexPath.row].spared3];

    [self.navigationController pushViewController:detailvc animated:YES];
}
//
-(void)getInfoDataFromWeb:(void(^)())complete{
    
    [WOTHTTPNetwork getAllNewInformation:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTNewInformationModel_msg *dd = (WOTNewInformationModel_msg *)bean;
            
            [_dataSource addObject:dd.msg.space];
            [_dataSource addObject:dd.msg.firm];
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
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
