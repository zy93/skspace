//
//  WOTEnterpriseConnectsInfoVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseContactsInfoVC.h"
#import "WOTTitleAndEnterCell.h"

@interface WOTEnterpriseContactsInfoVC () <UITableViewDelegate, UITableViewDataSource, WOTTitleAndEnterCellDelegate>
{
    NSArray *tableList;
    NSArray *tableSubList;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *email;
@end

@implementation WOTEnterpriseContactsInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"联系人信息";
    [self configNaviRightItemWithTitle:@"保存" textColor:[UIColor blackColor]];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTTitleAndEnterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTTitleAndEnterCell"];
    tableList = @[@"联系人姓名", @"联系电话", @"联系邮箱"];
    tableSubList = @[@"请输入企业联系人姓名", @"请输入联系电话", @"请输入联系邮箱"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(void)rightItemAction{
    
    if (strIsEmpty(self.name) || strIsEmpty(self.tel) || strIsEmpty(self.email)) {
        return;
    }
    
    //跳转页面
    if (self.contactsBlock) {
        self.contactsBlock(self.name, self.tel, self.email);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - cell delegate
-(void)enterCell:(WOTTitleAndEnterCell *)cell didEnterText:(NSString *)text
{
    if ([cell.titleLab.text isEqualToString:tableList[0]]) {
        self.name = text;
    }
    else if ([cell.titleLab.text isEqualToString:tableList[1]]) {
        self.tel = text;
    }
    else  {
        self.email = text;
    }
    
}

#pragma mark - table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTTitleAndEnterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTTitleAndEnterCell"];
    cell.titleLab.text = tableList[indexPath.row];
    cell.textField.placeholder = tableSubList[indexPath.row];
    cell.delegate = self;
    if (indexPath.row == tableList.count-1) {
        cell.lineView.hidden = YES;
    }
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
