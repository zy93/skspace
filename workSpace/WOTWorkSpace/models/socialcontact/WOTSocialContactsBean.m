
//
//  WOTSocialContactsBean.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSocialContactsBean.h"

@implementation WOTSocialContactsBean

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _content = dictionary[@"content"];
        _contactname= dictionary[@"contactname"];
        _time = dictionary[@"time"];
        _imageNames = dictionary[@"imageName"];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
