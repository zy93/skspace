//
//  WOTWXApiManager.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTWXApiManager.h"


@implementation WOTWXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WOTWXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WOTWXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
    
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    NSMutableDictionary * dic0 = [NSMutableDictionary dictionary];
    [dic0 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"OUT_TRADE_NO"] forKey:@"OUT_TRADE_NO"];
    
//    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic0 path:@"/rmb/checkPayed" success:^(NSMutableDictionary *respon) {
//        
//        NSLog(@"支付结果%@", respon);
//        
//        
//        
//    } failed:^{
//        [MBProgressHUD showSuccess:@"支付失败"];
//    }];
    
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询。，此时可以去调用服务器端接口，服务器如果返回支付成功才是真的支付成功
        NSString *strMsg = nil,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                //                WXSuccess           = 0,    /**< 成功    */
                //                WXErrCodeCommon     = -1,   /**< 普通错误类型    */
                //                WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
                //                WXErrCodeSentFail   = -3,   /**< 发送失败    */
                //                WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
                //                WXErrCodeUnsupport  = -5,
            case WXErrCodeCommon:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            case WXErrCodeSentFail:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            case WXErrCodeAuthDeny:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            case WXErrCodeUnsupport:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            default:
                //                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                strMsg = [NSString stringWithFormat:@"支付结果：失败！"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        /*
        UIAlertController *alertController;
        alertController = [UIAlertController alertControllerWithTitle:strTitle message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //TODO:
        }];
        [alertController addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //TODO:
        }];
        [alertController addAction:confirmAction];
      
//        [self presentViewController:alertController animated:YES completion:^{
//            // TODO
//        }];
        */
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"clickButtonAtIndex:%d",(int)buttonIndex);
    //index为-1则是取消，
    NSLog(@"点击了");
    NSNotification *LoseResponse = [NSNotification notificationWithName:@"buttonLoseResponse" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:LoseResponse];

}


- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

@end
