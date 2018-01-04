//
//  RegisterViewController.m
//  LoginDemo
//
//  Created by wangxiaodong on 2017/12/4.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//注册界面

#import "RegisterViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "WOTHTTPNetwork.h"
#import "WOTGetVerifyModel.h"
#import "WOTRegisterModel.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIImageView *registerLogoView;

@property (nonatomic, strong)UIView *registerView;

@property (nonatomic, strong)UIImageView *registerTelImageView;
@property (nonatomic, strong)UITextField *registerTelTextField;

@property (nonatomic, strong)UIView *registerLineView1;

@property (nonatomic, strong)UIImageView *registerPWImageView;
@property (nonatomic, strong)UITextField *registerPWText;

@property (nonatomic, strong)UIView *registerLineView2;

@property (nonatomic, strong)UIImageView *registerAgainPWImageView;
@property (nonatomic, strong)UITextField *registerAgainPWText;

@property (nonatomic, strong)UIView *registerLineView3;

@property (nonatomic, strong)UIImageView *registerVCodeImageView;
@property (nonatomic, strong)UITextField *registerVCodeText;

@property (nonatomic, strong)UIButton *registerGetVCodeButton;
@property (nonatomic, strong)UIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.registerLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_ylg"]];
    self.registerLogoView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.registerLogoView];
    
    self.registerView = [UIView new];
    self.registerView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    self.registerView.layer.cornerRadius = 5.f;
    [self.view addSubview:self.registerView];
    
    self.registerTelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usericon"]];
    self.registerTelImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.registerView addSubview:self.registerTelImageView];
    
    self.registerTelTextField = [[UITextField alloc] init];
    self.registerTelTextField.placeholder = @"请输入您的手机号码";
    [self.registerView addSubview:self.registerTelTextField];
    
    self.registerLineView1 = [UIView new];
    self.registerLineView1.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.registerView addSubview:self.registerLineView1];
    
    self.registerPWImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.registerPWImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.registerView addSubview:self.registerPWImageView];
    
    self.registerPWText = [[UITextField alloc] init];
    self.registerPWText.placeholder = @"请输入密码";
    self.registerPWText.secureTextEntry = YES;
    [self.registerView addSubview:self.registerPWText];
    
    self.registerLineView2 = [UIView new];
    self.registerLineView2.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.registerView addSubview:self.registerLineView2];
    
    self.registerAgainPWImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.registerAgainPWImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.registerView addSubview:self.registerAgainPWImageView];
    
    self.registerAgainPWText = [[UITextField alloc] init];
    self.registerAgainPWText.placeholder = @"请再次输入密码";
    self.registerAgainPWText.secureTextEntry = YES;
    [self.registerView addSubview:self.registerAgainPWText];
    
    self.registerLineView3 = [UIView new];
    self.registerLineView3.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.registerView addSubview:self.registerLineView3];
    
    self.registerVCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vcCode"]];
    self.registerVCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.registerView addSubview:self.registerVCodeImageView];
    
    self.registerVCodeText = [[UITextField alloc] init];
    self.registerVCodeText.placeholder = @"请输入验证码";
    [self.registerView addSubview:self.registerVCodeText];
    
    self.registerGetVCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerGetVCodeButton.layer.cornerRadius = 5.f;
    self.registerGetVCodeButton.layer.borderWidth = 1.f;
    self.registerGetVCodeButton.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
    [self.registerGetVCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.registerGetVCodeButton addTarget:self action:@selector(getRegisterVerificationCode:) forControlEvents:UIControlEventTouchDown];
    self.registerGetVCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.registerGetVCodeButton setTitleColor:[UIColor colorWithHexString:@"#ff7d3d"] forState:UIControlStateNormal];
    self.registerButton.titleLabel.textColor = [UIColor colorWithHexString:@"#ff7d3d"];
    self.registerButton.layer.cornerRadius = 5.f;
    self.registerButton.layer.borderWidth = 1.f;
    self.registerButton.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
    [self.registerView addSubview:self.registerGetVCodeButton];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerButtonMethod) forControlEvents:UIControlEventTouchDown];
    self.registerButton.layer.cornerRadius = 5.f;
    self.registerButton.layer.borderWidth = 1.f;
    self.registerButton.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
    [self.registerButton setBackgroundColor:[UIColor colorWithHexString:@"#ff7d3d"]];
    [self.view addSubview:self.registerButton];
}

-(void)viewDidLayoutSubviews
{
    [self.registerLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(50);
    }];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerLogoView.mas_bottom).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(200);
    }];
    
    [self.registerTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerView).with.offset(10);
        make.top.equalTo(self.registerView).with.offset(25);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.registerTelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.registerTelImageView);
        make.left.equalTo(self.registerTelImageView.mas_right);
        make.right.equalTo(self.registerView);
    }];
    
    [self.registerLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerTelTextField.mas_bottom).with.offset(10);
        make.left.equalTo(self.registerView).with.offset(20);
        make.right.equalTo(self.registerView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.registerVCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerView).with.offset(10);
        make.top.equalTo(self.registerLineView1).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.registerVCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.registerVCodeImageView);
        make.left.equalTo(self.registerVCodeImageView.mas_right);
        make.width.mas_equalTo(150);
        //make.right.equalTo(self.registerView);
    }];
    
    [self.registerGetVCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.registerVCodeImageView);
        //make.left.equalTo(self.registerVCodeText.mas_right);
        make.right.equalTo(self.registerView).with.offset(-20);
        //make.width.mas_equalTo(100);
    }];
    
    [self.registerLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerVCodeText.mas_bottom).with.offset(10);
        make.left.equalTo(self.registerView).with.offset(20);
        make.right.equalTo(self.registerView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.registerPWImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerView).with.offset(10);
        make.top.equalTo(self.registerLineView2).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.registerPWText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.registerPWImageView);
        make.left.equalTo(self.registerPWImageView.mas_right);
        make.right.equalTo(self.registerView);
    }];
    
    [self.registerLineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerPWText.mas_bottom).with.offset(10);
        make.left.equalTo(self.registerView).with.offset(20);
        make.right.equalTo(self.registerView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.registerAgainPWImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerView).with.offset(10);
        make.top.equalTo(self.registerLineView3).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.registerAgainPWText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.registerAgainPWImageView);
        make.left.equalTo(self.registerAgainPWImageView.mas_right);
        make.right.equalTo(self.registerView);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerView.mas_bottom).with.offset(10);
        make.right.equalTo(self.view).with.offset(-40);
        make.left.equalTo(self.view).with.offset(40);
        make.height.mas_equalTo(48);
    }];
}

#pragma mark - 获取验证码方法
-(void)getRegisterVerificationCode:(UIButton *)button
{
    BOOL isTel = [self.registerTelTextField.text isEqualToString:@""] || self.registerTelTextField.text == NULL;
    if (isTel) {
        [MBProgressHUDUtil showMessage:@"请输入手机号！" toView:self.view];
        return;
    }
    [self openCountdown:button];
    
    [WOTHTTPNetwork userGetVerifyWitTel:self.registerTelTextField.text response:^(id bean, NSError *error) {
        
        WOTGetVerifyModel *model = bean;
        if (model.code.intValue == 200) {
            [MBProgressHUDUtil showMessage:@"发送成功" toView:self.view];
        }
        else {
            [MBProgressHUDUtil showMessage:model.result toView:self.view];
        }
    }];
    
}

#pragma mark - 注册按钮
-(void)registerButtonMethod
{
    BOOL isTel = [self.registerTelTextField.text isEqualToString:@""] || self.registerTelTextField.text == NULL;
    BOOL isVerifyCode = [self.registerVCodeText.text isEqualToString:@""] || self.registerVCodeText.text == NULL;
    BOOL isPassWord = [self.registerPWText.text isEqualToString:@""] || self.registerPWText.text == NULL;
    BOOL isAgainPassWord = [self.registerAgainPWText.text isEqualToString:@""] || self.registerAgainPWText.text == NULL;
    if (isTel || isVerifyCode || isPassWord || isAgainPassWord) {
        [MBProgressHUDUtil showMessage:@"请输入完整信息！" toView:self.view];
        return;
    }
    
    [WOTHTTPNetwork userRegisterWitVerifyCode:self.registerVCodeText.text tel:self.registerTelTextField.text password:self.registerPWText.text alias:[NSString stringWithFormat:@"%@C",self.registerTelTextField.text] response:^(id bean, NSError *error) {
        WOTRegisterModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"注册成功" toView:self.view];
            //跳转登陆界面
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [MBProgressHUDUtil showMessage:model.result toView:self.view];
        }
    }];
}

-(void)openCountdown:(UIButton *)button
{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [button setTitle:@"重新发送" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithHexString:@"#ff7d3d"] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
                button.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [button setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor grayColor].CGColor;
                button.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
