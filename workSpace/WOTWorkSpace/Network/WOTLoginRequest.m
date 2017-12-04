//
//  WOTLoginRequest.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTLoginRequest.h"

@interface WOTLoginRequest()
@end
@implementation WOTLoginRequest

-(NSString *)url{
    return [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"workSpace/Login/Login"];
}

-(JSONModel*)responseObjectWithDictionary:(NSDictionary*)dic
{
    WOTLoginModel *loginResponse;
    
    @try {
         loginResponse = [[WOTLoginModel alloc]initWithDictionary:dic error:nil];
    }
    @catch (NSException *exception) {
        //获取到的异常信息，可以通过发送邮件等方式进行处理
        NSLog(@"%s\n%@", __FUNCTION__, exception);
    }
    @finally {
        NSLog(@"login json convert to login response failed!");
    }
    
    return loginResponse;
}
@end
