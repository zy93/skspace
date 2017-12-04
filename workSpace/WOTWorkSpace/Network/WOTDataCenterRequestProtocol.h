//
//  WOTDataCenterRequestProtocol.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol WOTDataCenterRequestProtocol<NSObject>
+(void)loginWithTelOrEmail:(NSString *)account withPassWord:(NSString *)passWord andBlock:(void(^)(NSError *error,WOTLoginModel *modelDic))block;
@end
