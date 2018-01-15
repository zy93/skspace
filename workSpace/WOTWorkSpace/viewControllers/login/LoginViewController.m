//
//  LoginViewController.m
//  LoginDemo
//
//  Created by git on 2017/12/1.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//登录界面

#import "LoginViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"


@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView *userTelView;
@property (nonatomic, strong) UIImageView *userTelImageView;
@property (nonatomic, strong) UITextField *userTelField;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *verificationCodeImageView;
@property (nonatomic, strong) UITextField *verificationCodeField;

@property (nonatomic, strong) UIButton *rememberPasswordButton;
@property (nonatomic, strong) UILabel *rememberPasswordLabel;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetPasswordButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_ylg"]];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.logoImageView];
    self.navigationItem.title = @"登录";

    self.userTelView = [UIView new];
    self.userTelView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    self.userTelView.layer.cornerRadius = 5.f;
    [self.view addSubview:self.userTelView];
    
    
    self.userTelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usericon"]];
    self.userTelImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.userTelView addSubview:self.userTelImageView];
    
    self.userTelField = [[UITextField alloc] init];
    self.userTelField.delegate = self;
    self.userTelField.placeholder = @"请输入手机号";
    [self.userTelView addSubview:self.userTelField];
    
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.userTelView addSubview:self.lineView];
    
    self.verificationCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.verificationCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.userTelView addSubview:self.verificationCodeImageView];
    
    self.verificationCodeField = [[UITextField alloc] init];
    self.verificationCodeField.delegate = self;
    self.verificationCodeField.placeholder = @"请输入密码";
    self.verificationCodeField.secureTextEntry = YES;
    [self.userTelView addSubview:self.verificationCodeField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton addTarget:self action:@selector(loginButtonMethod) forControlEvents:UIControlEventTouchDown];
    [self.loginButton setImage:[UIImage imageNamed:@"loginbutton"] forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    
    self.rememberPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rememberPasswordButton setBackgroundImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    [self.rememberPasswordButton addTarget:self action:@selector(rememberPasswordButtonMethod:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.rememberPasswordButton];
    
    self.rememberPasswordLabel = [[UILabel alloc] init];
    self.rememberPasswordLabel.text = @"下次自动登录";
    self.rememberPasswordLabel.textColor = [UIColor grayColor];
    [self.rememberPasswordLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.view addSubview:self.rememberPasswordLabel];
    
    self.forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [self.forgetPasswordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.forgetPasswordButton addTarget:self action:@selector(findPassWordMethod) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.forgetPasswordButton];
    
    self.middleView = [UIView new];
    [self.view addSubview:self.middleView];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerButton addTarget:self action:@selector(registerButtonMethod) forControlEvents:UIControlEventTouchDown];
    [self.registerButton setImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    [self.view addSubview:self.registerButton];
}
-(void)viewDidLayoutSubviews
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(50);
    }];
    
    [self.userTelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(100);
    }];
    
    [self.userTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTelView).with.offset(10);
        make.top.equalTo(self.userTelView).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.userTelField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userTelImageView);
        make.left.equalTo(self.userTelImageView.mas_right);
        make.right.equalTo(self.userTelView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userTelView);
        make.left.equalTo(self.userTelView).with.offset(20);
        make.right.equalTo(self.userTelView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.verificationCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTelView).with.offset(10);
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.verificationCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.left.equalTo(self.verificationCodeImageView.mas_right);
        make.right.equalTo(self.userTelView);
    }];
    
    [self.rememberPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTelView.mas_bottom).with.offset(20);
        make.left.equalTo(self.userTelView);
        make.height.width.with.mas_equalTo(15);
    }];
    
    [self.rememberPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPasswordButton.mas_top);
        make.left.equalTo(self.rememberPasswordButton.mas_right).with.offset(5);
        make.centerY.equalTo(self.rememberPasswordButton);
    }];
    
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPasswordButton.mas_top);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberPasswordLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(5);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetPasswordButton.mas_bottom).with.offset(30);
        make.right.equalTo(self.middleView.mas_left);
        //make.left.equalTo(self.view).with.offset(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgetPasswordButton.mas_bottom).with.offset(30);
        make.left.equalTo(self.middleView.mas_right);
        make.height.mas_equalTo(40);
    }];
}


-(void)rememberPasswordButtonMethod:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        [self.rememberPasswordButton setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
    else
    {
        [self.rememberPasswordButton setBackgroundImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}


#pragma mark - 登录
-(void)loginButtonMethod
{
    BOOL isUserTel = [self.userTelField.text isEqualToString:@""] || self.userTelField.text ==NULL;
    BOOL isPassWord = [self.verificationCodeField.text isEqualToString:@""] || self.userTelField.text == NULL;
    if (isUserTel || isPassWord) {
        [MBProgressHUDUtil showMessage:@"请填写完整信息！" toView:self.view];
        return;
    }
    
    if (![NSString valiMobile:self.userTelField.text]) {
        [MBProgressHUDUtil showMessage:@"电话格式不正确！" toView:self.view];
        return;
    }
    [WOTHTTPNetwork userLoginWithTelOrEmail:self.userTelField.text password:self.verificationCodeField.text alias:[NSString stringWithFormat:@"%@C",self.userTelField.text] response:^(id bean,NSError *error) {
        NSLog(@"");
        if (bean) {
            WOTLoginModel_msg *model = (WOTLoginModel_msg *)bean;
            NSLog(@"登陆%@",model.msg);
            if ([model.code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                    [[WOTUserSingleton shareUser] saveUserInfoToPlistWithModel:model.msg];
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:LOGIN_STATE_USERDEFAULT];
                    [WOTSingtleton shared].isuserLogin = YES;
                });
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"是否登陆：%d",[WOTSingtleton shared].isuserLogin);
                   // [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                [MBProgressHUDUtil showMessage:model.result toView:self.view];
            }
            
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
}

#pragma mark - 注册
-(void)registerButtonMethod
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


#pragma mark - 忘记密码
-(void)findPassWordMethod
{
    FindPassWordViewController *findVC = [[FindPassWordViewController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
