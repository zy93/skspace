//
//  WOTEnterEnterpriseNameVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterEnterpriseNameVC.h"
#import "WOTEnterpriseIntroduceVC.h"


@interface WOTEnterEnterpriseNameVC () <WOTEnterCellDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic ,strong) NSString *name;
@end

@implementation WOTEnterEnterpriseNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"输入企业名称";
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTEnterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTEnterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTMyEnterPriseCell"];
    [self configNaviRightItemWithTitle:@"保存" textColor:[UIColor blackColor]];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardHide:) name: UIKeyboardDidHideNotification object:nil];
    
}

//#pragma mark - 键盘关闭函数
//-(void)keyboardHide:(NSNotification *)notif
//{
//    [self resignTheFirstResponder];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(void)rightItemAction{
    //跳转页面
    if (self.enterpriseName) {
        self.enterpriseName(self.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - cell delegate
-(void)enterCell:(WOTEnterCell *)cell textDidChange:(NSString *)searchText
{
    self.name = searchText;
    if (strIsEmpty(searchText)) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork searchEnterprisesWithName:searchText response:^(id bean, NSError *error) {
        WOTEnterpriseModel_msg *model = (WOTEnterpriseModel_msg *)bean;
        if (weakSelf.tableList.count>=2) {
            [weakSelf.tableList removeObjectAtIndex:1];
        }
        if ([model.code isEqualToString:@"200"]) {
            [weakSelf.tableList addObject:model.msg.list];
            [weakSelf.tableView reloadData];
        }
    }];
}

//- (void)resignTheFirstResponder {
//    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//    [firstResponder resignFirstResponder];
//}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr= self.tableList[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return  0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
        [lab setFont:[UIFont systemFontOfSize:12]];
        [lab setTextColor:UIColorFromRGB(0x999999)];
        lab.text = @"公司名称不能是已存在的哦！";
        [view addSubview:lab];
        return view;
    }
    else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
        [lab setFont:[UIFont systemFontOfSize:12]];
        [lab setTextColor:UIColorFromRGB(0x999999)];
        lab.text = @"没有更多的公司了！";
        [view addSubview:lab];
        return view;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WOTEnterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTEnterCell"];
        cell.textField.placeholder = @"请输入公司名称";
        cell.delegate = self;
        [cell.textField becomeFirstResponder];
        return cell;
    }
    else {
        
        WOTMyEnterPriseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTMyEnterPriseCell"];
        NSArray *modelList= self.tableList[indexPath.section];
        WOTEnterpriseModel *model = modelList[indexPath.row];
        [cell.enterpriseHeaderImage setImageWithURL:[model.companyPicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
        cell.enterpariseName.text = model.companyName;
        cell.joinEnterpriseTime.text = model.companyType;
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        WOTEnterpriseIntroduceVC *vc = [[WOTEnterpriseIntroduceVC alloc] init];
        vc.model = self.tableList[indexPath.section][indexPath.row];
        vc.vcType = INTRODUCE_VC_TYPE_Enterprise;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - load
-(NSMutableArray *)tableList
{
    if (!_tableList) {
        _tableList = [NSMutableArray new];
        [_tableList addObject:@[@"请输入企业名称"]];
    }
    return _tableList;
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
