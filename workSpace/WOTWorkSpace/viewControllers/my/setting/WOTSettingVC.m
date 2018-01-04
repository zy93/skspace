//
//  WOTSettingVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSettingVC.h"
#import "WOTSettingCell.h"
#import "WOTLoginVC.h"
#import "WOTPersionalInformation.h"
@interface WOTSettingVC ()

@end

@implementation WOTSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTSettingCell" bundle:nil] forCellReuseIdentifier:@"settingCellID"];
    self.navigationItem.title = @"设置";
    
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
        //return 3;
    if ([WOTSingtleton shared].isuserLogin) {
        return 2;
    }else
    {
        return 1;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    switch (section) {
//        case 0:
//            return 4;
//            break;
//        case 1:
//            return 3;
//            break;
//        case 2:
//            return 1;
//            break;
//        default:
//            break;
//    }
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 1;
                break;
            
        }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return 60;
            break;
        case 2:
            if ([WOTSingtleton shared].isuserLogin) {
                return 60;
            } else {
                return 0.01;
            }
            
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([WOTSingtleton shared].isuserLogin) {
        if (section == 0){
            return 0;
        } else {
            return  15;
        }
    } else {
        if (section == 0 || section == 2) {
            return 0;
        }else {
            return 15;
        }
    }
    
  
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTSettingCell *settingcell = [tableView dequeueReusableCellWithIdentifier:@"settingCellID" forIndexPath:indexPath];
    /*
    if (indexPath.section == 0) {
        
        [settingcell.valueLabel setHidden:YES];
 
        NSArray *nameArray = [[NSArray alloc]initWithObjects:@"个人资料",@"通知设置",@"修改密码",@"设置手势密码",nil];
        settingcell.loginOut.hidden = YES;
        settingcell.nameLabel.text = nameArray[indexPath.row];
         
        
        
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [settingcell.valueLabel setHidden:NO];
            settingcell.valueLabel.text = @"010-8646-7632";
        } else {
            [settingcell.valueLabel setHidden:YES];
        }
        if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
            [settingcell.lineVIew setHidden:YES];
        }
         [settingcell.loginOut setHidden:YES];
        NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"联系我们",@"关于众创空间",@"分享APP",nil];
        settingcell.nameLabel.text = nameArray1[indexPath.row];
     
    }else {
        if ([WOTSingtleton shared].isuserLogin) {
            [settingcell.valueLabel setHidden:YES];
            [settingcell.nameLabel setHidden:YES];
            [settingcell.nextImage setHidden:YES];
            [settingcell.loginOut setHidden:NO];
            [settingcell.lineVIew setHidden:YES];
        } else {
            [settingcell.valueLabel setHidden:YES];
            [settingcell.nameLabel setHidden:YES];
            [settingcell.nextImage setHidden:YES];
            [settingcell.loginOut setHidden:YES];
            [settingcell.lineVIew setHidden:YES];
        }
    }
    */
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            [settingcell.valueLabel setHidden:NO];
            settingcell.valueLabel.text = @"010-8646-7632";
        } else {
            [settingcell.valueLabel setHidden:YES];
        }
        if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
            [settingcell.lineVIew setHidden:YES];
        }
        [settingcell.loginOut setHidden:YES];
        // NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"联系我们",@"关于众创空间",@"分享APP",nil];
        NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"联系我们",nil];
        
        //settingcell.nameLabel.text = nameArray1[indexPath.row];
        settingcell.nameLabel.text = nameArray1[0];
        
        
        
    } else if (indexPath.section == 1){
        if ([WOTSingtleton shared].isuserLogin) {
            [settingcell.valueLabel setHidden:YES];
            [settingcell.nameLabel setHidden:YES];
            [settingcell.nextImage setHidden:YES];
            [settingcell.loginOut setHidden:NO];
            [settingcell.lineVIew setHidden:YES];
        } else {
            [settingcell.valueLabel setHidden:YES];
            [settingcell.nameLabel setHidden:YES];
            [settingcell.nextImage setHidden:YES];
            [settingcell.loginOut setHidden:YES];
            [settingcell.lineVIew setHidden:YES];
        }
    }else {
        
    }
    return settingcell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
    if (indexPath.section == 1) {
        if ([WOTSingtleton shared].isuserLogin) {
            [[WOTConfigThemeUitls shared] showRemindingAlert:self message:@"确定退出当前帐号?" okBlock:^{
                [WOTSingtleton shared].isuserLogin = NO;
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGIN_STATE_USERDEFAULT];
                [[WOTUserSingleton shareUser] deletePlistFile];
                [self.navigationController popViewControllerAnimated:YES];
                
            } cancel:^{
                
            }];
        }
        
        
    } else if (indexPath.section == 0){
        
        switch (indexPath.row) {
            case 0:
            {
                 [self makePhoneToSpace];
            }
//                if ([WOTSingtleton shared].isuserLogin) {
//                    [self pushVCByVCName:@"WOTPersionalInformationID" storyboard:@"My"];
//                } else {
//                   [[WOTConfigThemeUitls shared] showLoginVC:self];
//                }
                
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            default:
                break;
        }
        
    }  else {
        switch (indexPath.row) {
            case 0:
                //[self makePhoneToSpace];
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            default:
                break;
        }
    }
}


-(void)pushVCByVCName:(NSString *)vcname storyboard:(NSString *)storyboardName{
    UIViewController *vc = [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:vcname];
    [self.navigationController pushViewController:vc animated:YES];
}
//打电话 联系我们
-(void)makePhoneToSpace{
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"010-8646-7632"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
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
