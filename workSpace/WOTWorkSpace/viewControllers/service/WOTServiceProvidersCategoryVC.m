//
//  WOTServiceProvidersCategoryVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTServiceProvidersCategoryVC.h"
#import "WOTGETServiceViewController.h"

#import "WOTServiceProvidersCell.h"
#import "WOTServiceProvidersCategoryCell.h"
#import "WOTServiceCategoryModel.h"

@interface WOTServiceProvidersCategoryVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *table1Dict;
    NSArray *table2List;
    NSString *selectService;
    NSMutableArray *selectServiceCategoryList;
}
@property (weak, nonatomic) IBOutlet UITableView *table1;
@property (weak, nonatomic) IBOutlet UITableView *table2;


@end

@implementation WOTServiceProvidersCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self getServiceStyleData];
//    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"选择服务商类别";
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectDoneAction)];
    
    [self.navigationItem setRightBarButtonItem:doneItem];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}



#pragma mark - action
-(void)selectDoneAction
{
   UIViewController *previousVC = [(WOTServiceNaviController*)self.navigationController getPreviousViewController];
    ((WOTGETServiceViewController *)previousVC).selectServiceList = selectServiceCategoryList;
    if (_selectServiceBlock) {
        self.selectServiceBlock(selectServiceCategoryList);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - table delegate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.table1]) {
        return table1Dict.count;
    }
    else {
        return table2List.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([tableView isEqual:self.table1]) {
        WOTServiceProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTServiceProvidersCell"];
        if (cell == nil) {
            cell = [[WOTServiceProvidersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTServiceProvidersCell"];
        }
        NSArray *arr = [table1Dict allKeys];
        [cell.titleLab setText:arr[indexPath.row]];
        if (indexPath.row==0) {
            selectService = arr[indexPath.row];
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        return  cell;
    }
    else {
        WOTServiceProvidersCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTServiceProvidersCategoryCell"];
        if (cell == nil) {
            cell = [[WOTServiceProvidersCategoryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTServiceProvidersCategoryCell"];
        }
        
        [cell.selectImg setHidden:YES];
        for (NSString *str in selectServiceCategoryList) {
            if ([str containsString:table2List[indexPath.row]]) {
                [cell.selectImg setHidden:NO];
                break;
            }
        }
        
        [cell.titleLab setText:table2List[indexPath.row]];
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.table1]) {
        WOTServiceProvidersCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        table2List = table1Dict[cell.titleLab.text];
        selectService = cell.titleLab.text;
        [self.table2 reloadData];
    }
    else {
       
       
        if (selectServiceCategoryList.count>=6) {
            [MBProgressHUDUtil showMessage:ServiceTypeNumLimitReminding toView:self.view];
        } else {
            
            WOTServiceProvidersCategoryCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            for (NSString *str in selectServiceCategoryList) {
                if ([str containsString:table2List[indexPath.row]]) {
                    [cell.selectImg setHidden:YES];
                    [selectServiceCategoryList removeObject:str];
                    return;
                }
            }
            [cell.selectImg setHidden:NO];
            [selectServiceCategoryList addObject:[NSString stringWithFormat:@"%@-%@",selectService,table2List[indexPath.row]]];
        }
        
    }
}
//从plist文件中读取服务商信息
-(void)loadData
{
    NSDictionary *dic = [WOTFileUitls readPlistFileForFileName:@"ServiceCategory"];
    selectServiceCategoryList = [[NSMutableArray alloc] init];
    table1Dict = dic;
    table2List = dic[[dic allKeys].firstObject];
    self.table2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table1 reloadData];
    [self.table2 reloadData];
}


//从服务器读取服务商类型
-(void)getServiceStyleData{
    [WOTHTTPNetwork getAllServiceTypes:^(id bean, NSError *error) {
        
        WOTServiceCategoryModel_msg * category = (WOTServiceCategoryModel_msg *)bean;
        
//        NSDictionary *dic = [WOTFileUitls readPlistFileForFileName:@"ServiceCategory"];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        for (WOTServiceCategoryModel_mm *mm in category.msg) {
            NSMutableArray * mmarray = [[NSMutableArray alloc]init];
            for (WOTServiceCategoryModel *dd in mm.classifySubclass) {
                [mmarray addObject:dd.classifySubclass];
            }
            [dic setObject:mmarray forKey:mm.labelClassify];
        }
        
        selectServiceCategoryList = [[NSMutableArray alloc] init];
        table1Dict = dic;
        table2List = dic[[dic allKeys].firstObject];
        self.table2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.table1 reloadData];
        [self.table2 reloadData];
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
