//
//  WOTOpenDoorVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOpenDoorVC.h"
#import "HCScanQRViewController.h"
#import "HCCreateQRCode.h"

@interface WOTOpenDoorVC ()
@property (weak, nonatomic) IBOutlet UIView *QRBgView;
@property (weak, nonatomic) IBOutlet UIImageView *QRIV;

@end

@implementation WOTOpenDoorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"人傻是打发斯蒂芬人傻是打发斯蒂芬人傻是打发斯蒂芬人傻是打发斯蒂芬人傻是打发斯蒂芬";
    UIImage *im = [HCCreateQRCode createQRCodeWithString:str ViewController:self];
    
    [self.QRIV setImage:im];
    
    //加阴影
    self.QRBgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.QRBgView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.QRBgView.layer.shadowRadius = 8;//阴影半径，默认3
    self.QRBgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showView:(UIViewController *)vc
{
    [vc.view addSubview:self.view];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.destinationViewController isKindOfClass:[segue.destinationViewController class]]) {
        HCScanQRViewController *vc = (HCScanQRViewController *)segue.destinationViewController;
        [vc successfulGetQRCodeInfo:^(NSString *QRCodeInfo) {
            NSLog(@"QR Info : %@", QRCodeInfo);
            [vc dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
}


@end
