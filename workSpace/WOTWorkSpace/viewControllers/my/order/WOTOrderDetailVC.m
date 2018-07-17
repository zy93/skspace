//
//  WOTOrderDetailVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/12.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderDetailVC.h"
#import "WOTOrderDetailCell.h"
#import "WOTSpaceModel.h"
#import "WOTMeetingFacilityModel.h"

@interface WOTOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * tableList;
@property (nonatomic, strong) NSMutableArray * tableValueList;
@property (nonatomic, strong) WOTSpaceModel * spaceModel;

@end

@implementation WOTOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"WOTOrderDetailCell"];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatRequest
{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSArray *arr = @[@"8:00-20:00",];
//        self.tableValueList replaceObjectAtIndex:<#(NSUInteger)#> withObject:<#(nonnull id)#>
//        [self.tableView reloadData];
//    });
}

-(void)loadData
{
    self.tableList = [@[@[@"订单编号"],@[@"预订人", @"联系方式"],@[@"下单时间"]] mutableCopy];
    self.tableValueList = [@[@[self.model.orderNum],@[self.model.userName, self.model.userTel],@[self.model.orderTime]]  mutableCopy];
    
    
    if ([self.model.commodityKind isEqualToString:@"会议室"]) {
        [self.tableList insertObject:@[@"预定会议室", @"预定时间"] atIndex:1];
        [self.tableValueList insertObject:@[[NSString stringWithFormat:@"%@·%@",self.model.spaceName,self.model.commodityName], [NSString stringWithFormat:@"%@\n%@",[self.model.starTime substringToIndex:16],[self.model.endTime substringToIndex:16]]] atIndex:1];

    }
    else if ([self.model.commodityKind isEqualToString:@"场地"]) {
        [self.tableList insertObject:@[@"预定场地", @"预定时间"] atIndex:1];
        [self.tableValueList insertObject:@[[NSString stringWithFormat:@"%@·%@",self.model.spaceName,self.model.commodityName], [NSString stringWithFormat:@"%@\n%@",[self.model.starTime substringToIndex:16],[self.model.endTime substringToIndex:16]]] atIndex:1];
    }
    else if ([self.model.commodityKind isEqualToString:@"工位"]) {
        [self.tableList insertObject:@[@"预定空间", @"预定时间"] atIndex:1];

        [self.tableValueList insertObject:@[[NSString stringWithFormat:@"%@·%@",self.model.spaceName,self.model.commodityName], [NSString stringWithFormat:@"%@\n%@",[self.model.starTime substringToIndex:11],[self.model.endTime substringToIndex:11]]] atIndex:1];
    }
    else if ([self.model.commodityKind isEqualToString:@"长租工位"])
    {
        [self.tableList insertObject:@[@"预定房间", @"预定时间",@"预定价格"] atIndex:1];
        
        [self.tableValueList insertObject:@[self.model.commodityName,self.model.commodityNumList,[NSString stringWithFormat:@"%@",self.model.money]] atIndex:1];
    }
    else  {
        [self.tableList insertObject:@[@"礼包名称"] atIndex:1];
        [self.tableValueList insertObject:@[self.model.commodityName] atIndex:1];

    }
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)self.tableList[section]).count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTOrderDetailCell"];
    NSArray *arr = self.tableList[indexPath.section];
    NSArray *valueArr = self.tableValueList[indexPath.section];
    cell.titleLab.text = arr[indexPath.row];
    cell.subtitleLab.text = valueArr[indexPath.row];
    
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
