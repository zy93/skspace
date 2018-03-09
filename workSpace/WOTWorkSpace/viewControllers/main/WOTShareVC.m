//
//  WOTShareVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTShareVC.h"
#import "YYShareView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MBProgressHUD+Extension.h"

@interface WOTShareVC ()
{
    YYShareView *shareView;
}
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView * iv;
@property (nonatomic, strong) UIButton * btn;
@end

@implementation WOTShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"邀请好友注册";
    self.view.backgroundColor = UIColorFromRGB(0xfce7c9);
    
    self.scrollView = [[UIScrollView alloc] init];
    
    [self.view addSubview:self.scrollView];
    
    UIImage *image = [UIImage imageNamed:@"share_image"];
    
    self.iv = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:self.iv];
//    [self.scrollView setContentSize:CGSizeMake(0, hi)];

    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"立即分享" forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 5.f;
    self.btn.backgroundColor = UICOLOR_MAIN_ORANGE;
    [self.btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(IS_IPHONE_X?88:64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.btn.mas_top).with.offset(-10);
    }];
    
    
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(10);
//        make.height.mas_offset(hi);
        make.bottom.equalTo(self.scrollView.mas_bottom);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.height.mas_offset(40);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(IS_IPHONE_X?-40:-20);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareBtnClick:(UIButton *)sender
{
    if (!shareView) {
        shareView = [[YYShareView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        shareView.propDelegate = self;
        [self.view addSubview:shareView];
    }
    [shareView ShowView];
}

#pragma mark - YYShareViewDelegate methods
-(void)ClickShareWithType:(NSInteger)argType
{
    UMSocialPlatformType socialPlatformType;
    switch (argType)
    {
        case 0:
            socialPlatformType = UMSocialPlatformType_WechatSession;
            break;
        case 1:
            socialPlatformType = UMSocialPlatformType_WechatTimeLine;
            break;
        case 2:
            socialPlatformType = UMSocialPlatformType_QQ;
            break;
        case 3:
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
        case 4:
            socialPlatformType = UMSocialPlatformType_Qzone ;
            break;
        default:
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
    }
    
    NSString *pTitle = @"众创空间";
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = pTitle;
    
    UMShareWebpageObject *pMessageObject = [UMShareWebpageObject shareObjectWithTitle:pTitle descr:@"众创空间" thumImage:[UIImage imageNamed:@"share_icon_image"]];
    pMessageObject.webpageUrl = self.shareUrl;
    messageObject.shareObject = pMessageObject;
    
    if ([[UMSocialManager defaultManager] isInstall:socialPlatformType]) {
        [[UMSocialManager defaultManager] shareToPlatform:socialPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            NSLog(@"%@error",error);
        }];
    }else
    {
        [MBProgressHUDUtil showMessage:@"未安装应用，请安装后分享！" toView:self.view];
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
