//
//  WOTWordSpaceRequest.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WOTHTTPNetRequest.h"
#import "WOTHTTPRequestProtocol.h"
@interface WOTWordSpaceRequest : WOTHTTPNetRequest<WOTHTTPRequestProtocol>
-(NSString *)url;

-(JSONModel*)responseObjectWithDictionary:(NSDictionary*)dic;
@end
