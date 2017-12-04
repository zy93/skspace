//
//  WOTMainAppleRepairVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/20.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMainAppleRepairVC.h"
#import "WOTApplyRepairCell.h"
#import "ZSImagePickerController.h"
#import "WOTRadioView.h"
#import "WOTPickerView.h"
#import "WOTEnterTextVC.h"
#import "WOTPhotosBaseUtils.h"
#import <Photos/Photos.h>
#import "WOTAppleRepairCommonCell.h"
#import "WOTImageLookoverVC.h"
#import "WOTDatePickerView.h"
@interface WOTMainAppleRepairVC ()<WOTPickerViewDataSource, WOTPickerViewDelegate,ZSImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *selectedPhotoArray;
    NSString *repariType;
    NSString *repairInfo;
    NSString *repairTime;
    NSString *repairLocation;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property(nonatomic,strong)WOTDatePickerView *datepickerview;
@property (nonatomic,strong)ZSImagePickerController *zsImagePicker;
@end

@implementation WOTMainAppleRepairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zsImagePicker.zs_delegate = self;
    self.view.backgroundColor = MainColor;
    self.tableView.backgroundColor = CLEARCOLOR;
    [self setupView];
     selectedPhotoArray = [[NSMutableArray alloc]init];
    [_submitBtn setCorenerRadius:8.0 borderColor:CLEARCOLOR];
    [self configNav];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTApplyRepairCell" bundle:nil] forCellReuseIdentifier:@"WOTApplyRepairCellID"];
      [selectedPhotoArray addObject:[UIImage imageNamed:@"addPhoto"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
   // [selectedPhotoArray addObject:[UIImage imageNamed:@"addPhoto"]];
    //[self.tableView reloadData];
    
    [self.navigationController.navigationBar setHidden:NO];
}

- (IBAction)sunmitAction:(id)sender {
//    [[WOTUserSingleton shareUser]setValues];
    if (selectedPhotoArray.count == 1) {
        [selectedPhotoArray removeAllObjects];
    }
    
    //NSLog(@"%@",selectedPhotoArray[0]);
    BOOL isLogin = [WOTUserSingleton shareUser].userInfo.userId == nil;
    if (isLogin) {
        [MBProgressHUDUtil showMessage:@"请登录后，再提交！" toView:self.view];
        return;
    }
    BOOL isType = repariType == nil;
    BOOL isInfo = repairInfo == nil;
    BOOL isAppointmentTime = repairTime == nil;
    BOOL isAddress = repairLocation == nil;
    BOOL isFile = selectedPhotoArray == nil;
    
    if (isType || isInfo ||isAppointmentTime ||isAddress) {
        [MBProgressHUDUtil showMessage:@"请填写完整信息！" toView:self.view];
        return;
    }
    
    if (isFile) {
        [MBProgressHUDUtil showMessage:@"请上传报修图片！" toView:self.view];
        return;
    }
    [MBProgressHUDUtil showLoadingWithMessage:@"" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
       [WOTHTTPNetwork postRepairApplyWithUserId:[WOTUserSingleton shareUser].userInfo.userId
                                            type:repariType
                                            info:repairInfo
                                 appointmentTime:repairTime
                                         address:repairLocation
                                            file:selectedPhotoArray
                                           alias:@"1"
                                        response:^(id bean, NSError *error) {
           [hud setHidden:YES];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
      
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        
        return (SCREEN_WIDTH-20)/3.5 * ceil(selectedPhotoArray.count*0.3) +70;
    } else {
        return 70;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell;
    if (indexPath.row == 1) {
        WOTApplyRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTApplyRepairCellID" forIndexPath:indexPath];
        
        cell.cellTitle.text = @"报修描述";
        cell.cellValue.text = @"请输入";
        cell.photosArray = selectedPhotoArray;
        
        cell.collectionImageViewBlock = ^(NSInteger index){
            NSLog(@"选中：%ld",index);
            
            if (index == 0) {
                [selectedPhotoArray removeAllObjects];
                [selectedPhotoArray addObject:[UIImage imageNamed:@"addPhoto"]];
                WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
                photo.onlyOne = YES;
                photo.vc = self;
                
                [photo showSelectedPhotoSheet];
            } else {
                WOTImageLookoverVC *lookvc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTImageLookoverVCID"];
                lookvc.mainimage = selectedPhotoArray[index];
                [self.navigationController pushViewController:lookvc animated:YES];
            }
           
            
            
        };
        commoncell = cell;
    } else {
        WOTAppleRepairCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTAppleRepairCommonCellID" forIndexPath:indexPath];
        
        NSArray *titles = @[@"报修类型",@"报修描述",@"报修时间",@"报修位置"];
        NSArray *values = @[@"请选择",@"请输入",@"请选择时间",@"请输入位置"];
        cell.cellTitle.text = titles[indexPath.row];
        cell.cellValue.text = values[indexPath.row];
        commoncell = cell;
    }
    
    return commoncell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        WOTRadioView *view = [[WOTRadioView alloc] initWithTitle:nil message:nil otherButtonTitle:@"维修", @"清洁", @"其他", nil];
        [view show];
        [view handleButtonBlock:^(NSInteger btnTag, NSString *title) {
            WOTAppleRepairCommonCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.cellValue.text = title;
            repariType = title;
        }];
    } else if (indexPath.row == 1 || indexPath.row == 3){
      
        WOTEnterTextVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterTextVC"];
        vc.popVCWithEnterString = ^(NSString *enterString){
            WOTAppleRepairCommonCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.cellValue.text = enterString;
            if (indexPath.row == 1){
                repairInfo = enterString;
            } else {
                repairLocation = enterString;
            }
            
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 2){
        _datepickerview.hidden  = NO;
        
    }
}


-(void)configNav{
    self.navigationItem.title = @"报修申请";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
}




#pragma mark - picker view dataSource
-(NSInteger)numberOfComponentsInPickerView:(WOTPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(WOTPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component==0?24:60;
}

-(NSString *)pickerView:(WOTPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return component==0? [NSString stringWithFormat:@"%d时",(int)row]:[NSString stringWithFormat:@"%02d分",(int)row];
}

#pragma mark ZSImagePickerController delegate  选择多张照片代理

- (void)zs_imagePickerController:(nullable ZSImagePickerController *)picker beyondMaxSelectedPhotoCount:(NSInteger)count{
    NSLog(@"%zd",count);
}

- (void)zs_imagePickerController:(nullable ZSImagePickerController *)picker didFinishPickingMediaWithInfo:(nullable NSDictionary<NSString *,NSArray *> *)info{
   
    NSLog(@"%@",info);
}

- (void)zs_imagePickerControllerDidCancel:(nullable ZSImagePickerController *)picker{
    NSLog(@"Cancel");
}

- (void)zs_imagePickerController:(nullable ZSImagePickerController *)picker didFinishPickingImage:(nullable NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    NSArray <PHAsset *>*assets = info[@"result"];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
            [selectedPhotoArray addObject:result];
        }];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    }
   //  [self dismissViewControllerAnimated:YES completion:nil];//新添加
}

-(void)setupView
{
  
    __weak typeof(self) weakSelf = self;
    
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour, NSInteger min){
        weakSelf.datepickerview.hidden = YES;
       // NSLog(@"%ld年%ld月%ld日%ld时%ld分",year,month,day,hour,min);
//        repairTime = [NSString stringWithFormat:@"%ld/%ld/%ld %ld:%ld:00",year,month,day,hour,min];
        repairTime = [NSString stringWithFormat:@"%ld/%ld/%ld",year,month,day];
        WOTAppleRepairCommonCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.cellValue.text = repairTime;
    };
    
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden  = YES;
}



#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    
    
    [selectedPhotoArray addObject:image];

     NSLog(@"测试：%@",selectedPhotoArray);
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
