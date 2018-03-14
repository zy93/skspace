//
//  WOTRepairdHistoryDetailVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/13.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTRepairdHistoryDetailVC.h"
#import "WOTMyRepairdDetailCell.h"

@interface WOTRepairdHistoryDetailVC () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation WOTRepairdHistoryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报修详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyRepairdDetailCell" bundle:nil] forCellReuseIdentifier:@"WOTMyRepairdDetailCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTMyRepairdDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyRepairdDetailCell" forIndexPath:indexPath];
    cell.timeValueLab.text = [self.model.sorderTime substringToIndex:16];
    cell.addrValueLab.text = self.model.address;
    cell.contentValueLab.text = self.model.info;
    cell.typeValueLab.text = self.model.type;
    cell.pictureStr = self.model.pictureOne;
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
