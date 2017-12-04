//
//  WOTMyFeedbackLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/5.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyFeedbackLIstVC.h"
#import "WOTFeedBackLIstCell.h"
#import "WOTMyFeedBackModel.h"
#import "WOTEnumUtils.h"
#import "WOTEnums.h"
@interface WOTMyFeedbackLIstVC ()
@property (nonatomic,strong)NSArray<WOTMyFeedBackModel *> *dataSource;
@end

@implementation WOTMyFeedbackLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromWeb];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTFeedBackLIstCell" bundle:nil] forCellReuseIdentifier:@"WOTFeedBackLIstCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray<WOTMyFeedBackModel *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSArray alloc]init];
    }
    return _dataSource;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTFeedBackLIstCell *feedbackcell = [tableView dequeueReusableCellWithIdentifier:@"WOTFeedBackLIstCellID" forIndexPath:indexPath];
    feedbackcell.time.text = _dataSource[indexPath.row].time;
    feedbackcell.content.text = _dataSource[indexPath.row].opinionContent;
    feedbackcell.state.text = [[[WOTEnumUtils alloc]init] WOTFeedBackStateToString:[_dataSource[indexPath.row].opinionState integerValue]];
    
    return feedbackcell;
    
}

-(void)getDataFromWeb{

    
//    [[WOTUserSingleton shareUser] setValues];
    [WOTHTTPNetwork getMyHistoryFeedBackData:[[NSNumber alloc]initWithInt:[[WOTUserSingleton shareUser].userInfo.userId intValue]] response:^(id bean, NSError *error) {
        
        WOTMyFeedBackModel_msg *dd = (WOTMyFeedBackModel_msg *)bean;
        _dataSource = dd.msg;
        [self.tableView reloadData];
    } ];
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
