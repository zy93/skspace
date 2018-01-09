//
//  WOTCreateEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTCreateEnterpriseVC.h"
#import "WOTCerateEnterpriseCell.h"
#import "WOTEnterpriseTypeVC.h"
#import "WOTEnterpriseContactsInfoVC.h"
#import "WOTPhotosBaseUtils.h"
#import "WOTBusinessModel.h"
#import "WOTEnterEnterpriseNameVC.h"
@interface WOTCreateEnterpriseVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSArray *tableTitleList;
@property(nonatomic,strong)NSArray *tableSubtitleList;
@property(nonatomic,strong)NSString *enterpriseName;
@property(nonatomic,strong)NSString *enterpriseType;
@property(nonatomic,strong)NSString *contactsName; //联系人
@property(nonatomic,strong)NSString *contactsTel;
@property(nonatomic,strong)NSString *contactsEmail;
@property(nonatomic,strong)UIImage *enterpriseLogo;
@end

@implementation WOTCreateEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDataSource];
    self.navigationItem.title = @"创建企业";
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTCerateEnterpriseCell" bundle:nil] forCellReuseIdentifier:@"WOTCerateEnterpriseCellID"];
    
    //保存按钮
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [createBtn setBackgroundColor:UICOLOR_MAIN_BLACK];
    [createBtn.layer setCornerRadius:5.f];
    [createBtn setTitle:@"创 建 企 业" forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createEnterpriseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
    [createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - action
-(void)createEnterpriseBtn:(UIButton *)sender
{
    if (strIsEmpty(_enterpriseName)) {
        [MBProgressHUDUtil showMessage:@"请填写企业名称" toView:self.view];
        return;
    }
    else if (strIsEmpty(_enterpriseType)) {
        [MBProgressHUDUtil showMessage:@"请选择企业类型" toView:self.view];
        return;
    }
    else if (strIsEmpty(_contactsName)) {
        [MBProgressHUDUtil showMessage:@"请填写联系人" toView:self.view];
        return;
    }
    else if (!_enterpriseLogo) {
        return;
    }
    
    [MBProgressHUDUtil showLoadingWithMessage:@"请稍后" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        
        [WOTHTTPNetwork createEnterpriseWithEnterpriseName:self.enterpriseName enterpriseType:self.enterpriseType enterpriseLogo:self.enterpriseLogo contactsName:self.contactsName contactsTel:self.contactsTel contactsEmail:self.contactsEmail response:^(id bean, NSError *error) {
            WOTBusinessModel*model = bean;
            if ([model.code isEqualToString:@"200"]) {
                [hud setLabelText:@"创建成功!"];
                [hud hide:YES afterDelay:2.f complete:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self back];
                    });
                }];
            }
            else {
                [hud setLabelText:strIsEmpty(model.result)?@"提交失败，请稍后再试！": model.result];
            }

        }];
    }];
}

#pragma mark - table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableTitleList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTCerateEnterpriseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTCerateEnterpriseCellID" forIndexPath:indexPath];
    cell.titleLabel.text = self.tableTitleList[indexPath.row];
    cell.textfield.placeholder = self.tableSubtitleList[indexPath.row];
    
    if (indexPath.row == 1 && !strIsEmpty(_enterpriseName)) {
        cell.textfield.placeholder = _enterpriseName;
    }
    else if (indexPath.row == 2 && !strIsEmpty(_enterpriseType)) {
        cell.textfield.placeholder = _enterpriseType;
    }
    else if (indexPath.row == 3 && !strIsEmpty(self.contactsName)) {
        cell.textfield.placeholder = self.contactsName;
    }
    

    cell.textfield.delegate  = self;
    cell.cameraImage.image = _enterpriseLogo?_enterpriseLogo : [UIImage imageNamed:@"camera_icon"];
    cell.cameraImage.hidden = indexPath.row == 0?NO:YES;
    cell.nextImage.hidden = indexPath.row == 0?YES:NO;
    [cell.textfield setUserInteractionEnabled:NO];
    cell.textfield.hidden = indexPath.row == 0?YES:NO;
    cell.imageWidth.constant = _enterpriseLogo?45:25;
    cell.imageHeight.constant = _enterpriseLogo?45:20;
    return cell;
}



-(void)createDataSource {
    self.tableTitleList    = @[@"企业logo",@"企业名称",@"企业类型",@"联系人信息"];
    self.tableSubtitleList = @[@"企业logo",@"请输入企业名称",@"请选择",@"点击输入"];
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
        photo.onlyOne = YES;
        photo.vc = self;
        
        [photo showSelectedPhotoSheet];
    } else if (indexPath.row == 1) {
        WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
        vc.enterpriseName = ^(NSString *enterpriseName) {
            _enterpriseName = enterpriseName;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2) {
        WOTEnterpriseTypeVC *vc = [[UIStoryboard storyboardWithName:@"My" bundle:nil]instantiateViewControllerWithIdentifier:@"WOTEnterpriseTypeVCID"];
        vc.gobackBlock = ^(NSString *type){
            _enterpriseType = type;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3){
        WOTEnterpriseContactsInfoVC * vc = [[WOTEnterpriseContactsInfoVC alloc] init];

        vc.contactsBlock = ^(NSString *name, NSString *tel, NSString *email) {
            _contactsName = name;
            _contactsTel = tel;
            _contactsEmail = email;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

//-(void)setViewHidden{
//    [_connectvc.view setHidden:YES];
//    [_maskView setHidden:YES];
//}
//
//-(void)showView{
//    [_connectvc.view setHidden:NO];
//    [_maskView setHidden:NO];
//}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    _enterpriseLogo = image;
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
