//
//  WOTFilterTypeModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTFilterTypeModel.h"

@implementation WOTFilterTypeModel

- (instancetype)initWithName:(NSString *)filterName andId:(NSString *)filterId
{
    self = [super init];
    if (self) {
        self.filterId = filterId;
        self.filterName = filterName;
    }
    return self;
}
@end
