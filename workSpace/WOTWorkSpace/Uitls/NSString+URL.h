//
//  NSString+URL.h
//  IMAPswift
//
//  Created by Bjyn21 on 15/1/13.
//  Copyright (c) 2015年 bjyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
- (NSString *)UrlEncodedString;
-(NSString *)URLDecodedString:(NSString *)str;
@end
