//
//  WOTGETServiceViewController.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTGETServiceViewController.h"
#import "WOTServiceProvidersCategoryVC.h"
#define DescribeTextViewPlaceHolder @"请填写你的需求"
@interface WOTGETServiceViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *describeText;
@property (weak, nonatomic) IBOutlet UIButton *selectServiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *tagsView;

@end

@implementation WOTGETServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    _describeText.delegate  = self;
    _describeText.text = DescribeTextViewPlaceHolder;
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [WOTConfigThemeUitls shared].hiddenKeyboardBlcok = ^(){
        [self.describeText resignFirstResponder];
        self.describeText.textColor = LowTextColor;
        if ([_describeText.text isEqualToString:@""] || [_describeText.text isEqualToString:DescribeTextViewPlaceHolder]) {
            self.describeText.text = DescribeTextViewPlaceHolder;
        }
        
    };
    [_describeText setCorenerRadius:10.0 borderColor:CLEARCOLOR];
    [_describeText setBackgroundColor:RGB(246.0, 246.0, 246.0)];
    
    self.submitBtn.layer.cornerRadius = 5.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"获取服务";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"----- %@", self.selectServiceList);
}

#pragma mark - action 
- (IBAction)clickSelectServiceBtn:(id)sender {
    for (UIView *view in self.tagsView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    WOTServiceProvidersCategoryVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTServiceProvidersCategoryVC"];

    vc.selectServiceBlock = ^(NSArray *selectedServices){
    
        [[WOTConfigThemeUitls shared] loadtagsBtn:selectedServices superView:self.tagsView];
        [self viewWillLayoutSubviews];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickSubmitBtn:(id)sender {
    BOOL isLogin = [WOTUserSingleton shareUser].userInfo.userId == nil;
    if (isLogin) {
        [MBProgressHUDUtil showMessage:@"请先登录！" toView:self.view];
        return;
    }
    
    if ([_describeText.text isEqualToString:@""] || self.selectServiceList.count == 0) {
        [MBProgressHUDUtil showMessage:UnInputServiceContentReminding toView:self.view];
    } else {
//        [[WOTUserSingleton shareUser] setValues];
        NSString *dd = @"";
        for (NSString *text in _selectServiceList) {
            dd = [NSString stringWithFormat:@"%@%@%@",dd,text,@","];
        }

        
//        [WOTHTTPNetwork postServiceRequestWithDescribe:[self.describeText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] spaceId:[@"55" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] userId:[[WOTUserSingleton shareUser].userInfo.userId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] facilitatorType:[dd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] facilitatorLabel:[dd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] response:^(id bean, NSError *error) {
//            
//        }];
        
                [WOTHTTPNetwork postServiceRequestWithDescribe:self.describeText.text spaceId:@"55"
                                                        userId:[WOTUserSingleton shareUser].userInfo.userId facilitatorType:dd  facilitatorLabel:dd response:^(id bean, NSError *error) {
                                                           [MBProgressHUDUtil showMessage:SubmitReminding toView:self.view]; dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                [self.navigationController popViewControllerAnimated:YES];
                                                            });
                }];
        
    }
   
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _describeText.textColor = Black;
    if ([_describeText.text isEqualToString:DescribeTextViewPlaceHolder]) {
        _describeText.text = @"";
    }
    
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
