//
//  FindPassWordViewController.m
//  LoginDemo
//
//  Created by wangxiaodong on 2017/12/4.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//找回密码界面

#import "FindPassWordViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "WOTRegisterModel.h"
#import "WOTGetVerifyModel.h"

@interface FindPassWordViewController ()

@property (nonatomic, strong)UIView *findView;
@property (nonatomic, strong)UIImageView *findTelImageView;
@property (nonatomic, strong)UITextField *findTelTextField;
@property (nonatomic, strong)UIView *findLineView1;
@property (nonatomic, strong)UIImageView *findPWImageView;
@property (nonatomic, strong)UITextField *findPWText;
@property (nonatomic, strong)UIView *findLineView2;
@property (nonatomic, strong)UIImageView *findAgainPWImageView;
@property (nonatomic, strong)UITextField *findAgainPWText;
@property (nonatomic, strong)UIView *findLineView3;
@property (nonatomic, strong)UIImageView *findVCodeImageView;
@property (nonatomic, strong)UITextField *findVCodeText;
@property (nonatomic, strong)UIButton *findGetVCodeButton;
@property (nonatomic, strong)UIButton *confirmButton;

@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.findView = [UIView new];
    self.findView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    self.findView.layer.cornerRadius = 5.f;
    [self.view addSubview:self.findView];
    
    self.findTelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usericon"]];
    self.findTelImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.findView addSubview:self.findTelImageView];
    
    self.findTelTextField = [[UITextField alloc] init];
    self.findTelTextField.placeholder = @"请输入您的手机号码";
    [self.findView addSubview:self.findTelTextField];
    
    self.findLineView1 = [UIView new];
    self.findLineView1.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.findView addSubview:self.findLineView1];
    
    self.findPWImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.findPWImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.findView addSubview:self.findPWImageView];
    
    self.findPWText = [[UITextField alloc] init];
    self.findPWText.placeholder = @"请输入密码";
    self.findPWText.secureTextEntry = YES;
    [self.findView addSubview:self.findPWText];
    
    self.findLineView2 = [UIView new];
    self.findLineView2.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.findView addSubview:self.findLineView2];
    
    self.findAgainPWImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.findAgainPWImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.findView addSubview:self.findAgainPWImageView];
    
    self.findAgainPWText = [[UITextField alloc] init];
    self.findAgainPWText.placeholder = @"请再次输入密码";
    self.findAgainPWText.secureTextEntry = YES;
    [self.findView addSubview:self.findAgainPWText];
    
    self.findLineView3 = [UIView new];
    self.findLineView3.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.findView addSubview:self.findLineView3];
    
    self.findVCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vcCode"]];
    self.findVCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.findView addSubview:self.findVCodeImageView];
    
    self.findVCodeText = [[UITextField alloc] init];
    self.findVCodeText.placeholder = @"请输入验证码";
    [self.findView addSubview:self.findVCodeText];
    
    self.findGetVCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.findGetVCodeButton.layer.cornerRadius = 5.f;
    self.findGetVCodeButton.layer.borderWidth = 1.f;
    self.findGetVCodeButton.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
    [self.findGetVCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.findGetVCodeButton addTarget:self action:@selector(getFindVerificationCode:) forControlEvents:UIControlEventTouchDown];
    self.findGetVCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.findGetVCodeButton setTitleColor:[UIColor colorWithHexString:@"#ff7d3d"] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.textColor = [UIColor colorWithHexString:@"#ff7d3d"];
    self.confirmButton.layer.cornerRadius = 5.f;
    self.confirmButton.layer.borderWidth = 1.f;
    self.confirmButton.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
    [self.findView addSubview:self.findGetVCodeButton];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonMethod) forControlEvents:UIControlEventTouchDown];
    self.confirmButton.layer.cornerRadius = 5.f;
    self.confirmButton.layer.borderWidth = 1.f;
    self.confirmButton.layer.borderColor = [UIColor colorWithHexString:@"#ff7d3d"].CGColor;
    [self.confirmButton setBackgroundColor:[UIColor colorWithHexString:@"#ff7d3d"]];
    [self.view addSubview:self.confirmButton];
}

-(void)viewDidLayoutSubviews
{
    
    [self.findView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(200);
    }];
    
    [self.findTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.findView).with.offset(10);
        make.top.equalTo(self.findView).with.offset(25);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.findTelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.findTelImageView);
        make.left.equalTo(self.findTelImageView.mas_right);
        make.right.equalTo(self.findView);
    }];
    
    [self.findLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.findTelTextField.mas_bottom).with.offset(10);
        make.left.equalTo(self.findView).with.offset(20);
        make.right.equalTo(self.findView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.findVCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.findView).with.offset(10);
        make.top.equalTo(self.findLineView1).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.findVCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.findVCodeImageView);
        make.left.equalTo(self.findVCodeImageView.mas_right);
        make.width.mas_equalTo(150);
        //make.right.equalTo(self.registerView);
    }];
    
    [self.findGetVCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.findVCodeImageView);
        //make.left.equalTo(self.findVCodeText.mas_right);
        make.right.equalTo(self.findView).with.offset(-20);
        //make.width.mas_equalTo(100);
    }];
    
    [self.findLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.findVCodeText.mas_bottom).with.offset(10);
        make.left.equalTo(self.findView).with.offset(20);
        make.right.equalTo(self.findView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.findPWImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.findView).with.offset(10);
        make.top.equalTo(self.findLineView2).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.findPWText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.findPWImageView);
        make.left.equalTo(self.findPWImageView.mas_right);
        make.right.equalTo(self.findView);
    }];
    
    [self.findLineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.findPWText.mas_bottom).with.offset(10);
        make.left.equalTo(self.findView).with.offset(20);
        make.right.equalTo(self.findView).with.offset(-20);
        make.height.mas_offset(1);
    }];
    
    [self.findAgainPWImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.findView).with.offset(10);
        make.top.equalTo(self.findLineView3).with.offset(15);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.findAgainPWText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.findAgainPWImageView);
        make.left.equalTo(self.findAgainPWImageView.mas_right);
        make.right.equalTo(self.findView);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.findView.mas_bottom).with.offset(10);
        make.right.equalTo(self.view).with.offset(-40);
        make.left.equalTo(self.view).with.offset(40);
        make.height.mas_equalTo(48);
    }];
}

#pragma mark - 获取验证码
-(void)getFindVerificationCode:(UIButton *)button
{
    BOOL isTel = [self.findTelTextField.text isEqualToString:@""] || self.findTelTextField.text == NULL;
    if (isTel) {
        [MBProgressHUDUtil showMessage:@"请输入手机号！" toView:self.view];
        return;
    }
    [self openCountdown:button];
    
    [WOTHTTPNetwork userGetVerifyWitTel:self.findTelTextField.text response:^(id bean, NSError *error) {
        
        WOTGetVerifyModel *model = bean;
        if (model.code.intValue == 200) {
            [MBProgressHUDUtil showMessage:@"发送成功" toView:self.view];
        }
        else {
            [MBProgressHUDUtil showMessage:model.result toView:self.view];
        }
    }];
    
    
    
}


#pragma mark - 确定
-(void)confirmButtonMethod
{
    BOOL isTel = [self.findTelTextField.text isEqualToString:@""] || self.findTelTextField.text == NULL;
    BOOL isVerifyCode = [self.findVCodeText.text isEqualToString:@""] || self.findVCodeText.text == NULL;
    BOOL isPassWord = [self.findPWText.text isEqualToString:@""] || self.findPWText.text == NULL;
    BOOL isAgainPassWord = [self.findAgainPWText.text isEqualToString:@""] || self.findAgainPWText.text == NULL;
    if (isTel || isVerifyCode || isPassWord || isAgainPassWord) {
        [MBProgressHUDUtil showMessage:@"请输入完整信息！" toView:self.view];
        return;
    }
    
    [WOTHTTPNetwork userRegisterWitVerifyCode:self.findVCodeText.text tel:self.findTelTextField.text password:self.findPWText.text
                                     alias:[NSString stringWithFormat:@"%@C",self.findTelTextField.text] invitationCode:nil  response:^(id bean, NSError *error) {
        WOTRegisterModel *model = bean;
        if ([model.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"修改成功" toView:self.view];
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

@end
