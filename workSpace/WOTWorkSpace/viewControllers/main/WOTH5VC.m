//
//  WOTH5VC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTH5VC.h"
#import "YYShareView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MBProgressHUD+Extension.h"


@interface WOTH5VC () <YYShareViewDelegate>
{
    YYShareView *shareView;
}

@end

@implementation WOTH5VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self congigNav];
    self.web.opaque = NO;//dong
    self.web.backgroundColor = [UIColor clearColor];//dong
    if (self.url == nil) {
        self.url = @"http://www.yiliangang.net:8012/makerSpace/news1.html";
    }

    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)congigNav{
    self.navigationItem.title = @"详情";
    [self.navigationController.navigationBar setHidden:NO];
    //
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareDetail)];
    [self.navigationItem setRightBarButtonItem:shareItem];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}
-(void)setUrl:(NSString *)url
{
    _url = url;
    if (!url) {
        _url = @"http://219.143.170.98:10011/makerSpace/activity.html";
    }
}

-(void)shareDetail
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
            socialPlatformType = UMSocialPlatformType_Qzone;
            break;
        case 4:
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
        default:
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
    }
    NSString *pTitle = @"众创空间";
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = pTitle;
    
    UMShareWebpageObject *pMessageObject = [UMShareWebpageObject shareObjectWithTitle:pTitle descr:@"众创空间" thumImage:[UIImage imageNamed:@"space_bj"]];
    pMessageObject.webpageUrl = [NSString stringWithFormat:@"%@",@"www.baidu.com"];
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
