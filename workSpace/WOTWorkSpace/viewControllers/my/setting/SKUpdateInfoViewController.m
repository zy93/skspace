//
//  SKUpdateInfoViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/5.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKUpdateInfoViewController.h"
#import "Masonry.h"

@interface SKUpdateInfoViewController ()

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITextField *importTextField;
@property(nonatomic,strong)NSDictionary *parametersDictionary;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@end

@implementation SKUpdateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNaviBackItem];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationController.navigationBar.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationItem.title = self.navigationStr;
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.importTextField];
    [self addRightBtn];
}

-(void)viewDidLayoutSubviews
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11,*)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }else
        {
            make.top.equalTo(self.view).with.offset(64);
        }
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    [self.importTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.topView);
    }];
}

- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo)];
    rightBarItem.tintColor = UICOLOR_MAIN_ORANGE;
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - 保存方法
- (void)saveInfo {
    if (strIsEmpty(self.importTextField.text)) {
        [MBProgressHUDUtil showMessage:@"请填写信息后再保存" toView:self.view];
        return;
    }
    if ([self.navigationStr isEqualToString:@"修改姓名"]) {
        self.parametersDictionary = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                      @"userName":self.importTextField.text};
    }else
    {
        if (![NSString isValidateEmail:self.importTextField.text]) {
            [MBProgressHUDUtil showMessage:@"邮箱格式不正确！" toView:self.view];
            return;
        }
        self.parametersDictionary = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                      @"email":self.importTextField.text};
    }
    
    [WOTHTTPNetwork updateUserInfoWithParameters:self.parametersDictionary photosArray:self.selectedPhotos response:^(id bean, NSError *error) {
        WOTBaseModel *model = (WOTBaseModel *)bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showLoadingWithMessage:@"修改成功" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
                [hud hide:YES afterDelay:1.f complete:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                    
                }];
            }];
        }else {
            [MBProgressHUDUtil showMessage:@"网络出错！" toView:self.view];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

-(UITextField *)importTextField
{
    if (_importTextField == nil) {
        _importTextField = [[UITextField alloc] init];
        _importTextField.placeholder = self.placeholderStr;
    }
    return _importTextField;
}


@end
