//
//  MBProgressHUD+Extension.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/9/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

-(void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay complete:(Complete)complete
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@(animated) forKey:@"animated"];
    [dic setValue:complete forKey:@"complete"];
    [self performSelector:@selector(hideDelayedAndComplete:) withObject:dic afterDelay:delay];
}

- (void)hideDelayedAndComplete:(NSDictionary *)userInfo {
    [self hide:[userInfo[@"animated"] boolValue]];
    Complete com = userInfo[@"complete"];
    if (com) {
        com();
    }
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view hide:(BOOL)animated afterDelay:(NSTimeInterval)delay complete:(Complete)complete
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    if(message==nil || [message isEqualToString:@""])
    {
        hud.labelText = @"MBProgressHUDUtil收到的message为空";
    }
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3 complete:complete];
}


@end
