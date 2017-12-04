//
//  WOTSelectCityCodeVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSelectCityCodeVC.h"
#import "WOTLoginVC.h"
#import "WOTLoginNaviController.h"

@interface WOTSelectCityCodeVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *cityArr;
    NSArray *sectionIndexArr;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTSelectCityCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"选择国家/地区";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.table.sectionIndexColor = UIColorFromRGB(0x04afc8);
    self.table.sectionIndexBackgroundColor = [UIColor clearColor];
}
-(void)addData
{
    NSArray *dic = [WOTFileUitls readArrayPlistFileForFileName:@"CityCode"];
    cityArr= dic;
    
    sectionIndexArr = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H" , @"J", @"K", @"L", @"M", @"N" , @"P",  @"R", @"S", @"T", @"W", @"X", @"Y",@"Z"];
    //@"I"@"O"@"U"@"V"@"Q",
}

#pragma mark - table dataSoruce & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return cityArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = cityArr[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == cityArr.count-1) {
        return 15;
    }
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionIndexArr[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cityCell"];
    }
    NSArray *arr = cityArr[indexPath.section];
    NSArray *cityA =arr[indexPath.row];
    cell.textLabel.text = cityA.firstObject;
    cell.detailTextLabel.text = cityA.lastObject;
    return cell;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionIndexArr;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WOTLoginVC *vc = (WOTLoginVC*)[(WOTLoginNaviController *)self.navigationController getPreviousViewController];
    vc.cityName = cell.textLabel.text;
    vc.cityCode = cell.detailTextLabel.text;
    [self.navigationController popViewControllerAnimated:YES];
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
