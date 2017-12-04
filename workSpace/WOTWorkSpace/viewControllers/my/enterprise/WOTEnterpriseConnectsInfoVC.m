//
//  WOTEnterpriseConnectsInfoVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseConnectsInfoVC.h"

@interface WOTEnterpriseConnectsInfoVC ()<UITextFieldDelegate>

@end

@implementation WOTEnterpriseConnectsInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bgview setCorenerRadius:10 borderColor:CLEARCOLOR];
    _nameTextfield.delegate  = self;
    _telTextfield.delegate = self;
    _emailTextfield.delegate = self;
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [WOTConfigThemeUitls shared].hiddenKeyboardBlcok = ^(){
        [self keyboardHidden];
    };

    
  
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelClick:(id)sender {
    if (_cancelBlokc) {
        self.cancelBlokc();
    }
   
    [self keyboardHidden];
}


- (IBAction)okClick:(id)sender {
    if (_okBlock) {
        self.okBlock(self.nameTextfield.text, self.telTextfield.text, self.emailTextfield.text);
    }
    [self keyboardHidden];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


-(void)keyboardHidden{
    [_nameTextfield resignFirstResponder];
    [_telTextfield resignFirstResponder];
    [_emailTextfield resignFirstResponder];
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
