//
//  WOTFeedbackVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTFeedbackVC.h"
#define FeedTextViewPlaceholder @"*您的意见，是我们前进的动力"
@interface WOTFeedbackVC ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *customerServiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation WOTFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.delegate = self;
    _phoneText.delegate = self;
    // Do any additional setup after loading the view.
    [self configNav];
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [WOTConfigThemeUitls shared].hiddenKeyboardBlcok = ^(){
        [self.textView resignFirstResponder];
        [self.phoneText resignFirstResponder];
        _textView.textColor = LowTextColor;
        if ([_textView.text isEqualToString:@""]||[_textView.text isEqualToString:FeedTextViewPlaceholder]) {
            _textView.text = FeedTextViewPlaceholder;
        }
        
    };
    self.submitBtn.layer.cornerRadius = 5.f;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)configNav{
    self.navigationItem.title = @"意见反馈";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (IBAction)callCustomerServices:(id)sender {
    
    //TODO:打电话给客服
}





- (IBAction)submitFeedbackInfo:(id)sender {
    
    if ([_textView.text isEqualToString:@""]){
        [MBProgressHUDUtil showMessage:UnInputFeedbackContentReminding toView:self.view ];
    } else{
//        [[WOTUserSingleton shareUser]setValues];
        
         [WOTHTTPNetwork postFeedBackInfoWithContent:self.textView.text spaceId:[[NSNumber alloc]initWithInt:57] userId:[[NSNumber alloc]initWithInt:[[WOTUserSingleton shareUser].userInfo.userId intValue]] userName:[WOTUserSingleton shareUser].userInfo.userName tel:self.phoneText.text  response:^(id bean, NSError *error) {
             if (bean) {
                 [MBProgressHUDUtil showMessage:((WOTBaseModel *)bean).result toView:self.view];
             }
             if (error) {
                 [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
             }
         }];
    }
        
 
  
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    [self.phoneText resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([_textView.text isEqualToString:FeedTextViewPlaceholder]) {
        _textView.text = @"";
    }
    
    
    _textView.textColor = Black;
    return YES;
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
