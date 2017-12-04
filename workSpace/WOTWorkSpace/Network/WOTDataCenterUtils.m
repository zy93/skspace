
//
//  WOTDataCenterUtils.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTDataCenterUtils.h"
#import "WOTLoginRequest.h"

@implementation WOTDataCenterUtils
+(void)loginWithTelOrEmail:(NSString *)account withPassWord:(NSString *)passWord andBlock:(void(^)(NSError *error,WOTLoginModel *modelDic))block{
    WOTLoginRequest *loginrequest = [[WOTLoginRequest alloc]init];
   NSDictionary *parameter = @{@"tel" :account, @"password":[WOTUitls md5HexDigestByString:passWord]};
 
    [loginrequest doRequestWithParameters:parameter andBlock:^(id responseObject, NSError *error) {
        if (error) {
            block(error,nil);
        }
        if (responseObject != nil) {
            block(nil,(WOTLoginModel *)responseObject);
        }
    }];
}


@end
