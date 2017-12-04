//
//  WOTLoginRequest.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetRequest.h"
#import <JSONModel/JSONModel.h>
#import "WOTHTTPRequestProtocol.h"
#import "WOTLoginModel.h"


@interface WOTLoginRequest : WOTHTTPNetRequest<WOTHTTPRequestProtocol>
-(NSString *)url;

-(JSONModel*)responseObjectWithDictionary:(NSDictionary*)dic;
@end
