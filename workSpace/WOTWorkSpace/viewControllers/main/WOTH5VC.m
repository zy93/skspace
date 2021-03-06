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


@interface WOTH5VC () <YYShareViewDelegate,UIWebViewDelegate>
{
    YYShareView *shareView;
}

@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation WOTH5VC

+(WOTH5VC *)loadH5VC
{
    WOTH5VC *h5vc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    return h5vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self congigNav];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.customView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    [_HUD showAnimated:YES];
    self.web.opaque = NO;//dong
    self.web.backgroundColor = [UIColor clearColor];//dong
    if (self.url == nil) {
        self.url = @"http://www.yiliangang.net:8012/makerSpace/news1.html";
    }
    self.web.delegate = self;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - 内容读入结束
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_HUD removeFromSuperview];
}


-(void)congigNav{
    self.navigationItem.title = @"详情";
    //
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareDetail)];
    [self.navigationItem setRightBarButtonItem:shareItem];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


-(void)setUrl:(NSString *)url
{
    _url = url;
    if (!url) {
        //_url = @"http://101.200.32.180/makerSpace/activity.html";
        _url = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/makerSpace/activity.html"];
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
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
        case 4:
            socialPlatformType = UMSocialPlatformType_Qzone ;
            break;
        default:
            socialPlatformType = UMSocialPlatformType_Sina;
            break;
    }
    
    NSString *pTitle;// = @"尚科区";
    if (strIsEmpty(self.titleStr)) {
        pTitle = @"尚科社区";
    }else
    {
        pTitle = self.titleStr;
    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = pTitle;
    
    UMShareWebpageObject *pMessageObject = [UMShareWebpageObject shareObjectWithTitle:pTitle descr:self.infoStr thumImage:[UIImage imageNamed:@"share_icon_image"]];
    pMessageObject.webpageUrl = self.url;
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

-(void)dealloc
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
