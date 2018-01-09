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
#import "WOTSpaceModel.h"
#import "Masonry.h"

@interface WOTRegisterServiceProvidersVC () <UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *tableList;
    NSMutableArray *tableSubtitleList;
    UIImage *enterpriseLogo;
    NSString *enterpriseLogoPath;
    NSString *enterpriseTypeString;
    NSMutableDictionary *tableInputDatadic;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *applicationSubmitButton;

@end

@implementation WOTRegisterServiceProvidersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addData];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:self.scrollView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.applicationSubmitButton];
    [self configNav];
    
    [self layoutSubViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)layoutSubViews
{
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//        //make.bottom.equalTo(self.applicationSubmitButton.mas_bottom).with.offset(10);
//    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.applicationSubmitButton.mas_top);

    }];
    
    [self.applicationSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-10);
        make.left.equalTo(self.view).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.height.mas_offset(48);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"注册服务商";
}

-(void)addData{
    NSArray *tableList1 = @[@"企业logo：", @"企业名称：", @"经营范围：", @"联系人：", @"联系方式：", @"服务商类别："] ;
    tableList = [@[tableList1] mutableCopy];
    tableSubtitleList = [@[@"请选择企业logo", @"请输入企业名称", @"请输入经营范围", @"请输入联系人", @"请输入联系方式", @"选择服务商类别", @"选择服务社区"] mutableCopy];
    tableInputDatadic = [[NSMutableDictionary alloc]init];
    enterpriseTypeString = @"";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}

#pragma mark - action
-(void)pushVCByVCName:(NSString *)vcName
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    if ([vcName isEqualToString:@"WOTServiceProvidersCategoryVC"]) {
     WOTServiceProvidersCategoryVC *dd =   (WOTServiceProvidersCategoryVC *)vc;
        dd.selectServiceBlock = ^(NSArray *selectedArray){
            for (NSString *text in selectedArray) {
                enterpriseTypeString = [NSString stringWithFormat:@"%@%@%@",enterpriseTypeString,text,@","];
            }
            tableInputDatadic[@"facilitatorType"] = enterpriseTypeString;
            
            [tableInputDatadic setValue:[[NSNumber alloc]initWithInt:0] forKey:@"facilitatorState"];
           // [_table reloadData];
        };
    }
    else if ([vcName isEqualToString:@"WOTSelectWorkspaceListVC"]){//1
        __weak typeof(self) weakSelf = self;
        WOTSelectWorkspaceListVC *lc = (WOTSelectWorkspaceListVC*)vc;//1
        lc.selectSpaceBlock = ^(WOTSpaceModel *model){
            weakSelf.spaceId = model.spaceId;
            weakSelf.spaceName = model.spaceName;
           // [weakSelf.table reloadData];
        };
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - table delgate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return tableList.count;
    return 6;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"WOTRegisterServiceProvidersCell";
    WOTRegisterServiceProvidersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WOTRegisterServiceProvidersCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSArray *arr = tableList[0];
    NSLog(@"标题：%@",arr[indexPath.section]);
    //[cell.titleLabel.text setText:arr[indexPath.section]];
    cell.titleLabel.text = arr[indexPath.section];
    [cell.contentTextField setPlaceholder:tableSubtitleList[indexPath.section]];
    [cell.contentTextField setTag:indexPath.section];
    cell.contentTextField.delegate = self;
    if (indexPath.section == 0) {
        cell.contentTextField.enabled = NO;
        [cell.contentTextField setHidden:YES];
        [cell.iconImg setHidden:NO];
        cell.iconImg.image = enterpriseLogo?enterpriseLogo:[UIImage imageNamed:@"camera_icon"];
       
//        cell.imageWidth.constant = enterpriseLogo?45:25;
//        cell.imageHeight.constant = enterpriseLogo?45:20;
    }
    else if (indexPath.section==5 || indexPath.section == 6) {
        cell.contentTextField.enabled = NO;
        if (indexPath.section == 5) {
            cell.contentTextField.text = enterpriseTypeString;
        }
        else if (self.spaceName) {
            cell.contentTextField.text = self.spaceName;
        }
        [cell.contentTextField setHidden:NO];
        [cell.iconImg setHidden:YES];
    }
    else
    {
        cell.contentTextField.enabled = YES;
        [cell.contentTextField setHidden:NO];
        [cell.iconImg setHidden:YES];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // if (indexPath.section == 0) {
        if (indexPath.section == 0) {
            WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
            photo.onlyOne = YES;
            photo.vc = self;
            [photo showSelectedPhotoSheet];
        }
        else if (indexPath.section==5)
        {
           // [self pushVCByVCName:@"WOTEnterpriseTypeVC"];
        }
        else if (indexPath.section == 6) {
            [self pushVCByVCName:@"WOTSelectWorkspaceListVC"];//1
        }
        NSLog(@"测试%@",tableInputDatadic);
    
 //   }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
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
    [self.tableView reloadData];
    
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

#pragma mark - 提交按钮方法
-(void)applicationSubmitButtonMethod
{
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
    [self registerService:[WOTUserSingleton shareUser].userInfo.userId              firmName:tableInputDatadic[@"firmName"]
            businessScope:tableInputDatadic[@"businessScope"]
                contatcts:tableInputDatadic[@"contatcts"]
                      tel:tableInputDatadic[@"tel"]
          facilitatorType:tableInputDatadic[@"facilitatorType"]
         facilitatorState:tableInputDatadic[@"facilitatorState"]
                 firmLogo:enterpriseLogo];
}

#pragma mark - 提交注册服务商
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

#pragma mark - 初始化控件
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
        view.backgroundColor = [UIColor redColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = view;
        _tableView.backgroundColor = UICOLOR_MAIN_BACKGROUND;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _tableView;
}

-(UIButton *)applicationSubmitButton
{
    if (_applicationSubmitButton == nil) {
        _applicationSubmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applicationSubmitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_applicationSubmitButton addTarget:self action:@selector(applicationSubmitButtonMethod) forControlEvents:UIControlEventTouchDown];
        _applicationSubmitButton.backgroundColor = UICOLOR_MAIN_ORANGE;
        _applicationSubmitButton.layer.cornerRadius = 5.f;
        _applicationSubmitButton.layer.borderColor = UICOLOR_MAIN_ORANGE.CGColor;
        _applicationSubmitButton.layer.borderWidth = 1.f;
    }
    return _applicationSubmitButton;
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}


@end
