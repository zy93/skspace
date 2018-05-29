//
//  WOTSettingVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSettingVC.h"
#import "WOTLoginVC.h"
#import "WOTPersionalInformation.h"
#import "UIColor+ColorChange.h"
#import "SKAboutViewController.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import <Photos/Photos.h>
#import "SKUpdateInfoViewController.h"
#import "WOTPickerView.h"

@interface WOTSettingVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,WOTPickerViewDelegate,WOTPickerViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *quitButton;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
//@property(nonatomic,strong)NSString *headImageUrl;
@property(nonatomic,strong)WOTLoginModel *userInfoModel;
@property (nonatomic, strong) WOTPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerData;
@end

@implementation WOTSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationItem.title = @"设置";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.quitButton];
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.quitButton.mas_top);
    }];
    
    [self.quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.height.mas_offset(48);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self querySingularManInfo];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    
    return 60;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else
    {
        return 10;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 2?20:0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView sd_setImageWithURL:[self.userInfoModel.headPortrait ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
                imageView.size = CGSizeMake(60, 60);
                imageView.layer.cornerRadius=imageView.frame.size.width/2;
                imageView.clipsToBounds=YES;
                cell.accessoryView = imageView;
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = self.userInfoModel.userName;
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = self.userInfoModel.sex;
        }
        if (indexPath.row == 3) {
            cell.detailTextLabel.text = self.userInfoModel.email;
        }
        NSArray *nameArray = [[NSArray alloc]initWithObjects:@"头像",@"姓名",@"性别",@"邮箱",nil];
        cell.textLabel.text = nameArray[indexPath.row];
        
    } else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryNone;
         if (indexPath.row == 0) {
            cell.detailTextLabel.text = [self.userInfoModel.integral stringValue];
        }
        else {
            cell.detailTextLabel.text = self.userInfoModel.meInvitationCode;
        }
        NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"积分",@"我的邀请码",nil];
        cell.textLabel.text = nameArray1[indexPath.row];
        
    } else if (indexPath.section == 2){
        cell.accessoryView = nil;
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"010-8646-7632";
        }
        else {
            cell.detailTextLabel.text = nil;
        }
        NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"关于APP",@"联系我们",nil];
        cell.textLabel.text = nameArray1[indexPath.row];
     
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                     message:nil
                 preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel                                                            handler:^(UIAlertAction * action) {}];
            UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                 [self pushTZImagePickerController];
            }];
            UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    //  imagePicker.allowsEditing = NO;
                    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:fromCameraAction];
            [alertController addAction:fromPhotoAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        if (indexPath.row == 1) {
            SKUpdateInfoViewController *updateVC = [[SKUpdateInfoViewController alloc] init];
            updateVC.navigationStr = @"修改姓名";
            updateVC.placeholderStr = @"请输入修改的姓名";
            [self.navigationController pushViewController:updateVC animated:YES];
        }
        
        if (indexPath.row == 2) {
            self.pickerData = @[@"男", @"女"];
           // isSelectSex = YES;
            [self.pickerView reloadData];
            __weak typeof(self) weakSelf = self;
            self.pickerView.selectBlock = ^(BOOL status, NSInteger row) {
                if (status) {
//                    NSLog(@"选择了");
                    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                                 @"sex":weakSelf.pickerData[row]
                                                 };
                    [weakSelf updateUserInfoWithParameters:parameters];
                }
            };
            [self.pickerView popPickerView];
        }
        
        if (indexPath.row == 3) {
            SKUpdateInfoViewController *updateVC = [[SKUpdateInfoViewController alloc] init];
            updateVC.navigationStr = @"修改邮箱";
            updateVC.placeholderStr = @"请输入修改的邮箱";
            [self.navigationController pushViewController:updateVC animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            //复制邀请码到粘贴板
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"邀请用户注册使用"
                                                                                     message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel                                                            handler:^(UIAlertAction * action) {}];
            UIAlertAction* copyAction = [UIAlertAction actionWithTitle:@"复制邀请码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string=self.userInfoModel.meInvitationCode;
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:copyAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            SKAboutViewController *aboutVC = [[SKAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        
        if (indexPath.row == 1) {
            [self makePhoneToSpace];
        }
    }
    
}
#pragma mark - picker delegate
-(NSInteger)numberOfComponentsInPickerView:(WOTPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(WOTPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

-(NSString *)pickerView:(WOTPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}

-(void)pickerView:(WOTPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"-----%@",self.pickerData[row]);
//    if (isSelectSex) {
//        self.genderValueLab.text = self.pickerData[row];
//        self.genderValueLab.textColor = UICOLOR_BLACK;
//        
//    }
//    else {
//        self.accessTypeValueLab.text = self.pickerData[row];
//        self.accessTypeValueLab.textColor = UICOLOR_BLACK;
//        
//    }
}


#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowCrop = YES;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.cropRect = CGRectMake(0, SCREEN_WIDTH/2-40, SCREEN_WIDTH, SCREEN_WIDTH);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [self viewDidLayoutSubviews];
    //[self.tableView reloadData];
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId};
    [self updateUserInfoWithParameters:parameters];
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
}


#pragma mark -UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
    
    //  UIImage * image =info[UIImagePickerControllerOriginalImage];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    [self.selectedPhotos addObject:image];
    //[self.tableView reloadData];
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId};
    [self updateUserInfoWithParameters:parameters];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

#pragma mark - 退出方法
-(void)quitButtonMethod
{
    [[WOTConfigThemeUitls shared] showAlert:self message:@"确定退出当前帐号?" okBlock:^{
        [WOTSingtleton shared].isuserLogin = NO;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGIN_STATE_USERDEFAULT];
        [[WOTUserSingleton shareUser] deletePlistFile];
        [WOTUserSingleton destroyInstance];
        [self.navigationController popViewControllerAnimated:YES];
        
    } cancel:^{
        
    }];
}

#pragma mark - 请求个人信息
-(void)querySingularManInfo
{
    if ([WOTUserSingleton shareUser].userInfo.userId == nil) {
        [MBProgressHUDUtil showMessage:@"请先登录再进行其他操作" toView:self.view];
        return;
    }
    [WOTHTTPNetwork querySingularManInfoWithUserId:[WOTUserSingleton shareUser].userInfo.userId response:^(id bean, NSError *error) {
        WOTLoginModel_msg *model_msg = (WOTLoginModel_msg *)bean;
        WOTLoginModel *model = model_msg.msg;
        if ([model_msg.code isEqualToString:@"200"]) {
//                self.headImageUrl = model.headPortrait;
            [[WOTUserSingleton shareUser] saveUserInfoToPlistWithModel:model];
            self.userInfoModel = model;
            [self.tableView reloadData];
        } else {
            [MBProgressHUDUtil showMessage:@"网络出错！" toView:self.view];
        }
    }];
}

#pragma mark - 修改资料
-(void)updateUserInfoWithParameters:(NSDictionary *)parameters
{
    NSLog(@"资料：%@",parameters);
    [MBProgressHUDUtil showLoadingWithMessage:@"提交中" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        [WOTHTTPNetwork updateUserInfoWithParameters:parameters photosArray:self.selectedPhotos response:^(id bean, NSError *error) {
            [hud setHidden:YES];
            WOTBaseModel *model = (WOTBaseModel *)bean;
            if ([model.code isEqualToString:@"200"]) {
                [MBProgressHUDUtil showMessage:@"修改成功！" toView:self.view];
                [self querySingularManInfo];
            }else {
                [MBProgressHUDUtil showMessage:@"网络出错！" toView:self.view];
            }
            
        }];
    }];
    
    
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


-(UIButton *)quitButton
{
    if (_quitButton == nil) {
        _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_quitButton addTarget:self action:@selector(quitButtonMethod) forControlEvents:UIControlEventTouchDown];
        [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
        _quitButton.backgroundColor = [UIColor colorWithHexString:@"ff7f3d"];
        _quitButton.layer.cornerRadius = 5.f;
        _quitButton.layer.borderWidth = 1.f;
        _quitButton.layer.borderColor =[UIColor colorWithHexString:@"ff7f3d"].CGColor;
    }
    return _quitButton;
}

-(NSMutableArray *)selectedPhotos
{
    if (_selectedPhotos == nil) {
        _selectedPhotos = [[NSMutableArray alloc] init];
    }
    return _selectedPhotos;
}

-(WOTPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[WOTPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
      //  [_pickerView.pickerV clearSpearatorLine];
//        _pickerView.pickerV.layer.cornerRadius = 5.f;
//        _pickerView.pickerV.layer.borderWidth = 1.f;
//        _pickerView.pickerV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.view addSubview:_pickerView];
//        [_pickerView popPickerView];
    }
    return  _pickerView;
}


@end
