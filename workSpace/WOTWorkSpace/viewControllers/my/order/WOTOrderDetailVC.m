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
#import "SKPrintBillInfoVC.h"
#import "UIColor+ColorChange.h"
#import "JudgmentTime.h"

@interface WOTOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * tableList;
@property (nonatomic, strong) NSMutableArray * tableValueList;
@property (nonatomic, strong) WOTSpaceModel * spaceModel;

/* */
@property (nonatomic,strong) UIButton *cancleButton;

@end

@implementation WOTOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderDetailCell" bundle:nil] forCellReuseIdentifier:@"WOTOrderDetailCell"];
    [self loadData];
    NSString *newTime = [NSString stringWithFormat:@"%@",[NSDate getNewTime]];
    JudgmentTime *time = [[JudgmentTime alloc] init];
    BOOL isShow = [time compareDate:self.model.starTime withDate:newTime];
    BOOL isOrder;
    if ([self.model.commodityKind isEqualToString:@"工位"] || [self.model.commodityKind isEqualToString:@"会议室"]) {
        isOrder = YES;
    }else
    {
        isOrder = NO;
    }
    if (isOrder && isShow) {
        self.cancleButton.hidden = NO;
    }else
    {
        self.cancleButton.hidden = YES;
    }
    
    
    [self.view addSubview:self.cancleButton];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutSubviews
{
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.height.mas_offset(48);
    }];
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
    //self.tableList = [@[@[@"订单编号"],@[@"预订人", @"联系方式"],@[@"下单时间"]] mutableCopy];
    self.tableList = [[NSMutableArray alloc] init];
    [self.tableList addObject:@[@"订单编号"]];
    [self.tableList addObject:@[@"预订人", @"联系方式"]];
    [self.tableList addObject:@[@"下单时间"]];
    [self.tableList addObject:@[@"订单状态"]];
    NSString *orderStateStr ;
    if ([self.model.orderState isEqualToString:@"SUCCESS"]) {
        orderStateStr = @"支付成功";
    } else {
        orderStateStr = @"未支付";
    }
    self.tableValueList = [@[@[self.model.orderNum],@[self.model.userName, self.model.userTel],@[self.model.orderTime],@[orderStateStr]]  mutableCopy];
    
    
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
        //[self.tableList insertObject:@"开票状态" atIndex:7];
        [self.tableList addObject:@[@"开票状态"]];
        [self.tableValueList insertObject:@[self.model.commodityName,self.model.commodityNumList,[NSString stringWithFormat:@"%@",self.model.money]] atIndex:1];
        [self.tableValueList addObject:@[self.model.invoiceState]];
    }
    else  {
        [self.tableList insertObject:@[@"礼包名称"] atIndex:1];
        [self.tableList addObject:@[@"开票状态"]];
        [self.tableValueList insertObject:@[self.model.commodityName] atIndex:1];
        [self.tableValueList addObject:@[self.model.invoiceState]];
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
    [cell.printBillButton addTarget:self action:@selector(printBillBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cell.titleLab.text = arr[indexPath.row];
    cell.subtitleLab.text = valueArr[indexPath.row];
    
    if ([self.model.commodityKind isEqualToString:@"长租工位"] && (indexPath.section == 5) && [self.model.orderState isEqualToString:@"SUCCESS"]) {
        cell.printBillButton.hidden = NO;
        if ([self.model.invoiceState isEqualToString:@"未开"] || self.model.invoiceState == nil) {
            [cell.printBillButton setTitle:@"申请发票" forState:UIControlStateNormal];
        }else
        {
            [cell.printBillButton setTitle:@"查看发票" forState:UIControlStateNormal];
        }
    }
    
    if ([self.model.commodityKind isEqualToString:@"礼包"] && (indexPath.section == 5)&& [self.model.orderState isEqualToString:@"SUCCESS"]) {
        cell.printBillButton.hidden = NO;
        if ([self.model.invoiceState isEqualToString:@"未开"] || self.model.invoiceState == nil) {
            [cell.printBillButton setTitle:@"申请发票" forState:UIControlStateNormal];
        }else
        {
            [cell.printBillButton setTitle:@"查看发票" forState:UIControlStateNormal];
        }
    }
    
    return cell;
}

#pragma mark - 申请开票
-(void)printBillBtnAction
{
    SKPrintBillInfoVC *printBillVC = [[SKPrintBillInfoVC alloc] init];
    printBillVC.printBillState = self.model.invoiceState;
    printBillVC.model = self.model;
    [self.navigationController pushViewController:printBillVC animated:YES];
    
}

#pragma mark - 取消订单
-(void)cancleBtnAction
{
    NSDictionary *parmDic = @{@"orderNum":self.model.orderNum,
                              @"orderCancel":@"申请取消"};
    [WOTHTTPNetwork cancelOrder:parmDic response:^(id bean, NSError *error) {
        WOTBaseModel *model = (WOTBaseModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"提交成功！" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else
        {
            [MBProgressHUDUtil showMessage:@"提交失败！" toView:self.view];
            return ;
        }
    }];

}

-(UIButton *)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([self.model.orderCancel isEqualToString:@"正常"]) {
            [_cancleButton setTitle:@"取消订单" forState:UIControlStateNormal];
        }
        
        if ([self.model.orderCancel isEqualToString:@"申请取消"] || self.model.orderCancel == nil) {
            _cancleButton.alpha = 0.4;
            _cancleButton.enabled = NO;
            [_cancleButton setTitle:@"处理中" forState:UIControlStateNormal];
        }
        
        if ([self.model.orderCancel isEqualToString:@"已取消订单"]) {
            _cancleButton.alpha = 0.4;
            _cancleButton.enabled = NO;
            [_cancleButton setTitle:@"已取消" forState:UIControlStateNormal];
        }
        
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.backgroundColor = [UIColor colorWithHexString:@"ff7f3d"];
        _cancleButton.layer.cornerRadius = 5.f;
        _cancleButton.layer.borderWidth = 1.f;
        _cancleButton.layer.borderColor =[UIColor colorWithHexString:@"ff7f3d"].CGColor;
    }
    return _cancleButton;
}
@end
