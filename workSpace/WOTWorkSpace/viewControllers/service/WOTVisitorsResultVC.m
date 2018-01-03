//
//  WOTVisitorsResultVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/3.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTVisitorsResultVC.h"

@interface WOTVisitorsResultVC ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *resultLab;
@property (weak, nonatomic) IBOutlet UIButton *gotoMainVCBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

@end

@implementation WOTVisitorsResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gotoMainVCBtn.layer.cornerRadius = 4.f;
    self.gotoMainVCBtn.layer.borderColor = UIColor_black_b3.CGColor;
    self.gotoMainVCBtn.layer.borderWidth = 0.5f;
    
    self.otherBtn.layer.cornerRadius = 4.f;
    self.otherBtn.layer.borderColor = UIColor_black_b3.CGColor;
    self.otherBtn.layer.borderWidth = 0.5f;
    
    
    if (self.isSuccess) {
        [self.iconIV setImage:[UIImage imageNamed:@"success"]];
        self.resultLab.text = @"您的预约申请已发送，请等待对方审核结果";
        [self.otherBtn setTitle:@"查看我的预约" forState:UIControlStateNormal];
    }
    else {
        [self.iconIV setImage:[UIImage imageNamed:@"fail"]];
        self.resultLab.text = @"您的预约申请失败，请稍后再试";
        [self.otherBtn setTitle:@"返回" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action

- (IBAction)gotoMainVCBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)otherBtn:(id)sender {
    if (self.isSuccess) {
        
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
