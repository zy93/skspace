//
//  WOTHTTPNetRequest.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTHTTPNetRequest : NSObject
-(void)doRequestWithParameters:(NSDictionary *)parameters andBlock:(void(^)(id responseObject,NSError *error))block;
@end
