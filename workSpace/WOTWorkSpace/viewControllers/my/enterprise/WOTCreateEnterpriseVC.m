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
#import "WOTEnterpriseConnectsInfoVC.h"
#import "WOTPhotosBaseUtils.h"
#import "WOTBusinessModel.h"
#import "WOTEnterEnterpriseNameVC.h"
@interface WOTCreateEnterpriseVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSArray *tableTitleList;
@property(nonatomic,strong)NSArray *tableSubtitleList;
@property(nonatomic,strong)NSString *enterpriseType;
@property(nonatomic,strong)NSString *enterpriseConntects;
@property(nonatomic,strong)UIImage *enterpriseLogo;
@end

@implementation WOTCreateEnterpriseVC

- (void)viewDidLoad {
    
    __weak typeof(self) weakSelf = self;
    [super viewDidLoad];
    
    [self createDataSource];
    self.navigationItem.title = @"创建企业";
    [self configNaviRightItemWithTitle:@"保存" textColor:[UIColor redColor]];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTCerateEnterpriseCell" bundle:nil] forCellReuseIdentifier:@"WOTCerateEnterpriseCellID"];

//    [self setViewHidden];
    // Do any additional setup after loading the view.
}
-(void)rightItemAction {
    //TODO:调用接口保存企业信息
    
    if (strIsEmpty(_enterpriseConntects)) {
        [MBProgressHUDUtil showMessage:@"请填写企业名称" toView:self.view];
        return;
    }
    else if (strIsEmpty(_enterpriseType)) {
        [MBProgressHUDUtil showMessage:@"请选择企业类型" toView:self.view];
        return;
    }
//    else if (strIsEmpty(_connectvc.nameTextfield.text)) {
//        [MBProgressHUDUtil showMessage:@"请输入联系人姓名" toView:self.view];
//        return;
//    }
//    else if (strIsEmpty(_connectvc.telTextfield.text)) {
//        [MBProgressHUDUtil showMessage:@"请输入联系人电话" toView:self.view];
//        return;
//    }
//    else if (strIsEmpty(_connectvc.emailTextfield.text)) {
//        [MBProgressHUDUtil showMessage:@"请输入联系人邮箱" toView:self.view];
//        return;
//    }
//    [MBProgressHUDUtil showLoadingWithMessage:@"请稍后" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
//        [WOTHTTPNetwork addBusinessWithLogo:_enterpriseLogo name:_enterpriseConntects type:_enterpriseType contactName:_connectvc.nameTextfield.text contactTel:_connectvc.telTextfield.text contactEmail:_connectvc.emailTextfield.text response:^(id bean, NSError *error) {
//            WOTBusinessModel*model;
//
//            if (bean) {
//                model = (WOTBusinessModel*)bean;
//            }
//            if (model.code.integerValue==200) {
//                [hud setLabelText:@"信息已提交，请等待管理人员审核"];
//                [hud hide:YES afterDelay:2.f];
//            }
//            else {
//            }
//
//        }];
//    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    if (indexPath.row == 2 && !strIsEmpty(_enterpriseType)) {
        cell.textfield.placeholder = _enterpriseType;
    }
    else if (indexPath.row == 3 && !strIsEmpty(_enterpriseConntects)) {
        cell.textfield.placeholder = _enterpriseConntects;
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
    if (indexPath.row == 0) {
        WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
        photo.onlyOne = YES;
        photo.vc = self;
        
        [photo showSelectedPhotoSheet];
    } else if (indexPath.row == 1) {
        WOTEnterEnterpriseNameVC *vc = [[WOTEnterEnterpriseNameVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2) {
        WOTEnterpriseTypeVC *typevc = [[UIStoryboard storyboardWithName:@"My" bundle:nil]instantiateViewControllerWithIdentifier:@"WOTEnterpriseTypeVCID"];
        typevc.gobackBlock = ^(NSString *type){
            _enterpriseType = type;
            [self.tableView reloadData];
        };
        [self.supervc.navigationController pushViewController:typevc animated:YES];
    } else if (indexPath.row == 3){
//        [self showView];
        
        WOTEnterpriseConnectsInfoVC * vc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterpriseConnectsInfoVCID"];
        vc.view.frame = self.view.frame;
        
        vc.cancelBlokc  = ^{
//            [weakSelf setViewHidden];
        };
        vc.okBlock = ^(NSString *name,NSString *tel, NSString *email){
            _enterpriseConntects = name;
            [self.tableView reloadData];
//            [weakSelf setViewHidden];
            //TODO:保存输入的企业信息
        };
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
