//
//  WOTMyPublishDemandsLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyPublishDemandsLIstVC.h"
#import "WOTFeedBackLIstCell.h"
#import "WOTMyHistoryDemandsModel.h"
@interface WOTMyPublishDemandsLIstVC (){
    NSArray<WOTMyHistoryDemandsModel *> *dataSource;
}

@end

@implementation WOTMyPublishDemandsLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerNib:[UINib nibWithNibName:@"WOTFeedBackLIstCell" bundle:nil] forCellReuseIdentifier:@"WOTFeedBackLIstCellID"];
    [self getHistoryDemandsFromWeb];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat leading = 10;
    CGFloat top  = 0;
    
    for (NSString *title in dataSource[indexPath.row].facilitatorLabel) {
        leading += [title widthWithFont:[UIFont systemFontOfSize:15]]+15;
        
        if (leading+[title widthWithFont:[UIFont systemFontOfSize:15]]+20>=tableView.frame.size.width) {
            top += 30+10;
            leading = 10;
        }
    }
    return top+100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTFeedBackLIstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTFeedBackLIstCellID" forIndexPath:indexPath];
    cell.state.hidden = YES;
    cell.time.text = dataSource[indexPath.row].time;
    cell.content.text = dataSource[indexPath.row].describe;
    
    cell.tagLabelArray = dataSource[indexPath.row].facilitatorLabel;
    [[WOTConfigThemeUitls shared] loadtagsBtn:cell.tagLabelArray superView:cell.tagsView];
    return cell;
    
}

-(void)getHistoryDemandsFromWeb{
//    [[WOTUserSingleton shareUser]setValues];
    [WOTHTTPNetwork getDemandsWithUserId:[NSNumber numberWithInt:[[WOTUserSingleton shareUser].userInfo.userId intValue]] response:^(id bean, NSError *error) {
        WOTMyHistoryDemandsModel_msg *dd = (WOTMyHistoryDemandsModel_msg *)bean;
        dataSource = dd.msg;
        [self.tableView reloadData];
    }];
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
