//
//  WOTAlipayManager.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTAlipayManager : NSObject
+(void)sendAlipayWithServerWithMoney:(NSString *)money;
@end
