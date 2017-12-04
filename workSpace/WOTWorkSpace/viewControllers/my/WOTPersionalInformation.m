
//  WOTPersionalInformation.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTPersionalInformation.h"
#import "WOTPersionalInformationCommonCell.h"
#import "WOTPersionalInformationTagCell.h"
@interface WOTPersionalInformation ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WOTPersionalInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
  
    self.tableView.backgroundColor = CLEARCOLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self configNav];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTPersionalInformationCommonCell" bundle:nil] forCellReuseIdentifier:@"WOTPersionalInformationCommonCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTPersionalInformationTagCell" bundle:nil] forCellReuseIdentifier:@"WOTPersionalInformationTagCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)configNav{
    [self configNaviBackItem];
    self.navigationItem.title = @"个人资料";
}

//MARK:tableView datasource   delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.01;
    } else {
        return  12.5;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return 75;
            } else {
                return 50;
            }
            break;
        case 1:
            if (indexPath.row == 0 || indexPath.row == 1) {
                return 100;
            }else {
                return 50;
            }
        default:
            break;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 4;
        default:
            break;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell;
    if (indexPath.section == 0) {
        WOTPersionalInformationCommonCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"WOTPersionalInformationCommonCellID" forIndexPath:indexPath];
        NSArray *titleArray = @[@"头像",@"姓名",@"性别",@"星座",@"收获地址"];
        //[[WOTUserSingleton shareUser] setValues];
        //崩溃
       // NSLog(@"测试：%@",[WOTUserSingleton shareUser].userInfo);
        NSArray *valueArray = @[[WOTUserSingleton shareUser].userInfo.headPortrait,
                                [WOTUserSingleton shareUser].userInfo.userName,
                                [WOTUserSingleton shareUser].userInfo.sex,
                                [WOTUserSingleton shareUser].userInfo.constellation,
                                [WOTUserSingleton shareUser].userInfo.site];
        //NSLog(@"测试：%@",valueArray);
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.valueLabel.text = valueArray[indexPath.row];
        if (indexPath.row == 0){
            
            [cell.valueImage sd_setImageWithURL:[[WOTUserSingleton shareUser].userInfo.headPortrait ToUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
        } else if (indexPath.row == 2) {
            
            [cell.valueImage sd_setImageWithURL:[@"" ToUrl] placeholderImage:[[WOTUserSingleton shareUser].userInfo.sex isEqualToString:@"man"] ? [UIImage imageNamed:@"boy_blue"]:[UIImage imageNamed:@"girl_blue"]];
        }
        
        cell.imageWidth.constant = indexPath.row==0 ? 50:60;
        cell.imageHeight.constant = indexPath.row==0 ? 50:18;
        if (indexPath.row == 0 || indexPath.row == 2) {
            [cell.valueLabel setHidden:YES];
            [cell.valueImage setHidden:NO];
           
            
            
        } else {
            [cell.valueLabel setHidden:NO];
            [cell.valueImage setHidden:YES];
        }
        if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
            [cell.lineView setHidden:YES];
        }
        commoncell = cell;
    } else if (indexPath.section == 1){
        NSArray *titleArray = @[@"技    能",@"兴    趣",@"行业",@"个性签名"];
        NSArray *valueArray = @[@"",@"",
                                [WOTUserSingleton shareUser].userInfo.industry,
                                [WOTUserSingleton shareUser].userInfo.spared1];
        if (indexPath.row == 0|| indexPath.row == 1) {
            
            WOTPersionalInformationTagCell *tagcell = [tableView dequeueReusableCellWithIdentifier:@"WOTPersionalInformationTagCellID" forIndexPath:indexPath];
            tagcell.titleLabel.text = titleArray[indexPath.row];
            tagcell.tagLabelArray = indexPath.row == 0? @[@"移动开发",@"移动测试"]: @[@"美食",@"摄影",@"绘画",@"插画"];
            [[WOTConfigThemeUitls shared] loadtagsBtn:tagcell.tagLabelArray superView:tagcell.tagsVIew];
            commoncell = tagcell;
            
        } else {
            WOTPersionalInformationCommonCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"WOTPersionalInformationCommonCellID" forIndexPath:indexPath];
                [cell.valueLabel setHidden:NO];
                [cell.valueImage setHidden:YES];
            cell.titleLabel.text = titleArray[indexPath.row];
            cell.valueLabel.text = valueArray[indexPath.row];
            commoncell = cell;
            if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
                [cell.lineView setHidden:YES];
            }
        }
    }
    return commoncell;
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
