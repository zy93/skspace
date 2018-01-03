//
//  WOTSearchMemberVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/27.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSearchMemberVC.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"
#import "WOTBaseDefaultStyleCell.h"
#import "WOTLoginModel.h"

@interface WOTSearchMemberVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *cannotFindLab;


@property (nonatomic, strong) NSArray <WOTLoginModel *>*tableList;


@end

@implementation WOTSearchMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //search bar
    self.navigationItem.title = @"查找访问对象";
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    [self.searchBar setBackgroundColor:[UIColor clearColor]];
    [self.searchBar setBackgroundImage:searchBarBg];
    UITextField *textField = [self.searchBar valueForKey:@"_searchField"];
    [textField.layer setCornerRadius:2.f];
    [textField setBackgroundColor:UIColorFromRGB(0xf0f3f5)];
    [self.searchBar changeLeftPlaceholder:@" 请输入姓名"];
    
    //table
    [self.table registerNib:[UINib nibWithNibName:@"WOTBaseDefaultStyleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WOTBaseDefaultStyleCell"];
}


#pragma mark 实现搜索条背景透明化
- (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action
- (IBAction)searchBtn:(id)sender {
    if (strIsEmpty(self.searchBar.text)) {
        [MBProgressHUDUtil showMessage:@"请输入会员名" toView:self.view];
        return;
    }
    [self createRequest];
}

-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    
    [WOTHTTPNetwork searchMemberWithName:self.searchBar.text spaceId:self.spaceId response:^(id bean, NSError *error)
    {
        if (!error) {
            WOTSearchModel_model *model = (WOTSearchModel_model*)bean;
            if ([model.code isEqualToString:@"200"]) {
                weakSelf.tableList = model.msg.list;
                weakSelf.table.hidden = NO;
                weakSelf.cannotFindLab.hidden = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.table reloadData];
                });
            }
            else if ([model.code isEqualToString:@"202"]) {
                weakSelf.table.hidden = YES;
                weakSelf.cannotFindLab.hidden = NO;
            }
        }
    }];
}



#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTBaseDefaultStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTBaseDefaultStyleCell"];
    WOTLoginModel *model = self.tableList[indexPath.row];
    [cell.iconIV setImageWithURL:[model.headPortrait ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placehoder_comm"]];
    cell.titleLab.text = model.userName;
    cell.subtitleLab.text = model.companyName;
    cell.arrowIV.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectMemberBlock) {
        self.selectMemberBlock(self.tableList[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
