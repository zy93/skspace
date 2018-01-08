//
//  WOTEnterpriseLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTEnterpriseLIstVC.h"
#import "WOTEnterpriseListSytle2Cell.h"
#import "WOTSingtleton.h"
#import "WOTEnterpriseModel.h"

@interface WOTEnterpriseLIstVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray <WOTEnterpriseModel *> *tableList;


@end

@implementation WOTEnterpriseLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];   
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTEnterpriseListSytle2Cell" bundle:nil] forCellReuseIdentifier:@"WOTEnterpriseListSytle2Cell"];
    self.tableView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self createRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createRequest
{
    
    [WOTHTTPNetwork getEnterprisesWithSpaceId:[WOTSingtleton shared].nearbySpace.spaceId response:^(id bean, NSError *error) {
        WOTEnterpriseModel_msg *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            self.tableList = model.msg.list;
            [self.tableView reloadData];
        }
    }];
    
}


#pragma mark - table delgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.tableList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return  125;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTEnterpriseListSytle2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTEnterpriseListSytle2Cell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
