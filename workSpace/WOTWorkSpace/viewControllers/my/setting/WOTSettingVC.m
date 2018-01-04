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
#import <Photos/Photos.h>
@interface WOTSettingVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *quitButton;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@end

@implementation WOTSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTSettingCell" bundle:nil] forCellReuseIdentifier:@"settingCellID"];
    self.navigationItem.title = @"设置";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.quitButton];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
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
    [self.navigationController.navigationBar setHidden:NO];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 3;
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
        return 0;
    }else
    {
        return 20;
    }
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.selectedPhotos.count > 0) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:self.selectedPhotos[0]];
                imageView.size = CGSizeMake(80, 80);
                imageView.layer.cornerRadius=imageView.frame.size.width/2;
                imageView.clipsToBounds=YES;
                cell.accessoryView = imageView;
            }else
            {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
                imageView.size = CGSizeMake(80, 80);
                imageView.layer.cornerRadius=imageView.frame.size.width/2;
                imageView.clipsToBounds=YES;
                
                cell.accessoryView = imageView;
            }
            
        }
        NSArray *nameArray = [[NSArray alloc]initWithObjects:@"头像",@"姓名",@"性别",@"邮箱",nil];
        cell.textLabel.text = nameArray[indexPath.row];
        
    } else if (indexPath.section == 1){
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"010-8646-7632";
        }
        NSArray *nameArray1 = [[NSArray alloc]initWithObjects:@"积分",@"关于APP",@"联系我们",nil];
        cell.textLabel.text = nameArray1[indexPath.row];
     
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self pushTZImagePickerController];
        }
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            SKAboutViewController *aboutVC = [[SKAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        
        if (indexPath.row == 2) {
            [self makePhoneToSpace];
        }
    }
    
}

#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [self viewDidLayoutSubviews];
    [self.tableView reloadData];
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
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

#pragma mark - 退出方法
-(void)quitButtonMethod
{
    [[WOTConfigThemeUitls shared] showRemindingAlert:self message:@"确定退出当前帐号?" okBlock:^{
        [WOTSingtleton shared].isuserLogin = NO;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:LOGIN_STATE_USERDEFAULT];
        [[WOTUserSingleton shareUser] deletePlistFile];
        [self.navigationController popViewControllerAnimated:YES];
        
    } cancel:^{
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
