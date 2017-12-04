//
//  WOTMaintenanceApplyVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMaintenanceApplyVC.h"

#import "WOTRadioView.h"
#import "WOTPickerView.h"
#import "WOTEnterTextVC.h"
#import "WOTPhotosBaseUtils.h"
#import "ZSImagePickerController.h"
#import <Photos/Photos.h>
@interface WOTMaintenanceApplyVC () <WOTPickerViewDataSource, WOTPickerViewDelegate,ZSImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    WOTPickerView *pickerView;
    NSMutableArray *selectedPhotoArray;
}
@property (weak, nonatomic) IBOutlet UIButton *selectTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *enterAddrBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation WOTMaintenanceApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectedPhotoArray = [[NSMutableArray alloc]init];
    [self configNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.enterString) {
        [self.enterBtn setTitle:self.enterString forState:UIControlStateNormal];
    }
}

-(void)configNav{
    self.navigationItem.title = @"报修申请";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    self.submitBtn.layer.cornerRadius = 8.f;
}

#pragma mark - action

- (IBAction)clickSelectTypeBtn:(id)sender {
    WOTRadioView *view = [[WOTRadioView alloc] initWithTitle:nil message:nil otherButtonTitle:@"维修", @"清洁", @"其他", nil];
    [view show];
    [view handleButtonBlock:^(NSInteger btnTag, NSString *title) {
        NSLog(@"----%ld,%@",btnTag, title);
    }];
}
- (IBAction)clickEnterBtn:(id)sender {
    WOTEnterTextVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterTextVC"];
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)clickSelectImageBtn:(id)sender {
    
    WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
    photo.onlyOne = NO;
    photo.vc = self;
    
    [photo showSelectedPhotoSheet];
    
}
- (IBAction)clickSelectTimeBtn:(id)sender {
    pickerView = [[WOTPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    [pickerView popPickerView];
}
- (IBAction)clickEnterAddrBtn:(id)sender {
  
    
}
- (IBAction)clickSubmitBtn:(id)sender {
    
    
    
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
        
    }
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
