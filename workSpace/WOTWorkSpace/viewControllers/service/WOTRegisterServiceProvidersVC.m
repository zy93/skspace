//
//  WOTRegisterServiceProvidersVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTRegisterServiceProvidersVC.h"
#import "WOTServiceProvidersCategoryVC.h"
#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTRegisterServiceProvidersCell.h"
#import "WOTSubmitRegisterServiceCell.h"
#import "WOTPhotosBaseUtils.h"
@interface WOTRegisterServiceProvidersVC () <UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *tableList;
    NSMutableArray *tableSubtitleList;
    UIImage *enterpriseLogo;
    NSString *enterpriseLogoPath;
    NSString *enterpriseTypeString;
    NSMutableDictionary *tableInputDatadic;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTRegisterServiceProvidersVC

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
    self.navigationItem.title = @"服务商申请";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)addData{
    NSArray *tableList1 = @[@"企业logo：", @"企业名称：", @"经营范围：", @"联系人：", @"联系方式：", @"服务商类别：", @"服务社区："] ;
    NSArray *tableList2 = @[@"提交"];
    tableList = [@[tableList1, tableList2] mutableCopy];
    tableSubtitleList = [@[@"请选择企业logo", @"请输入企业名称", @"请输入经营范围", @"请输入联系人", @"请输入联系方式", @"选择服务商类别", @"选择服务社区"] mutableCopy];
    tableInputDatadic = [[NSMutableDictionary alloc]init];
    enterpriseTypeString = @"";
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table reloadData];
}

#pragma mark - action
-(void)pushVCByVCName:(NSString *)vcName
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    if ([vcName isEqualToString:@"WOTServiceProvidersCategoryVC"]) {
     WOTServiceProvidersCategoryVC *dd =   (WOTServiceProvidersCategoryVC *)vc;
        dd.selectServiceBlock = ^(NSArray *selectedArray){
            for (NSString *text in selectedArray) {
                enterpriseTypeString = [NSString stringWithFormat:@"%@%@%@",enterpriseTypeString,text,@","];
            }
            tableInputDatadic[@"facilitatorType"] = enterpriseTypeString;
            
            [tableInputDatadic setValue:[[NSNumber alloc]initWithInt:0] forKey:@"facilitatorState"];
            [_table reloadData];
        };
        
    }
    else if ([vcName isEqualToString:@"WOTSelectWorkspaceListVC"]){//1
        __weak typeof(self) weakSelf = self;
        WOTSelectWorkspaceListVC *lc = (WOTSelectWorkspaceListVC*)vc;//1
        lc.selectSpaceBlock = ^(WOTSpaceModel *model){
            weakSelf.spaceId = model.spaceId;
            weakSelf.spaceName = model.spaceName;
            [weakSelf.table reloadData];
        };
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delgate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = tableList[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WOTRegisterServiceProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTRegisterServiceProvidersCell"];
        if (cell == nil) {
            cell = [[WOTRegisterServiceProvidersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTRegisterServiceProvidersCell"];
        }
        NSArray *arr = tableList[indexPath.section];
        [cell.titleLab setText:arr[indexPath.row]];
        [cell.contentText setPlaceholder:tableSubtitleList[indexPath.row]];
        [cell.contentText setTag:indexPath.row];
        cell.contentText.delegate = self;
        if (indexPath.row == 0) {
            cell.contentText.enabled = NO;
            [cell.contentText setHidden:YES];
            [cell.iconImg setHidden:NO];
            cell.iconImg.image = enterpriseLogo?enterpriseLogo:[UIImage imageNamed:@"camera_icon"];
            cell.imageWidth.constant = enterpriseLogo?45:25;
            cell.imageHeight.constant = enterpriseLogo?45:20;
        }
        else if (indexPath.row==5 || indexPath.row == 6) {
            cell.contentText.enabled = NO;
            if (indexPath.row == 5) {
                cell.contentText.text = enterpriseTypeString;
            }
            else if (self.spaceName) {
                cell.contentText.text = self.spaceName;
            }
            
            [cell.contentText setHidden:NO];
            [cell.iconImg setHidden:YES];
            
        }
        else
        {
            cell.contentText.enabled = YES;
            [cell.contentText setHidden:NO];
            [cell.iconImg setHidden:YES];
            
        }
       
        return cell;
    }
    else{
        WOTSubmitRegisterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSubmitRegisterServiceCell"];
        if (cell == nil) {
            cell = [[WOTSubmitRegisterServiceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTSubmitRegisterServiceCell"];
        }
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
            photo.onlyOne = YES;
            photo.vc = self;
            
            [photo showSelectedPhotoSheet];
        }
        else if (indexPath.row==5)
        {
            [self pushVCByVCName:@"WOTServiceProvidersCategoryVC"];
        }
        else if (indexPath.row == 6) {
            [self pushVCByVCName:@"WOTSelectWorkspaceListVC"];//1
        }
        
        
    }
    else {
            //
        NSLog(@"测试%@",tableInputDatadic);
       
        BOOL isLogin = [WOTUserSingleton shareUser].userInfo.userId == nil;
        if (isLogin) {
            [MBProgressHUDUtil showMessage:@"请登录后再申请！" toView:self.view];
            return;
        }
        BOOL isFirmLogo = enterpriseLogo == nil;
        if (isFirmLogo) {
            [MBProgressHUDUtil showMessage:@"请上传企业logo" toView:self.view];
            return;
        }
        BOOL isFirName = tableInputDatadic[@"firmName"] == nil;
        BOOL isBusinessScope = tableInputDatadic[@"businessScope"] == nil;
        BOOL isContatcts =tableInputDatadic[@"contatcts"] == nil;
        BOOL isTel =tableInputDatadic[@"tel"] == nil;
        BOOL isFacilitatorType = tableInputDatadic[@"facilitatorType"] == nil;
        BOOL isFacilitatorState = tableInputDatadic[@"facilitatorState"] == nil;
        if (isFirName || isBusinessScope ||isContatcts ||isTel || isFacilitatorType|| isFacilitatorState) {
            [MBProgressHUDUtil showMessage:@"请将信息填写完整后再提交" toView:self.view];
            return;
        }
            [self registerService:[WOTUserSingleton shareUser].userInfo.userId firmName:tableInputDatadic[@"firmName"]
                    businessScope:tableInputDatadic[@"businessScope"]
                        contatcts:tableInputDatadic[@"contatcts"]
                              tel:tableInputDatadic[@"tel"]
                  facilitatorType:tableInputDatadic[@"facilitatorType"]
                 facilitatorState:tableInputDatadic[@"facilitatorState"]
                         firmLogo:enterpriseLogo];
      

    }
    
}


#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }

    enterpriseLogoPath = editingInfo[UIImagePickerControllerReferenceURL];
    tableInputDatadic[@"firmLogo"] = enterpriseLogoPath;
    enterpriseLogo = image;
    [self.table reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    return [textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            break;
        case 1:
            tableInputDatadic[@"firmName"] = textField.text;
            break;
        case 2:
             tableInputDatadic[@"businessScope"] = textField.text;
                break;
        case 3:
            tableInputDatadic[@"contatcts"] = textField.text;
                break;
        case 4:
            tableInputDatadic[@"tel"] = textField.text;
            break;
        case 5:
           
                break;
        case 6:
            
            break;
            
        default:
            break;
    }
}

-(void)registerService:(NSNumber *)userId
              firmName:(NSString *)firmName
         businessScope:(NSString *)businessScope
             contatcts:(NSString *)contatcts
                   tel:(NSString *)tel
       facilitatorType:(NSString *)facilitatorType
      facilitatorState:(NSNumber *)facilitatorState
              firmLogo:(UIImage *)firmLogo{
    
    NSArray<UIImage *> *aa = @[firmLogo];
    
    //[[WOTUserSingleton shareUser]setValues];
    [MBProgressHUDUtil showLoadingWithMessage:@"" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        
    [WOTHTTPNetwork registerServiceBusiness:userId firmName:firmName businessScope:businessScope contatcts:contatcts tel:tel facilitatorType:facilitatorType facilitatorState:facilitatorState firmLogo:aa response:^(id bean, NSError *error) {
       
        [hud setHidden: YES];
        if (bean) {
            [MBProgressHUDUtil showMessage:SubmitReminding toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
       
    }];
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
