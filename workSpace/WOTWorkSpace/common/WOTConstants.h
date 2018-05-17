//
//  WOTConstants.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#ifndef WOTConstants_h
#define WOTConstants_h

//----------------------设备类---------------------------
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)//获取屏幕 宽度
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)//获取屏幕 高度
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_5  (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6  (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#define NavigationHeight IS_IPHONE_X ? 88:64

//判断字符串是否为空
#define strIsEmpty(str) (str == nil || [str length]<1 ? YES : NO )

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//清除颜色
#define UICOLOR_CLEAR [UIColor clearColor]
//白色
#define UICOLOR_WHITE  [UIColor whiteColor]
#define UICOLOR_BLACK  [UIColor blackColor]

#define UICOLOR_MAIN_BACKGROUND UIColorFromRGB(0xf9f9f9) //主背景色
#define UICOLOR_MAIN_TEXT       UIColorFromRGB(0x363636) //主文字颜色(普通文字)
#define UICOLOR_MAIN_BLACK      UIColorFromRGB(0x333333) //黑色，需要突出使用的。
#define UICOLOR_MAIN_ORANGE     UIColorFromRGB(0xff5907) //主橙色
#define UICOLOR_MAIN_PINK       UIColorFromRGB(0xff7171) //主粉色
#define UICOLOR_MAIN_LINE       UIColorFromRGB(0xeeeeee) //主线条使用
#define UICOLOR_GRAY_66     UIColorFromRGB(0x666666) //灰色 中等等级，副标题。
#define UICOLOR_GRAY_99     UIColorFromRGB(0x999999) //灰色 低等标题，深色底纹文字。
#define UICOLOR_GRAY_CC     UIColorFromRGB(0xcccccc) //灰色 最不明显使用。
#define UICOLOR_GRAY_DD     UIColorFromRGB(0xdddddd) //灰色 最不明显使用。
#define UICOLOR_GRAY_E1     UIColorFromRGB(0xe1e1e1) //灰色、
#define UICOLOR_GRAY_F1     UIColorFromRGB(0xf1f1f1) //灰色、
#define UICOLOR_GRAY_b4     UIColorFromRGB(0xf1f1f1) //灰色
#define UICOLOR_MAIN_TEXT_PLACEHOLDER  RGBA(0,0,31,0.22) //输入框底纹颜色

//#define HTTPBaseURL @"http://219.143.170.98:10011"//公网测试
//#define HTTPBaseURL @"http://101.200.32.180" //尚科服务器
//#define HTTPBaseURL @"http://192.168.34.80:8080"
//#define HTTPBaseURL @"http://192.168.1.216:8080"//赵亮亮
//#define HTTPBaseURL @"http://192.168.6.203:8080"//赵亮亮
#define HTTPBaseURL @"http://192.168.1.116:8080"//石宇驰

//集团的appid
//#define YLGTEST_APPID @"c4ca4238a0b923820dcc509a6f75849b"//易联港测试
#define YLGTEST_APPID @"c81e728d9d4c2f636f067f89cc14862c"//海航集团
#define QTWORK_APPID  @"eccbc87e4b5ce2fe28308fd9f2a7baf3"//青藤办公

//支付宝支付2018031602387753
//#define AliPayAPPID @"2017072707916012"
#define AliPayAPPID @"2018031602387753"
//微信支付
#define APPID @"wxb0441ff570e0c9e0"
#define PaySERVER_URL [NSString stringWithFormat:@"http://219.143.170.98:10011/payment/Payment/placeAnOrder"]

#define NOTIFY_URL [NSString stringWithFormat:@"%@/rmb/third_pay/weixin", HTTPBaseURL]
#define PartnerId @"1288580901"
#define Partner_Sign_Key @"sczJpiMw6V3YO1lPOSL9VsrueXwrIEiK"

//NSUserDefault 
#define LOGIN_STATE_USERDEFAULT @"islogin"
#endif /* WOTConstants_h */
