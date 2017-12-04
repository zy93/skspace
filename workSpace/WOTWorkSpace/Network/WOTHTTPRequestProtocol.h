//
//  WOTHTTPRequestProtocol.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol WOTHTTPRequestProtocol <NSObject>
-(NSString*)url;
-(JSONModel*)responseObjectWithDictionary:(NSDictionary*)dic;
@end
