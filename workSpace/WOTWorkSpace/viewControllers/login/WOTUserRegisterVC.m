//
//  WOTUserRegisterVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserRegisterVC.h"
#import "WOTSelectCityCodeVC.h"
#import "WOTRegisterModel.h"
#import "WOTGetVerifyModel.h"
#import "MBProgressHUD+Extension.h"

@interface WOTUserRegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *selectCityBtn;

@property (weak, nonatomic) IBOutlet UILabel *cityCodeLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *verificationPasswordText;

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeText;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerProcotol;

@end

@implementation WOTUserRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.registerBtn.layer.cornerRadius = 8;
    self.registerBtn.layer.borderColor = UIColorFromRGB(0x4088ef).CGColor;
    self.registerBtn.layer.borderWidth = 1.f;
    
    self.getVerificationCodeBtn.layer.cornerRadius = 8;
    self.getVerificationCodeBtn.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
    self.getVerificationCodeBtn.layer.borderWidth = 1.f;
    
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [[WOTConfigThemeUitls shared] setHiddenKeyboardBlcok:^{
      
        [self hiddleKeyboard];
        
    }];
    _phoneText.delegate = self;
    _passwordText.delegate = self;
    _verificationPasswordText.delegate = self;
    _verificationCodeText.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    if (self.cityName) {
        [self.selectCityBtn setTitle:self.cityName forState:UIControlStateNormal];
        [self.cityCodeLab setText:self.cityCode];
    }
    
}

#pragma mark - action

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSelectBtn:(id)sender {
    WOTSelectCityCodeVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectCityCodeVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickGetVerificationCodeBtn:(id)sender {
    if (strIsEmpty(self.phoneText.text)) {
        [MBProgressHUDUtil showMessage:@"请输入完整的电话号码" toView:self.view];
        
    } else {
        if (![NSString valiMobile:self.phoneText.text]) {
            [MBProgressHUDUtil showMessage:@"电话格式不正确！" toView:self.view];
            return;
        }
        if (strIsEmpty(self.passwordText.text)) {
            [MBProgressHUDUtil showMessage:@"请设置密码" toView:self.view];
        } else {
            if (strIsEmpty(self.verificationPasswordText.text)) {
                [MBProgressHUDUtil showMessage:@"请填写确认密码" toView:self.view];
            } else {
                    [WOTHTTPNetwork userGetVerifyWitTel:self.phoneText.text response:^(id bean, NSError *error) {
                        
                        WOTGetVerifyModel *model = bean;
                        if (model.code.intValue == 200) {
                            [self openCountdown];
                            [MBProgressHUDUtil showMessage:@"发送成功" toView:self.view];
                        }
                        else {
                            [MBProgressHUDUtil showMessage:model.result toView:self.view];
                        }
                    }];
                    
                
                
            }
        }
    }
    
}

- (IBAction)clickRegisterBtn:(id)sender {
    if (strIsEmpty(self.phoneText.text)) {
        [MBProgressHUDUtil showMessage:@"请输入完整的电话号码" toView:self.view];
        return;
    }else
    {
        if (![NSString valiMobile:self.phoneText.text]) {
            [MBProgressHUDUtil showMessage:@"电话格式不正确！" toView:self.view];
            return;
        }
    }
    
    if (strIsEmpty(self.passwordText.text)) {
        [MBProgressHUDUtil showMessage:@"请设置密码" toView:self.view];
        return;
    } else {
        if (strIsEmpty(self.verificationPasswordText.text)) {
            
            [MBProgressHUDUtil showMessage:@"请填写确认密码" toView:self.view];
            return;
        }
    }
    if (strIsEmpty(self.verificationCodeText.text)) {
        return;
        [MBProgressHUDUtil showMessage:@"请填写正确的验证码" toView:self.view];
    }
    else if (![self.passwordText.text isEqualToString:self.verificationPasswordText.text]) {
        [MBProgressHUDUtil showMessage:@"两次密码不一致！" toView:self.view];
        return;
    }
    else {
        {
            
            [WOTHTTPNetwork userRegisterWitVerifyCode:self.verificationCodeText.text tel:self.phoneText.text password:self.passwordText.text response:^(id bean, NSError *error) {
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
    }
    
}

- (IBAction)clickProcotolBtn:(id)sender {
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddleKeyboard];
    return YES;
}


-(void)hiddleKeyboard{
    [_phoneText resignFirstResponder];
    [_passwordText resignFirstResponder];
    [_verificationCodeText resignFirstResponder];
    [_verificationPasswordText resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneText resignFirstResponder];
    [_passwordText resignFirstResponder];
    [_verificationCodeText resignFirstResponder];
    [_verificationPasswordText resignFirstResponder];
}

//开启倒计时结果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.getVerificationCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
//                [self.authCodeBtn setTitleColor:[UIColor colorFromHexCode:@"FB8557"] forState:UIControlStateNormal];
                self.getVerificationCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.getVerificationCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
//                [self.authCodeBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
                self.getVerificationCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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
