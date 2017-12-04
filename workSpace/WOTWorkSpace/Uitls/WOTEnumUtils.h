//
//  WOTEnumUtils.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTEnumUtils : NSObject
-(WOT3DBallVCType)Wot3DballVCtypeenumToString:(NSString *)ballTitle;
-(NSString *)WOTFeedBackStateToString:(NSInteger)state;

@end
