//
//  WOTWordSpaceRequest.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTWordSpaceRequest.h"
#import "WOTSpaceModel.h"
@implementation WOTWordSpaceRequest
-(NSString *)url{
    return [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"workSpace/Space/findAllSpace"];
}

-(JSONModel*)responseObjectWithDictionary:(NSDictionary*)dic
{
    WOTSpaceModel_msg *response;
    
    @try {
        response = [[WOTSpaceModel_msg alloc]initWithDictionary:dic error:nil];
    }
    @catch (NSException *exception) {
        //获取到的异常信息，可以通过发送邮件等方式进行处理
        NSLog(@"%s\n%@", __FUNCTION__, exception);
    }
    @finally {
        NSLog(@"login json convert to login response failed!");
    }
    
    return response;
}
@end
