//
//  SKReserveInfoTableViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKReserveInfoTableViewController.h"
#import "Masonry.h"
#import "WOTEnterEnterpriseNameVC.h"
#import "WOTDatePickerView.h"
#import "JudgmentTime.h"
#import "NSString+Category.h"
#import "WOTHTTPNetwork.h"

@interface SKReserveInfoTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSArray *leftNameArray;
@property(nonatomic,copy)NSArray *nameArray;
@property(nonatomic,copy)NSArray *applyForNameArray;
@property(nonatomic,strong)UIButton *orderButton;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString *telStr;
@property(nonatomic,copy)NSString *companyNameStr;
@property(nonatomic,copy)NSString *dateStr;
@property(nonatomic,copy)NSString *numStr;
@property(nonatomic,copy)NSString *remarkStr;
@property(nonatomic,strong)WOTDatePickerView *datepickerview;
@property(nonatomic,assign)BOOL isValidTime;
@property(nonatomic,strong)JudgmentTime *judgmentTime;
@property(nonatomic,copy)NSString *reservationDate;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,assign)NSInteger buttonHeight;
@end

@implementation SKReserveInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.typeInfo == TYPE_INFO_FACILITATOR) {
        self.title = @"填写信息";
        self.nameArray = @[@"姓名",@"联系方式",@"公司名称",@"预约日期",@"备注"];
    }else
    {
        self.title = @"预约信息";
        self.nameArray = @[@"姓名",@"联系方式",@"公司名称",@"预约日期",@"预约人数",@"备注"];
    }
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.sectionHeaderHeight = 5;
    //self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,0.0f,self.tableView.bounds.size.width,10.f)];
    [self.tableView setTableFooterView:[UIView new]];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.orderButton];
    if (self.enterInterfaceType == ENTER_INTERFACE_TYPE_SHOW) {
        self.contentArray = [[NSMutableArray alloc] init];
        [self.contentArray addObject:self.enterModel.contacts];
        [self.contentArray addObject:self.enterModel.tel];
        [self.contentArray addObject:self.enterModel.companyName];
        [self.contentArray addObject:[self.enterModel.appointmentTime substringToIndex:11]];
        [self.contentArray addObject:[NSString stringWithFormat:@"%@",self.enterModel.peopleNum]];
        [self.contentArray addObject:self.enterModel.remark];
        self.orderButton.hidden = YES;
        self.buttonHeight = 0;
    }else
    {
        self.orderButton.hidden = NO;
        self.buttonHeight = 40;
    }
    //[self layoutSubviews];
    self.judgmentTime = [[JudgmentTime alloc] init];
    [self creatDataPickerView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        //make.height.mas_offset(430);
        make.bottom.mas_equalTo(self.orderButton.mas_top);
    }];
    
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(30);
        make.right.mas_equalTo(self.view).with.offset(-30);
        make.bottom.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_offset(self.buttonHeight);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建时间选择器
-(void)creatDataPickerView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSString *selecTime = [NSString stringWithFormat:@"%04ld/%02ld/%02ld 00:00:00",year, month, day];
        weakSelf.isValidTime = [weakSelf.judgmentTime judgementTimeWithYear:year month:month day:day];
        
        if (weakSelf.isValidTime) {
            weakSelf.dateStr = selecTime;
            weakSelf.reservationDate = [selecTime substringToIndex:11];
            [weakSelf.tableView reloadData];
        }else
        {
            [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:weakSelf.view];
            weakSelf.datepickerview.hidden  = NO;
        }
        
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.nameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cityCell"];
    }
    cell.textLabel.text = self.nameArray[indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.enterInterfaceType == ENTER_INTERFACE_TYPE_EDIT) {
        if (indexPath.section == 0) {
            cell.detailTextLabel.text = self.nameStr;
            if (strIsEmpty(self.nameStr)) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        if (indexPath.section == 1) {
            cell.detailTextLabel.text = self.telStr;
            if (strIsEmpty(self.telStr)) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        if (indexPath.section == 2) {
            cell.detailTextLabel.text = self.companyNameStr;
            if (strIsEmpty(self.companyNameStr)) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        if (indexPath.section == 3) {
            cell.detailTextLabel.text = self.reservationDate;
            if (strIsEmpty(self.reservationDate)) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        if (indexPath.section == 4) {
            cell.detailTextLabel.text = self.numStr;
            if (strIsEmpty(self.numStr)) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        if (indexPath.section == 5) {
            cell.detailTextLabel.text = self.remarkStr;
            if (strIsEmpty(self.remarkStr)) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = self.contentArray[indexPath.section];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.enterInterfaceType == ENTER_INTERFACE_TYPE_EDIT) {
        __weak typeof(self) weakSelf = self;
        if (indexPath.section == 0) {
            WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
            vc.titleStr = @"输入名字";
            vc.noticeStr = @"";
            vc.isShow = NO;
            vc.enterpriseName = ^(NSString *enterpriseName) {
                weakSelf.nameStr = enterpriseName;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.section == 1) {
            WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
            vc.titleStr = @"输入电话号码";
            vc.noticeStr = @"";
            vc.isShow = NO;
            vc.enterpriseName = ^(NSString *enterpriseName) {
                weakSelf.telStr = enterpriseName;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.section == 2) {
            WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
            vc.titleStr = @"输入公司名字";
            vc.noticeStr = @"";
            vc.isShow = NO;
            vc.enterpriseName = ^(NSString *enterpriseName) {
                weakSelf.companyNameStr = enterpriseName;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.section == 3) {
            self.datepickerview.hidden = NO;
            //        WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
            //        vc.titleStr = @"输入人数";
            //        vc.noticeStr = @"";
            //        vc.isShow = NO;
            //        vc.enterpriseName = ^(NSString *enterpriseName) {
            //            weakSelf.numStr = enterpriseName;
            //            [weakSelf.tableView reloadData];
            //        };
            //        [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.section == 4) {
            WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
            vc.titleStr = @"输入人数";
            vc.noticeStr = @"";
            vc.isShow = NO;
            vc.enterpriseName = ^(NSString *enterpriseName) {
                weakSelf.numStr = enterpriseName;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.section == 5) {
            WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
            vc.titleStr = @"输入填写备注";
            vc.noticeStr = @"";
            vc.isShow = NO;
            vc.enterpriseName = ^(NSString *enterpriseName) {
                weakSelf.remarkStr = enterpriseName;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

#pragma mark - 获取服务支持
-(void)getServiceSupport
{
    if (strIsEmpty(self.nameStr)) {
        [MBProgressHUDUtil showMessage:@"请填写姓名" toView:self.view];
        return;
    }
    if (strIsEmpty(self.telStr)) {
        [MBProgressHUDUtil showMessage:@"请填写电话" toView:self.view];
        return;
    }
    if (strIsEmpty(self.companyNameStr)) {
        [MBProgressHUDUtil showMessage:@"请填写公司名字" toView:self.view];
        return;
    }
    if (strIsEmpty(self.dateStr)) {
        [MBProgressHUDUtil showMessage:@"请选择日期" toView:self.view];
        return;
    }

    if (strIsEmpty(self.numStr)) {
        self.numStr = @"";
    }
    
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"userName":self.nameStr,
                                 @"spaceId":[WOTUserSingleton shareUser].userInfo.spaceId,
                                 @"tel":self.telStr,
                                 @"facilitatorId":self.facilitatorModel.facilitatorId,
                                 @"firmName":self.facilitatorModel.firmName,
                                 @"dealState":@"未处理",
                                 @"needType":@"服务商",
                                 @"companyName":self.companyNameStr,
                                 @"appointmentTime":self.dateStr,
                                 @"remark":self.numStr
                                 };
    [WOTHTTPNetwork obtainSupportWithParams:parameters response:^(id bean, NSError *error) {
        WOTBaseModel *model = (WOTBaseModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"申请成功，我们将安排服务人员尽快与您联系！" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
        else
        {
            [MBProgressHUDUtil showMessage:@"申请失败！" toView:self.view];
        }
    }];
}

#pragma mark - 预约入驻接口
-(void)applyForEnter
{
    if (strIsEmpty(self.nameStr)) {
        [MBProgressHUDUtil showMessage:@"请填写姓名" toView:self.view];
        return;
    }
    if (strIsEmpty(self.telStr)) {
        [MBProgressHUDUtil showMessage:@"请填写电话" toView:self.view];
        return;
    }
    if (strIsEmpty(self.companyNameStr)) {
        [MBProgressHUDUtil showMessage:@"请填写公司名字" toView:self.view];
        return;
    }
    if (strIsEmpty(self.dateStr)) {
        [MBProgressHUDUtil showMessage:@"请选择日期" toView:self.view];
        return;
    }
    if (strIsEmpty(self.numStr)) {
        [MBProgressHUDUtil showMessage:@"请填写预约人数" toView:self.view];
        return;
    }
    if (strIsEmpty(self.remarkStr)) {
        self.remarkStr = @"";
    }
    [WOTHTTPNetwork appointmentSettledWithSpaceId:self.spaceModel.spaceId
                                              tel:self.telStr
                                  appointmentTime:self.dateStr
                                        peopleNum:@([self.numStr integerValue])
                                           remark:self.remarkStr
                                      companyName:self.companyNameStr
                                         contacts:self.nameStr
                                        spaceName:self.spaceModel.spaceName
                                         response:^(id bean, NSError *error) {
                                             
                                             WOTBaseModel *model = bean;
                                             if ([model.code isEqualToString:@"200"]) {
                                                 [MBProgressHUDUtil showMessage:@"提交成功" toView:self.view];
                                                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                     [self.navigationController popToRootViewControllerAnimated:YES];
                                                 });
                                             }else
                                             {
                                                 [MBProgressHUDUtil showMessage:@"提交失败" toView:self.view];
                                             }
                                         }];
    
}

-(UIButton *)orderButton
{
    if (_orderButton == nil) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.typeInfo == TYPE_INFO_FACILITATOR) {
            [_orderButton setTitle:@"提交" forState:UIControlStateNormal];
             [_orderButton addTarget:self action:@selector(getServiceSupport) forControlEvents:UIControlEventTouchDown];
        }
        else
        {
            [_orderButton setTitle:@"预约入驻" forState:UIControlStateNormal];
             [_orderButton addTarget:self action:@selector(applyForEnter) forControlEvents:UIControlEventTouchDown];
        }
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        _orderButton.backgroundColor = UICOLOR_MAIN_ORANGE;
        _orderButton.layer.cornerRadius = 5.f;
        _orderButton.layer.borderWidth = 1.f;
        _orderButton.layer.borderColor = UICOLOR_MAIN_ORANGE.CGColor;
    }
    return _orderButton;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _datepickerview.hidden = YES;
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
