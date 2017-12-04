//
//  WOTFilterTypeModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTFilterTypeModel : NSObject
@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, copy) NSString *filterId;

- (instancetype)initWithName:(NSString *)filterName andId:(NSString *)filterId;
@end
