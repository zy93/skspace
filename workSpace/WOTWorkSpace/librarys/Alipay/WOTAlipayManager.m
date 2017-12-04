//
//  WOTAlipayManager.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTAlipayManager.h"
#import "WOTOrderModel.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "WOTOrderModel.h"


#define AlipayPartner    @"2088311095912814"
#define AlipaySeller     @"cypacypa@163.com"
#define AlipayScheme    @"cypapartment"
#define AlipayPrivateKey    @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAN35+ZhIvN/PBF8Ad1yQ6OkBUwbVD0d5rD5YD5HkKtuh1cd+Nrrsp6L79EeVvNcarezaLOlyB6b0drI+DGg6mVzK5XzlZaxcIIo1KzLobKdYGZORWduBkIAdn52kvDlMIIWOJw7L0Dekqd9TMK7GPIEbrmH/D3u5hrCqYK6AULu/AgMBAAECgYAYPNdYHXkiJwSfKvndjaUg7BgYwuLsNwjrtcndcECNwtoI8msfdf/H+CLwPhVk3EuT5Rf2Sekv0TGqafJKbzdBNExgmrUfghKUZyIXlxbXcFoF9boo6AJknFQ3guT+oiTxy8P/M3KOveCW9mbsUCpmY7LvoWXF+0nJDbfMisPwQJBAP3YoQgtx+LVyPiqAsidbAfgxJXa0hd97bphZHkY93xNIrTO2v9/G8htMh2fbV0sS7VS5XWVIU1ejBS1ndNT+EcCQQDf3B9rcb4X0K5HkG2yB0OJk3c4NHdddLF+eKGnZoL9Bj7wtfXXjtFsRe4ytOcoOlHwkxrBPOgtVBtgpoHT+NTJAkA5GMHXyhxcvENxEyR/JVGIUBlHr6lz2UJgmslzp5b7IYp96s09jMSeB1mvag26WF1LErNECGAuO+b8PYGbaBa/AkEAyj+Lu3z163pEGq/oC3H4mLE8gvET7sFhIwxFsIIzUfp0nvEmfWuw1YuQmwtJ1NRr91hQUcl/UoSsf3Ov1Bz50QJAe6CH+X4rmCLKa+NaeMqn4Xleqvj3g1tnqfu3ZayWbClUsDzwn49jeD4GPfVamL6P/ggItPpIZHfX/hxKqQdP7A=="

@implementation WOTAlipayManager
+(void)sendAlipayWithServerWithMoney:(NSString *)money{
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = AlipayPartner;
    NSString *seller = AlipaySeller;
    NSString *privateKey = AlipayPrivateKey;
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缺少partner或者seller或者私钥。" delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    WOTOrderModel *order = [[WOTOrderModel alloc] init];
    order.partner = partner;
    order.seller = seller;
    //    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.tradeNO = [[NSUserDefaults standardUserDefaults] objectForKey:@"OUT_TRADE_NO"]; //订单ID（由商家自行制定）
    order.productName = @"新派支付"; //商品标题
    order.productDescription = @"支付新派的服务"; //商品描述
    order.amount = money; //商品价格
    //    order.amount = @"0.01"; //商品价格
    
    order.notifyURL =  [NSString stringWithFormat:@"%@/rmb/third_pay/alipay", HTTPBaseURL]; //回调URL
    
    //下面的参数是固定的，不需要改变
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AlipayScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec### %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        NSLog(@"%@ ####", orderString);
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            NSMutableDictionary * dic0 = [NSMutableDictionary dictionary];
            [dic0 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"OUT_TRADE_NO"] forKey:@"OUT_TRADE_NO"];
            
//            [[GXNetWorkManager shareInstance] getInfoWithInfo:dic0 path:@"/rmb/checkPayed" success:^(NSMutableDictionary *respon) {
//                if ([respon[@"isPayed"] intValue] == 0) {
//                    [MBProgressHUD showSuccess:@"支付失败"];
//                } else {
//                    [MBProgressHUD showSuccess:@"支付成功"];
//                }
//                
//            } failed:^{
//                [MBProgressHUD showSuccess:@"支付失败"];
//            }];
            
        }];
    }
    
    
    
    
    
}

@end
