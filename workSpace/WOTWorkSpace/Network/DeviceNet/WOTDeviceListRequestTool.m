
//
//  WOTDeviceListRequestTool.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTDeviceListRequestTool.h"
#import "WOTDeviceRequestTool.h"
#import "WOTDeviceInfoModel.h"
@interface WOTDeviceListRequestTool()<WOTRequestToolDelegate
>
@property(nonatomic,copy) WOTDeviceBlock deviceBlock;
@property(nonatomic,strong) WOTDeviceRequestTool *allDeviceRequest;
@end
@implementation WOTDeviceListRequestTool

-(void)sendRequestToGetAllDeviceWithGroupId:(NSNumber *)groupId Response:(WOTDeviceBlock)deviceBlock{
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
//       [[WOTUserSingleton shareUser]setValues];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.deviceBlock = deviceBlock;
            self.allDeviceRequest = [WOTDeviceRequestTool new];
            [self.allDeviceRequest sendGetRequestWithExStr:@"Service_Platform/group/deviceList.do" andParam:@{@"userId":[WOTUserSingleton shareUser].userInfo.userId,@"groupId":groupId}];
            self.allDeviceRequest.delegate = self;
        });
   });
    
}
-(void)requestTool:(WOTDeviceRequestTool *)requestTool isSuccess:(BOOL)isSuccess dict:(NSDictionary *)dict{
    if (requestTool == self.allDeviceRequest) {
        NSArray *arr = dict[@"data"];
        NSMutableArray *mutaArr;
        if (arr) {
            mutaArr = [NSMutableArray array];
            for (NSDictionary *dicIn in arr) {
                WOTDeviceInfoModel *info = [WOTDeviceInfoModel new];
                [info setValuesForKeysWithDictionary:dicIn];
#pragma mark域名替换
                //图片url
                if ([info.picUrl containsString:@"123.56.197.113"]) {
                    info.picUrl = [[info.picUrl stringByReplacingOccurrencesOfString:@"http:/123.56.197.113/" withString:HTTP_HOST]stringByReplacingOccurrencesOfString:@"http://123.56.197.113/" withString:HTTP_HOST];
                }
                //港ip
                if ([info.harborIp containsString:@"101.201.30.234"]) {
                    info.harborIp = [[info.harborIp stringByReplacingOccurrencesOfString:@"101.201.30.234:8080" withString:SOCKET_HOST]stringByReplacingOccurrencesOfString:@"101.201.30.234" withString:SOCKET_HOST];
                    
                }
                [mutaArr addObject:info];
            }
        }
        if (self.deviceBlock) {
            self.deviceBlock([mutaArr copy]);
        }
        
    }
}

@end
